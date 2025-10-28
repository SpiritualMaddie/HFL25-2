import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dotenv/dotenv.dart' as dotenv;
import 'package:v04/data/models/hero_model.dart';
import 'package:v04/interfaces/isuper_hero_api_repository.dart';

class SuperHeroApiRepository implements ISuperHeroApiRepository{

  // Env
  final _env = dotenv.DotEnv()..load();
  
  // Function to get hero/villian by name from the API https://superheroapi.com/ that reads from the .env for the API key
  @override
  Future<List<HeroModel>> getHeroByName(String heroName) async {

    final baseUrl = _env["API_URL_WITH_KEY"];

    if(baseUrl == null || baseUrl.isEmpty){
      throw Exception("❌ Saknas 'API_URL_WITH_KEY' i '.env'");
    }

    try {
      final serachUrl = Uri.parse("$baseUrl/search/$heroName");
      final response = await http.get(serachUrl);
      
      if(response.statusCode == 200){
        final jsonBody = jsonDecode(response.body);

        // TODO change error handling for more statuscodes and if repsonse != success
        if(jsonBody == null || jsonBody["response"] != "success"){
          return [];
        }

        final List<dynamic> results = jsonBody["results"];
        return results
              .map((item) => HeroModel.fromJson(item as Map<String, dynamic>))
              .toList();
      }
      else{
        print("❌ Request misslyckades med status: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("❌ Error i hämtande av hjälte/skurk: $e");
      return [];
    }
  }
}
