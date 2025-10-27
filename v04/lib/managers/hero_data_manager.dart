import 'dart:convert';
import 'dart:io';
import 'package:dotenv/dotenv.dart' as dotenv;
import 'package:http/http.dart' as http;
import 'package:v04/data/models/hero_model.dart';
import 'package:v04/data/repositories/super_hero_api_repository.dart';
import 'package:v04/data/repositories/local_file_repository.dart';
import 'package:v04/interfaces/hero_data_managing.dart';

class HeroDataManager implements HeroDataManaging{

  // Private constructor for Singleton
  HeroDataManager._internal();

  // Single static instance
  static final HeroDataManager _instance = HeroDataManager._internal();

  // Public accessor of the Singleton
  factory HeroDataManager() => _instance;

  // List of heroes
  final List<HeroModel> _heroesList = [];

  final LocalFileRepository localFileRepo = LocalFileRepository(localFilePath: "lib/data/hero_mock_data.json");
  final SuperHeroApiRepository apiHeroRepo = SuperHeroApiRepository();

  // Env
  final env = dotenv.DotEnv()..load();
  
  // TODO thinks it works
  @override
  Future<void> createHero(HeroModel hero) async {

    // TODO - how to make sure ids dont collide with superhero api heroes, change id for local list?
    final heroAlreadyExists = _heroesList.any((h) => h.name.toLowerCase() == hero.name.toLowerCase());

    if(heroAlreadyExists){
      print("⚠️ Hjälten/Skurken '${hero.name}' finns redan, kan inte spara dublett.");
      return;
    }

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
    print("💾 Hjälte/skurk sparad: \n${hero.toString()}");
  }
  
  // TODO better error handling
  @override
  Future<List<HeroModel>> getAllHeroesLocal() async {
    return _heroesList;
  }
  
  // TODO better error handling
  @override
  Future<List<HeroModel>> getHeroByNameLocal(String heroName) async {
    final search = heroName.toLowerCase();
    return _heroesList
        .where((h) => h.name.toLowerCase().contains(search))
        .toList();
  }
  
  // TODO better error handling
  @override
  Future<List<HeroModel>> getHeroByNameApi(String heroName) async {
    return apiHeroRepo.getHeroByName(heroName);
  }
  
  // Delete hero prepered function 
  // TODO better error handling
  @override
  Future<void> deleteHero(int id) async {
    _heroesList.removeWhere((h) => h.heroId == id);
  }
  
  // TODO try it
  @override
  Future<Map<String, List<HeroModel>>> sortedHeroesVillains() async {
    final heroes = _heroesList
        .where((h) => h.biography.alignment.toLowerCase() == "good")
        .toList();

    final villains = _heroesList
        .where((v) => v.biography.alignment.toLowerCase() == "bad")
        .toList();

    return {
      "heroes": heroes,
      "villains": villains,
    };
  }
  
  // TODO is this try catch redudant?
  @override
  Future<void> loadHeroesFromJsonToHeroesList() async {
    try {
      final parsedJsonHeroes = await localFileRepo.readLocalHeroFile();

      _heroesList.clear();
      _heroesList.addAll(parsedJsonHeroes);

      print("✅ Laddade ${_heroesList.length} hjältar och skurkar från lokal JSON.");
      sleep(Duration(seconds: 2)); // TODO spinner?
      // print("Första på listan:\n${_heroesList.first}");
      // print("Sista på listan:\n${_heroesList.last}");
    } catch (e) {
      print("❌ Misslyckades att ladda hjältar och skurkar: $e");
    }
  }
  
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