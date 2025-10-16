import 'dart:io';
import 'package:v04/data/models/connections_model.dart';
import 'package:v04/data/models/appearance_model.dart';
import 'package:v04/data/models/powerstats_model.dart';
import 'package:v04/data/models/biography_model.dart';
import 'package:v04/managers/hero_data_manager.dart';
import 'package:v04/validators/get_valid_int.dart';
import 'package:v04/data/models/image_model.dart';
import 'package:v04/data/models/hero_model.dart';
import 'package:v04/data/models/work_model.dart';
import 'package:v04/utils/get_model_input.dart';
import 'package:v04/utils/console_utils.dart';
import 'package:v04/utils/input_utils.dart';
import 'package:v04/ui/application.dart';

class HeroUI {

  final dataManager = HeroDataManager();
  final consoleUtils = ConsoleUtils();
  final getValidInt = GetValidInt();
  final inputUtils = InputUtils();
  final getModelInput = GetModelInput();
  final app = Application();

  // Function to add hero
  Future<void> addHeroUI() async {

    consoleUtils.clearConsole();
    print("Lägg till hjälte");
    print("******************\n");

    // Ask for name
    final heroName = inputUtils.capitalizeAllWords(
      inputUtils.promptNotEmpty("Vad har superhjälten för namn \n(vid flera ord separera med ett mellanslag)?"));

    // Ask for powerstats
    PowerstatsModel powerstats = getModelInput.getPowerStatsInput();

    // Ask for biography
    BiographyModel biography = getModelInput.getBiographyInput();

    // Ask for appearance
    AppearanceModel appearance = getModelInput.getAppearanceInput();

    // Ask for work
    WorkModel? work = getModelInput.getWorkInput();

    // Ask for connections
    ConnectionsModel? connections = getModelInput.getConnectionsInput();

    // Ask for image
    ImageModel image = getModelInput.getImageInput();


    // Create new hero
    final newHero = HeroModel(
      name: heroName, 
      powerstats: powerstats, 
      biography: biography, 
      appearance: appearance, 
      image: image,
      work: work,
      connections: connections
      );

    // Add new hero to heroesList
    await dataManager.createHero(newHero);

    // Confirm and show new hero
    consoleUtils.clearConsole();
    print("💾 Hjälten är tillagd!\n");
    var allHeroes = await dataManager.getAllHeroes();
    var lastHeroAdded = allHeroes.last;
    print(lastHeroAdded.toString());
    print("\nTryck Enter för att fortsätta.");
    stdin.readLineSync();
}

  // Function to show all the heroes, sorted by strongest
  Future<void> showHerosUI() async{
    consoleUtils.clearConsole();

    // Get all heros saved in list
    print("Alla hjältar i listan. Sorterat efter styrka (starkast först).");
    print("**************************************************************\n");
    var allHeros = await dataManager.getAllHeroes();

    // Sort by strength
    allHeros.sort((a, b) =>
    b.powerstats.strength.compareTo(a.powerstats.strength));

    // Print all 
    for (var hero in allHeros) {
      print("---------------------");
      stdout.writeln("${allHeros.indexOf(hero)+1}. ");
      print(hero.toString());
    }

    print("Tryck Enter för att komma tillbaka till menyn");
    stdin.readLineSync();
  }

  // Function to search for a hero in saved heroes
  Future<void> searchHeroUI() async{
    while (true) {
      consoleUtils.clearConsole();
      
      // Promt to user   
      print("Skriv ett namn (eller en bokstav) på en hjälte och se om dom finns i systemet");
      print("******************************************************************************\n");
      
      // Taking in search input from user
      String input = stdin.readLineSync()?.trim() ?? "";
      String heroName = inputUtils.capitalizeAllWords(input);

      if(input.isNotEmpty){
        // Fetch all heros and search hero based on user input
        var selectedHero = await dataManager.getHeroByName(heroName);

        if(selectedHero.isNotEmpty){
          // Print out all the heroes that match the search
          for (var hero in selectedHero) {
            print(hero.toString());
          }

          // Check if user wants to do new search
          print("Vill du göra en ny sökning? (ja/nej)");
          while (true) {      
            var userInput = stdin.readLineSync()?.trim().toLowerCase() ?? "";

            if (userInput == "ja") {
              break;
            }
            else if(userInput == "nej"){
              await app.startMenu();
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