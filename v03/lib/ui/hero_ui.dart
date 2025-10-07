// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:io';
import 'package:v03/managers/hero_repository.dart';
import 'package:v03/ui/application.dart';
import 'package:v03/utils/console_utils.dart';
import 'package:v03/utils/input_utils.dart';
import 'package:v03/validators/get_valid_int.dart';

class HeroUI {

  HeroRepository heroRepo = HeroRepository();
  ConsoleUtils consoleUtils = ConsoleUtils();
  GetValidInt getValidInt = GetValidInt();
  InputUtils inputUtils = InputUtils();
  Application app = Application();

  // Function to add hero
  void addHeroUI() {
  String heroName = "";
  int heroStrength = 0;
  String heroSpecies = "";
  String heroAlignment = "";

  consoleUtils.clearConsole();
  print("Lägg till hjälte");
  print("******************\n");

  // Ask for name
  while (true) {
    stdout.writeln("Vad har superhjälten för namn \n(vid flera ord separera med ett mellanslag)?");
    heroName = stdin.readLineSync()?.trim() ?? "";
    if (heroName.isNotEmpty) break;

    consoleUtils.clearConsole();
    print("Du måste skriva något. Vänligen försök igen.");
  }

  // Ask for strength
  heroStrength = getValidInt.getValidIntWithLoopMaxTwenty("Vad har superhjälten för styrka (ange heltal mellan 1-20)?");

  // Ask for species
  print("Vad är superhjälten för art?");
  print("""
  1. Människa
  2. Mutant
  3. Halvgudinna
  4. Halvgud
  5. Himmelskt väsen
  6. Utomjording
  7. Djur
  8. Cyborg/robot
  9. Magisk varelse
  10. Fantasi-varelser
  11. Andra icke-mänskliga arter
  """);

  while (heroSpecies.isEmpty) {
    String speciesChoice = stdin.readLineSync()?.trim() ?? "";
    switch (speciesChoice) {
      case "1": heroSpecies = "Human"; break;
      case "2": heroSpecies = "Mutant"; break;
      case "3": heroSpecies = "Demigoddess"; break;
      case "4": heroSpecies = "Demigod"; break;
      case "5": heroSpecies = "Celestial"; break;
      case "6": heroSpecies = "Alien"; break;
      case "7": heroSpecies = "Animal"; break;
      case "8": heroSpecies = "Cyborg/robot"; break;
      case "9": heroSpecies = "Magical creature"; break;
      case "10": heroSpecies = "Fantasy creature"; break;
      case "11": heroSpecies = "Other non-human species"; break;
      default:
        print("Valet finns inte, vänligen försök igen.");
    }
  }

  // Ask for alignment
  print("Vad har superhjälten för moral?");
  print("""
1. God
2. Ond
3. Diskutabel
""");

  while (heroAlignment.isEmpty) {
    String alignmentChoice = stdin.readLineSync()?.trim() ?? "";
    switch (alignmentChoice) {
      case "1": heroAlignment = "Good"; break;
      case "2": heroAlignment = "Evil"; break;
      case "3": heroAlignment = "Debatable"; break;
      default:
        print("Valet finns inte, vänligen försök igen.");
    }
  }

  // Add hero to List
  heroRepo.addHero(inputUtils.capitalizeAllWords(heroName), heroStrength, heroSpecies, heroAlignment);

  // Confirm and show hero
  consoleUtils.clearConsole();
  print("Hjälten är tillagd!\n");
  var lastHeroAdded = heroRepo.heroesList.last;
  print(heroRepo.heroToString(lastHeroAdded));
  print("\nTryck Enter för att fortsätta.");
  stdin.readLineSync();
}

  // Function to show all the heroes, sorted by strongest
  void showHerosUI(){
    consoleUtils.clearConsole();

    // Get all heros saved in list
    print("Alla hjältar i listan. Sorterat efter styrka (starkast först).");
    print("**************************************************************\n");
    var allHeros = heroRepo.getAllHeros();

    // Sort by strength
    allHeros.sort((a, b) =>
    b["powerstats"]["strength"].compareTo(a["powerstats"]["strength"]));

    // Print all 
    allHeros.forEach((hero) => print(heroRepo.heroToString(hero)));

    //********** More recommended to use for loop which would work like this but
    //********** assigment stated to use forEach so that was used
    // for (var hero in allHeros) {
    //   print("---------------------");
    //   stdout.writeln("${allHeros.indexOf(hero)+1}. ");
    //   print(heroRepo.heroToString(hero));
    // }

    print("Tryck Enter för att komma tillbaka till menyn");
    stdin.readLineSync();
  }

  // Function to search for a hero in saved heroes
  void searchHeroUI(){
    while (true) {
      consoleUtils.clearConsole();
      
      // Promt to user   
      print("Skriv ett namn (eller en bokstav) på en hjälte och se om dom finns i systemet");
      print("******************************************************************************\n");
      
      // Taking in input from user
      String input = stdin.readLineSync()?.trim() ?? "";
      String heroName = inputUtils.capitalizeAllWords(input);

      if(input.isNotEmpty){
        // Fetch all heros and search hero based on user input
        var allHeros = heroRepo.getAllHeros();
        var selectedHero = allHeros.where((hn) =>
        hn["name"].contains(heroName));

        if(selectedHero.isNotEmpty){
          // Print out all the heros that match the search
          selectedHero.forEach((hero) => print(heroRepo.heroToString(hero)));

          //********** More recommended to use for loop which would work like this but
          //********** assigment stated to use forEach so that was used
          // for (var hero in selectedHero) {
          //   print(heroRepo.heroToString(hero));
          // }

          // Check if user wants to do new search
          print("Vill du göra en ny sökning? (ja/nej)");
          while (true) {      
            var userInput = stdin.readLineSync()?.trim().toLowerCase() ?? "";

            if (userInput == "ja") {
              break;
            }
            else if(userInput == "nej"){
              app.startMenu();
            }
            else{
              print("Du måste skriva ja eller nej, var god försök igen:");
            }
          }
        }else{
          print("Det finns ingen hjälte som matchar din sökning...");
          sleep(Duration(seconds: 3));         
        }
      }else{
        print("Du måste skriva något...");
        sleep(Duration(seconds: 2));
      }
    }
  }
}