import 'package:v02/repositories/hero_repository.dart';
class DummyData {
    HeroRepository heroRepo = HeroRepository();

    void dummyData(){

    heroRepo.addHero(1, "Green Arrow", 8, "Human", "Good");
    heroRepo.addHero(2, "Wonder Woman", 15, "Demigoddess", "Good");
    heroRepo.addHero(3, "Dr Strange", 8, "Human", "Good");
    heroRepo.addHero(4, "Moon Knight", 15, "Human", "Debatable");

  }
}