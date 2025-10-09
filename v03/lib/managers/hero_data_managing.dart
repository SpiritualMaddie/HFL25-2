import 'package:v03/data/models/hero_model.dart';

//TODO
// Skapa en abstract class HeroDataManaging och fundera vad som kommer krävas?
// Vilka funktioner behöver jag kunna kräva och kanske mocka/testa med egen data? 
// Vilka variabler kan kanske behövas?
// Vad mer? 

abstract class HeroDataManaging {

  Future<HeroModel> createHero(HeroModel hero);
  Future<List<HeroModel>> getAllHeroes();
  Future<List<HeroModel>> getHeroByName(String heroName);
  //Future<HeroModel?> getHeroById(int id);
  Future<HeroModel> updateHero(HeroModel updatedHero);
  Future<void> deleteHero(int id);
}