import 'dart:convert';
import 'dart:io';

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
  final List<HeroModel> _heroesList = [];
  
  @override
  Future<HeroModel> createHero(HeroModel hero) async {
    _heroesList.add(hero);
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
  Future<void> deleteHero(int id) async {
    _heroesList.removeWhere((h) => h.heroId == id);
  }
  
  // TODO check if works as expected
  @override
  Future<HeroModel> updateHero(HeroModel updatedHero) async {
    final index = _heroesList.indexWhere((h) => h.heroId == updatedHero.heroId);
    if (index == -1) {
      throw Exception("Hero with ID ${updatedHero.heroId} not found");
    }
    _heroesList[index] = updatedHero;
    return updatedHero;
  }
  
  // @override
  // Future<HeroModel?> getHeroById(int id) async {
  //   return _heroesList.firstWhere((h) => h.heroId == id, orElse: () => null);
  // }

}