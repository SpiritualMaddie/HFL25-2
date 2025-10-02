import 'dart:io';
import 'package:v02/repositories/hero_repository.dart';

class HeroUI {

  HeroRepository heroRepo = HeroRepository();

  void addHeroUI(){
    print("Lägg till hjälte - användaren skriver in namn, styrka (int), och kanske en specialkraft.");
  }

  void showHerosUI(){
    print("Visa hjältar - skriv ut alla hjältar i listan. Sortera dem efter styrka (starkast först).");
    heroRepo.getAllHeros().forEach(print);
    stdin.readLineSync();
  }

  void searchHeroUI(){
    print("Sök hjälte - låt användaren skriva in en bokstav eller ett namn och visa matchande hjältar.");
  }
}