import 'package:v04/data/models/hero_model.dart';

abstract class HeroDataManaging {

  Future<void> createHero(HeroModel hero);
  Future<List<HeroModel>> getAllHeroesLocal();
  Future<List<HeroModel>> getHeroByNameLocal(String heroName);
  Future<List<HeroModel>> getHeroByNameApi(String heroName);
  Future<Map<String, List<HeroModel>>> sortedHeroesVillains();
  Future<void> loadHeroesFromJsonToHeroesList();
  Future<void> deleteHero(int id);
  //Future<HeroModel?> getHeroById(int id);
  //Future<HeroModel> updateHero(HeroModel updatedHero);
}