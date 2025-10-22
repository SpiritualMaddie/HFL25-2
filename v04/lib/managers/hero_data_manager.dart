import 'dart:convert';
import 'package:dotenv/dotenv.dart' as dotenv;
import 'package:http/http.dart' as http;
import 'package:v04/data/models/hero_model.dart';
import 'package:v04/managers/hero_data_managing.dart';

class HeroDataManager implements HeroDataManaging{

  // Private constructor for Singleton
  HeroDataManager._internal();

  // Single static instance
  static final HeroDataManager _instance = HeroDataManager._internal();

  // Public accessor of the Singleton
  factory HeroDataManager() => _instance;

  // List of heroes
  final List<HeroModel> _heroesList = [];

  // Env
  final env = dotenv.DotEnv()..load();
  
  @override
  Future<HeroModel> createHero(HeroModel hero) async {
    // Auto-increment ID adding +1 from the highest existing ID
    int newId = _heroesList.isEmpty 
                ? 1 
                : _heroesList.last.heroId + 1; // - Auto-increment ID based on the last hero in the list
              //  : _heroesList.map((h) => h.heroId).reduce((a, b) => a > b ? a : b) + 1; // - Auto-increment ID based on the last hero in the json

    final newHero = HeroModel(
      heroId: newId,
      name: hero.name,
      powerstats: hero.powerstats,
      biography: hero.biography,
      appearance: hero.appearance,
      image: hero.image,
      work: hero.work,
      connections: hero.connections,
    );
    _heroesList.add(newHero);
    return hero;
  }
  
  @override
  Future<List<HeroModel>> getAllHeroes() async {
    return _heroesList;
  }
  
  @override
  Future<List<HeroModel>> getHeroByName(String heroName) async {
    final search = heroName.toLowerCase();
    return _heroesList
        .where((h) => h.name.toLowerCase().contains(search))
        .toList();
  }
  
  @override
  Future<List<HeroModel>> getHeroByNameApi(String heroName) async {
    final baseUrl = env["API_URL_WITH_KEY"];
    if(baseUrl == null || baseUrl.isEmpty){
      throw Exception("❌ Missing API_URL_WITH_KEY in .env");
    }

    try {
      final serachUrl = Uri.parse("$baseUrl/search/$heroName");
      final response = await http.get(serachUrl);
      
      if(response.statusCode == 200){
        final jsonBody = jsonDecode(response.body);

        if(jsonBody == null || jsonBody["response"] != "success"){
          print("⚠️ No heroes found for '$heroName'.");
          return [];
        }

        final List<dynamic> results = jsonBody["results"];
        return results
              .map((item) => HeroModel.fromJson(item as Map<String, dynamic>))
              .toList();
      }
      else{
        print("❌ Request failed with status: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("💥 Error fetching hero: $e");
      return [];
    }
  }

  // Delete hero prepered function 
  // @override
  // Future<void> deleteHero(int id) async {
  //   _heroesList.removeWhere((h) => h.heroId == id);
  // }
  
  // Update hero prepered function
  // @override
  // Future<HeroModel> updateHero(HeroModel updatedHero) async {
  //   final index = _heroesList.indexWhere((h) => h.heroId == updatedHero.heroId);
  //   if (index == -1) {
  //     throw Exception("Hero with ID ${updatedHero.heroId} not found");
  //   }
  //   _heroesList[index] = updatedHero;
  //   return updatedHero;
  // }
  
  // Get hero by id prepered function
  // @override
  // Future<HeroModel?> getHeroById(int id) async {
  //   return _heroesList.firstWhere((h) => h.heroId == id, orElse: () => null);
  // }

}