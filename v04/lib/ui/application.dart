import 'dart:io';
import 'package:v04/managers/hero_data_manager.dart';
import 'package:v04/ui/hero_ui.dart';
import 'package:v04/utils/console_utils.dart';
import 'package:v04/utils/menu.dart';

class Application{

  // Private constructor for Singelton
  Application._internal();

  // Stingle static instance
  static final Application _instance = Application._internal();

  // Public accessor of the Singleton
  factory Application() => _instance;

  final consoleUtils = ConsoleUtils();
  final heroUI = HeroUI();
  final dataManager = HeroDataManager();

  // Function to run menu
  Future<void> startMenu() async {

    while (true) {
      consoleUtils.clearConsole();

      final String prompt = "Vad vill du göra?\n";
      List<String> options = ["1. Lägga till hjälte",
                              "2. Visa hjältar",
                              "3. Visa hjältar och skurkar",
                              "4. Sök hjälte - lokalt",
                              "5. Sök hjälte - API",
                              "6. Avsluta"];
      Menu mainMenu = Menu(options: options, prompt: prompt);

      consoleUtils.logo();
      print(mainMenu);

      // Lets user choose menu choice
      var input = stdin.readLineSync();

      switch(input){
        case "1": await heroUI.addHeroUI(); break;
        case "2": await heroUI.showHerosUI(); break;
        case "3": await heroUI.showHerosAndVilliansUI(); break;
        case "4": await heroUI.searchHeroUI(); break;
        case "5": await heroUI.searchHeroApiUI(); break;      
        case "6": consoleUtils.endScreen(); break;      
        default: consoleUtils.invalidChoice();
      }
    }
  }

  Future<void> loadHeroesFromLocalJson() async {
      try {
      final count = await dataManager.loadHeroesFromJsonToHeroesList();

      print("✅ Laddade $count hjältar och skurkar från lokal JSON.");
      sleep(Duration(seconds: 2)); // TODO spinner?

      // print("Första på listan:\n${_heroesList.first}");
      // print("Sista på listan:\n${_heroesList.last}");
    } catch (e) {
      print("❌ Error: $e");
    }
  }
}