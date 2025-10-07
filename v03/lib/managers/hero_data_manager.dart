import 'package:v03/data/models/hero_model.dart';
import 'package:v03/managers/hero_data_managing.dart';

//TODO
// Skapa en singleton HeroDataManager som extends HeroDataManaging, använd factory.
// Klassen ska innehålla en lista som tar datatypen HeroModel. 
// ( Har du byggt en lokal sparning / databas använd den )
// Implementera funktioner som, saveHero, getHeroList, searchHero som blir ett krav.
// Viktigt med Future och async - await och bygg det med snyggast user experience.
// Använd den överallt i appen där nåt med hero data behöver hanteras.. 

class HeroDataManager implements HeroDataManaging{

  // Private constructor for Singleton
  HeroDataManager._internal();

  // Single static instance
  static final HeroDataManager _instance = HeroDataManager._internal();

  // Public accessor of the Singleton
  factory HeroDataManager() => _instance;

  // List of heroes
  late List<HeroModel> heroesList;
  
  @override
  Future<HeroModel> createHero(HeroModel hero) {
    // TODO: implement createHero
    throw UnimplementedError();
  }
  
  @override
  Future<List<HeroModel>> getAllHeroes() {
    // TODO: implement getAllHeroes
    throw UnimplementedError();
  }
  
  @override
  Future<List<HeroModel?>> getHeroByName(String heroName) {
    // TODO: implement getHeroByName
    throw UnimplementedError();
  }


  
}