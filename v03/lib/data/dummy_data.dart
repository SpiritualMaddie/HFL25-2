import 'package:v03/data/models/hero_model.dart';
import 'package:v03/managers/hero_data_manager.dart';
import 'package:v03/managers/hero_repository.dart';
import 'dart:io';
import 'dart:convert';

class DummyData {
    HeroRepository heroRepo = HeroRepository();
    HeroDataManager dataManager = HeroDataManager();

  //   void dummyData(){

  //   heroRepo.addHero("Green Arrow", 8, "Human", "Good");
  //   heroRepo.addHero("Wonder Woman", 15, "Demigoddess", "Good");
  //   heroRepo.addHero("Dr Strange", 8, "Human", "Good");
  //   heroRepo.addHero("Moon Knight", 15, "Human", "Debatable");
  // }

  void dummydata(){
    //dataManager.createHero(HeroModel(name: name, powerstats: powerstats, biography: biography, appearance: appearance, image: image));
  }


}