import 'dart:io';
import 'package:v03/data/models/appearance_model.dart';
import 'package:v03/data/models/biography_model.dart';
import 'package:v03/data/models/connections_model.dart';
import 'package:v03/data/models/hero_model.dart';
import 'package:v03/data/models/image_model.dart';
import 'package:v03/data/models/powerstats_model.dart';
import 'package:v03/data/models/work_model.dart';
import 'package:v03/managers/hero_data_manager.dart';
import 'package:v03/managers/hero_repository.dart';
import 'package:v03/ui/application.dart';
import 'package:v03/utils/console_utils.dart';
import 'package:v03/utils/input_utils.dart';
import 'package:v03/validators/get_valid_int.dart';

class HeroUI {

  //HeroRepository heroRepo = HeroRepository();
  final dataManager = HeroDataManager();
  ConsoleUtils consoleUtils = ConsoleUtils();
  GetValidInt getValidInt = GetValidInt();
  InputUtils inputUtils = InputUtils();
  Application app = Application();

  // Function to add hero
  Future<void> addHeroUI() async {
    String heroName; 

    consoleUtils.clearConsole();
    print("Lägg till hjälte");
    print("******************\n");

    // Ask for name
    while (true) {
      stdout.writeln("Vad har superhjälten för namn \n(vid flera ord separera med ett mellanslag)?");
      var heroNameInput = stdin.readLineSync()?.trim() ?? "";
      if (heroNameInput.isNotEmpty) {
        heroName = inputUtils.capitalizeAllWords(heroNameInput);
        break;
      }

      consoleUtils.clearConsole();
      print("Du måste skriva något. Vänligen försök igen.");
    }

    // Ask for powerstats
    int heroIntelligence = getValidInt.getValidIntWithLoopMaxTwenty("Vad har superhjälten för intelligens (ange heltal)?");
    int heroStrength = getValidInt.getValidIntWithLoopMaxTwenty("Vad har superhjälten för styrka (ange heltal)?");
    int heroSpeed = getValidInt.getValidIntWithLoopMaxTwenty("Vad har superhjälten för snabbhet (ange heltal)?");
    int heroDurability = getValidInt.getValidIntWithLoopMaxTwenty("Vad har superhjälten för hållbarhet (ange heltal)?");
    int heroPower = getValidInt.getValidIntWithLoopMaxTwenty("Vad har superhjälten för kraft (ange heltal)?");
    int heroCombat = getValidInt.getValidIntWithLoopMaxTwenty("Vad har superhjälten för stridsvärde (ange heltal)?");


    // Ask for biography
    while (true) {
      stdout.writeln("Vad har superhjälten för namn \n(vid flera ord separera med ett mellanslag)?");
      var heroNameInput = stdin.readLineSync()?.trim() ?? "";
      if (heroNameInput.isNotEmpty) {
        heroName = inputUtils.capitalizeAllWords(heroNameInput);
        break;
      }

      consoleUtils.clearConsole();
      print("Du måste skriva något. Vänligen försök igen.");
    }

    // Ask for alignment
    print("Vad har superhjälten för moral?");


    // TODO Create hero and add to List
    dataManager.createHero(HeroModel(
      name: heroName,
      powerstats: PowerstatsModel(
        intelligence: heroIntelligence, 
        strength: heroStrength, 
        speed: heroSpeed, 
        durability: heroDurability, 
        power: heroPower, 
        combat: heroCombat
      ), 
      biography: BiographyModel(
        placeOfBirth: heroPlaceOfBirth,
        firstAppearance: heroFirstAppearance,
        publisher: heroPublisher,
        alignment: heroAlignment
      ),
      appearance: AppearanceModel(
        gender: heroGender,
        race: heroRace,
        height: heroHeight,
        weight: heroWeight
      ),
      image: ImageModel(
        url: heroUrl
      ),
    ));

    // TODO Confirm and show hero
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
      
      // Taking in input from user
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