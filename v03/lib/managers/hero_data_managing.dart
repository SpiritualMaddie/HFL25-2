import 'package:v03/data/models/hero_model.dart';

abstract class HeroDataManaging {

  Future<HeroModel> createHero(HeroModel hero);
  Future<List<HeroModel>> getAllHeroes();
  Future<List<HeroModel>> getHeroByName(String heroName);
  //Future<HeroModel?> getHeroById(int id);
  Future<HeroModel> updateHero(HeroModel updatedHero);
  Future<void> deleteHero(int id);
}