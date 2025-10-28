import 'package:v04/data/models/hero_model.dart';

abstract interface class ISuperHeroApiRepository{
  
  Future<List<HeroModel>> getHeroByName(String name);
}