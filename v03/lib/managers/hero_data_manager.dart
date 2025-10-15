import 'package:v03/data/models/hero_model.dart';
import 'package:v03/managers/hero_data_managing.dart';

class HeroDataManager implements HeroDataManaging{

  // Private constructor for Singleton
  HeroDataManager._internal();

  // Single static instance
  static final HeroDataManager _instance = HeroDataManager._internal();

  // Public accessor of the Singleton
  factory HeroDataManager() => _instance;

  // List of heroes
  final List<HeroModel> _heroesList = [];
  
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