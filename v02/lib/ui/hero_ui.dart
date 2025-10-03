import 'dart:io';
import 'package:v02/repositories/hero_repository.dart';
import 'package:v02/ui/application.dart';
import 'package:v02/utils/console_utils.dart';
import 'package:v02/utils/input_utils.dart';

class HeroUI {

  HeroRepository heroRepo = HeroRepository();
  InputUtils inputUtils = InputUtils();
  ConsoleUtils consoleUtils = ConsoleUtils();
  Application app = Application();

  void addHeroUI(){
    consoleUtils.clearConsole();
    print("Lägg till hjälte - användaren skriver in namn, styrka (int), och kanske en specialkraft.");
    print("**************************************************************\n");
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
      print("*******************************************************************************\n");
      
      // Taking in input from user
      String input = stdin.readLineSync()?.trim() ?? "";
      String heroName = inputUtils.capitalizeTwoWords(input);

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