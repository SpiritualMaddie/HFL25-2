import 'dart:io';
import 'package:v04/ui/application.dart';
import 'package:v04/utils/input_utils.dart';
import 'package:v04/utils/console_utils.dart';
import 'package:v04/utils/get_model_input.dart';
import 'package:v04/data/models/work_model.dart';
import 'package:v04/data/models/hero_model.dart';
import 'package:v04/data/models/image_model.dart';
import 'package:v04/validators/get_valid_int.dart';
import 'package:v04/managers/hero_data_manager.dart';
import 'package:v04/data/models/biography_model.dart';
import 'package:v04/data/models/powerstats_model.dart';
import 'package:v04/data/models/appearance_model.dart';
import 'package:v04/data/models/connections_model.dart';

class HeroUI {
  final dataManager = HeroDataManager();
  final consoleUtils = ConsoleUtils();
  final getValidInt = GetValidInt();
  final inputUtils = InputUtils();
  final getModelInput = GetModelInput();
  final app = Application();

  // Function to handle UI for adding a new hero/villian to the local list _heroesList in DataManager
  Future<void> addHeroUI() async {
    consoleUtils.clearConsole();
    print("Lägg till hjälte");
    print("******************\n");

    // Ask for name
    final heroName = inputUtils.capitalizeAllWords(
      inputUtils.promptNotEmpty(
        "Vad har superhjälten för namn \n(vid flera ord separera med ett mellanslag)?",
      ),
    );

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
      connections: connections,
    );

    // Add new hero to heroesList
    var newHeroCreated = await dataManager.createHero(newHero);
    
    if(newHeroCreated != null){
      // Confirm and show new hero
      consoleUtils.clearConsole();
      print("💾 Hjälten är tillagd!\n");
      print(newHeroCreated.toString());
      print("\nTryck Enter för att fortsätta.");
      stdin.readLineSync();
    }
    else{ // If the name of a hero/villian already exist it wont be created
      consoleUtils.clearConsole();
      print("⚠️ Hjälten/skurken finns redan, kan inte skapa dubletter.");
      print("\nTryck Enter för att fortsätta.");
      stdin.readLineSync();      
    }
  }

  // Function to handle UI for showing all the heroes/villians, sorted by strongest
  Future<void> showHerosUI() async {
    consoleUtils.clearConsole();

    // Get all heroes saved in list
    print("Alla hjältar i listan. Sorterat efter styrka (starkast först).");
    print("**************************************************************\n");
    var allHeros = await dataManager.getAllHeroesLocal();

    // Sort by strength
    allHeros.sort(
      (a, b) => b.powerstats.strength.compareTo(a.powerstats.strength),
    );

    // Print all
    for (var hero in allHeros) {
      print("---------------------");
      stdout.writeln("${allHeros.indexOf(hero) + 1}. ");
      print(hero.toString());
    }

    print("Tryck Enter för att komma tillbaka till menyn");
    stdin.readLineSync();
  }

  // Function to handle UI for showing all the heroes and villians seperated
  Future<void> showHerosAndVilliansUI() async {
    consoleUtils.clearConsole();

    // Get all heroes saved in list and print them seperated by alignment
    var all = await dataManager.sortedHeroesVillains();
    printSortedHeroesVillainsList(all["heroes"] ?? [], "Hjältar");
    printSortedHeroesVillainsList(all["villains"] ?? [], "Skurkar");

    // Let the user choose to delete a hero or villian or go back to start menu
    while (true) {
      print(
        "Skriv 'd' om du vill ta bort en hjälte/skurk \neller 'b' om du vill gå tillbaka till startmenyn: ",
      );
      var input = stdin.readLineSync()?.trim().toLowerCase() ?? "";

      if (input == "b") {
        await app.startMenu();
      } else if (input == "d") {
        await deleteHeroUI();
      }else{
        print("❗ Ogiltigt val. Försök igen.\n");
        continue;
      }
    }
  }

  // Function to handle UI for printing Sorted Heroes and Villains List with swedish/customizable title
  void printSortedHeroesVillainsList(List<HeroModel> heroes, String title) {
    print("\n\n=========================");
    print("======= $title =========");
    print("=========================");
    if (heroes.isEmpty) {
      print("\n ⚠️ Inga $title hittades.\n");
    } else {
      for (var hero in heroes) {
        print("Id: ${hero.heroId}\t - ${hero.name}");
      }
    }
  }

  // Function to handle UI for deleting hero/villian from the local list _heroesList in DataManager
  Future<void> deleteHeroUI() async {
    while(true){
      // Ask for id
      int id = getValidInt.getValidIntWithLoop("Skriv ett id på en hjälte/skurk du vill ta bort:\n");

      // Check if id exists
      var hero = await dataManager.getHeroByIdLocal(id);
      if(hero != null){
        print("""Du har valt: 
Id: ${hero.heroId} \t${hero.name}
        """);

        while(true){
          var input = inputUtils.promptNotEmpty("Är du säker på att du vill ta bort denna (ja/nej)?").toLowerCase();
          if(input == "ja"){
            await dataManager.deleteHero(id);
            print("✅ Borttagningen var lyckad!");
            sleep(Duration(seconds: 3));
            break;
          }else if(input == "nej"){
            break;
          }else{
            print("❗ Ogiltigt val");
            continue;
          }
        }
        await showHerosAndVilliansUI();
      }
      else{
        print("❗ Ops, id:et finns inte, försök igen:");
        sleep(Duration(seconds: 2));
        continue;
      }
    }
  }
 
  // Function to handle UI for searching for a hero/villian in the local list _heroesList in DataManager
  Future<void> searchHeroUI() async {
    while (true) {
      consoleUtils.clearConsole();

      // Promt to user
      print(
        "Skriv ett namn (eller en bokstav) på en hjälte och se om dom finns i systemet",
      );
      print(
        "******************************************************************************\n",
      );

      // Taking in search input from user
      String input = stdin.readLineSync()?.trim() ?? "";
      String heroName = inputUtils.capitalizeAllWords(input);

      if (input.isNotEmpty) {
        // Fetch all heros and search hero based on user input
        var selectedHero = await dataManager.getHeroByNameLocal(heroName);

        if (selectedHero.isNotEmpty) {
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
            } else if (userInput == "nej") {
              await app.startMenu();
            } else {
              print("Du måste skriva ja eller nej, var god försök igen:");
            }
          }
        } else {
          print("Det finns ingen hjälte som matchar din sökning...");
          sleep(Duration(seconds: 3));
        }
      } else {
        print("Du måste skriva något...");
        sleep(Duration(seconds: 2));
      }
    }
  }

  // Function to handle UI for searching for a hero/villian in SuperHero API (https://superheroapi.com/)
  Future<void> searchHeroApiUI() async {
    while (true) {
      consoleUtils.clearConsole();

      // Promt to user
      print(
        "Skriv ett namn (eller en bokstav) på en hjälte och se om dom finns i SuperHero API",
      );
      print(
        "******************************************************************************\n",
      );

      // Taking in search input from user
      String heroName = inputUtils.capitalizeAllWords(
        stdin.readLineSync()?.trim() ?? "",
      );

      if (heroName.isNotEmpty) {
        // Fetch all heros and search hero based on user input
        var selectedHero = await dataManager.getHeroByNameApi(heroName);

        if (selectedHero.isNotEmpty) {
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
            } else if (userInput == "nej") {
              await app.startMenu();
            } else {
              print("❗ Du måste skriva ja eller nej, var god försök igen:");
            }
          }
        } else {
          print("❗ Det finns ingen hjälte som matchar din sökning...");
          sleep(Duration(seconds: 3));
        }
      } else {
        print("❗ Du måste skriva något...");
        sleep(Duration(seconds: 2));
      }
    }
  }
}
