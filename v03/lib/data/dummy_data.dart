import 'package:v03/managers/hero_repository.dart';

class DummyData {
    HeroRepository heroRepo = HeroRepository();

    void dummyData(){

    heroRepo.addHero("Green Arrow", 8, "Human", "Good");
    heroRepo.addHero("Wonder Woman", 15, "Demigoddess", "Good");
    heroRepo.addHero("Dr Strange", 8, "Human", "Good");
    heroRepo.addHero("Moon Knight", 15, "Human", "Debatable");

  }
}