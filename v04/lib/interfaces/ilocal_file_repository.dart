import 'package:v04/data/models/hero_model.dart';

abstract interface class ILocalFileRepository{
  
  Future<void> updateLocalHeroFile(List<HeroModel> heroesList);
  Future<List<HeroModel>> readLocalHeroFile(); 
}