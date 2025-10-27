import 'dart:convert';

import 'package:dotenv/dotenv.dart' as dotenv;
import 'package:http/http.dart' as http;
import 'package:v04/data/models/hero_model.dart';
import 'package:v04/interfaces/isuper_hero_api_repository.dart';

class SuperHeroApiRepository implements ISuperHeroApiRepository{

  // Env
  final env = dotenv.DotEnv()..load();
  
  @override
  Future<List<HeroModel>> getHeroByName(String heroName) async {

    final baseUrl = env["API_URL_WITH_KEY"];

    if(baseUrl == null || baseUrl.isEmpty){
      throw Exception("❌ Saknas 'API_URL_WITH_KEY' i '.env'");
    }

    try {
      final serachUrl = Uri.parse("$baseUrl/search/$heroName");
      final response = await http.get(serachUrl);
      
      if(response.statusCode == 200){
        final jsonBody = jsonDecode(response.body);

        if(jsonBody == null || jsonBody["response"] != "success"){
          print("⚠️ Inga hjältar eller skurkar hittades för: '$heroName'.");
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
      print("💥 Error i hämtande av hjälte/skurk: $e");
      return [];
    }
  }
}
