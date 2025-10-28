import 'dart:io';
import 'dart:convert';
import 'package:dotenv/dotenv.dart' as dotenv;
import 'package:v04/data/models/hero_model.dart';
import 'package:v04/interfaces/ihttp_client_factory.dart';
import 'package:v04/interfaces/isuper_hero_api_repository.dart';

class SuperHeroApiRepository implements ISuperHeroApiRepository{
  final String baseUrl;
  final IHttpClientFactory clientFactory;
  
  // Create and load dotenv instance
  static final dotenvEnv = dotenv.DotEnv(includePlatformEnvironment: true)..load();

  SuperHeroApiRepository({
    required this.clientFactory,
    String? envBaseUrl,
  }) : baseUrl = envBaseUrl ?? (dotenvEnv['API_URL_WITH_KEY'] ?? ""){
    if(baseUrl.isEmpty){
      throw Exception("❌ baseUrl är tomt.");
    }
  }
  
  // Function to get hero/villian by name from the API https://superheroapi.com/ that reads from the .env for the API key
  @override
  Future<List<HeroModel>> getHeroByName(String heroName) async {

    final searchUrl = Uri.parse("$baseUrl/search/$heroName");
    
      try {
        for(int attempt = 0; attempt < 3; attempt++){
          final client = clientFactory.create();
          try {
            final response = await client
              .get(searchUrl)
              .timeout(const Duration(seconds: 10));
           if(response.statusCode == 200){
            return _parseHeroes(response.body);       
          }
          else{
            print("❌ Request misslyckades med status: ${response.statusCode}");
            // return [];
          } 
          } finally {
              client.close();
          }
              
          if(attempt <2) await Future.delayed(const Duration(seconds: 2));
        }
      } on FormatException catch (e){ // JSON decode or unexpected body
          print("❌ Fel vid tolkning av JSON: $e");
          return [];
      } on SocketException catch (e){ // No internet or DNS issue
          print("❌ Nätverksfel: $e");
          return [];
      } catch (e, stack) {            // Catch everything else
          print("❌ Oväntat fel: $e");
          print("Stacktrace: $stack");
          return [];
      }
    return [];
  }

  Future<List<HeroModel>> _parseHeroes(String responseBody) async {
    final jsonBody = jsonDecode(responseBody);

    if (jsonBody == null || jsonBody["response"] != "success") return [];

    final List<dynamic> results = jsonBody["results"];

    return results
              .map((item) => HeroModel
              .fromJson(Map<String, dynamic>.from(item)))
              .toList();
  }

}
