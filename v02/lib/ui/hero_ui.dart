import 'dart:io';
import 'package:v02/repositories/hero_repository.dart';
import 'package:v02/utils/input_utils.dart';

class HeroUI {

  HeroRepository heroRepo = HeroRepository();
  InputUtils inputUtils = InputUtils();

  void addHeroUI(){
    print("Lägg till hjälte - användaren skriver in namn, styrka (int), och kanske en specialkraft.");
  }

  void showHerosUI(){
    var allHeros = heroRepo.getAllHeros();
    print("Alla hjältar i listan. Sorterat efter styrka (starkast först).\n");

    // Sort by strength
    allHeros.sort((a, b) =>
    b["powerstats"]["strength"].compareTo(a["powerstats"]["strength"]));

    // Print
    allHeros.forEach((hero) => print(heroRepo.heroToString(hero)));

    print("Tryck Enter för att komma tillbaka till menyn");
    stdin.readLineSync();
  }

// TODO - make sure it works even if its not a perfect match
  void searchHeroUI(){
    print("Sök hjälte - låt användaren skriva in en bokstav eller ett namn och visa matchande hjältar.");
    print("Skriv ett namn (eller en bokstav) på en hjälte och om dom finns i systemet");
    String input = stdin.readLineSync()?.trim() ?? "";
    String heroName = inputUtils.capitalizeTwoWords(input);

    var allHeros = heroRepo.getAllHeros();
    var selectedHero = allHeros.where((hn) =>
    hn["name"].contains(input));

    selectedHero.forEach((hero) => print(heroRepo.heroToString(hero)));

    print("Tryck Enter för att komma tillbaka till menyn");
    stdin.readLineSync();
  }
}