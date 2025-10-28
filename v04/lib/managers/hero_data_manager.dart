import 'package:v04/data/models/hero_model.dart';
import 'package:v04/interfaces/hero_data_managing.dart';
import 'package:v04/data/repositories/local_file_repository.dart';
import 'package:v04/data/repositories/super_hero_api_repository.dart';

class HeroDataManager implements HeroDataManaging{

  // Private constructor for Singleton
  HeroDataManager._internal();

  // Single static instance
  static final HeroDataManager _instance = HeroDataManager._internal();

  // Public accessor of the Singleton
  factory HeroDataManager() => _instance;

  // List of heroes
  final List<HeroModel> _heroesList = [];

  final LocalFileRepository localFileRepo = LocalFileRepository(localFilePath: "lib/data/jsondata/super_hero_json.json");
  final SuperHeroApiRepository apiHeroRepo = SuperHeroApiRepository();
  
  // Function to create new hero/villian with check for if the name already exist and wont create a duplicate
  @override
  Future<HeroModel?> createHero(HeroModel hero) async {

    try {
      final heroAlreadyExists = _heroesList.any((h) => h.name.toLowerCase() == hero.name.toLowerCase());

      if(heroAlreadyExists){     
        return null;
      }

      int newId = _heroesList.isEmpty 
                  ? 1 
                  : _heroesList.last.heroId + 1; // Auto-increment ID based on the last hero in the list

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

      return newHero;      
    } catch (e) {
        throw Exception("❌ Misslyckades att spara hjälte/skurk: $e");
    }

  }
  
  // Function to get all heroes/villians in the local list _heroesList
  @override
  Future<List<HeroModel>> getAllHeroesLocal() async {
    return _heroesList;
  }
  
  // Function to get hero/villian by name in the local list _heroesList
  @override
  Future<List<HeroModel>> getHeroByNameLocal(String heroName) async {
    final search = heroName.toLowerCase();
    return _heroesList
        .where((h) => h.name.toLowerCase().contains(search))
        .toList();
  }
  
  // Function to get hero/villian by name from the api https://superheroapi.com/
  @override
  Future<List<HeroModel>> getHeroByNameApi(String heroName) async {
    return apiHeroRepo.getHeroByName(heroName);
  }
  
  // Function to delete hero/villian from local list _heroesList
  @override
  Future<void> deleteHero(int id) async {
    _heroesList.removeWhere((h) => h.heroId == id);
  }
  
  // Function to sort heroes and villians ans return Map with them sorted
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
  
  // Function to load heroes/villians from the local json file to the _heroesList
  @override
  Future<int> loadHeroesFromJsonToHeroesList() async {
    try {
      final parsedJsonHeroes = await localFileRepo.readLocalHeroFile();

      _heroesList
        ..clear()
        ..addAll(parsedJsonHeroes);

      return _heroesList.length;
    } catch (e) {
      throw Exception("❌ Misslyckades att ladda hjältar och skurkar: $e");
    }
  }
  
  // Function to get a hero/villian by Id in the local list _heroesList
  @override
  Future<HeroModel?> getHeroByIdLocal(int id) async {
    try {
      var hero = _heroesList.firstWhere((h) => h.heroId == id);
      return hero;
    } catch (_) {
      return null;
    }
  }
  
  // Function to update the local json file with the local list _heroesList
  @override
  Future<void> updateJsonWithHeroesList() async {
    try {
      await localFileRepo.updateLocalHeroFile(_heroesList);
    } catch (e) {
      throw Exception("❌ Misslyckades att spara hjältar och skurkar: $e");
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

}