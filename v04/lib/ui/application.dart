import 'dart:io';
import 'package:v04/ui/hero_ui.dart';
import 'package:v04/utils/menu.dart';
import 'package:v04/utils/console_utils.dart';
import 'package:v04/managers/hero_data_manager.dart';

class Application {
  // Private constructor for Singelton
  Application._internal();

  // Stingle static instance
  static final Application _instance = Application._internal();

  // Public accessor of the Singleton
  factory Application() => _instance;

  // Function to run menu
  Future<void> startMenu() async {
    final consoleUtils = ConsoleUtils();
    final heroUI = HeroUI();

    while (true) {
      consoleUtils.clearConsole();

      final String prompt = "Vad vill du göra?\n";
      List<String> options = [
        "1. Lägga till hjälte",
        "2. Visa hjältar",
        "3. Visa hjältar och skurkar (+ ta bort ngn)",
        "4. Sök hjälte - lokalt",
        "5. Sök hjälte - API",
        "6. Spara hjältar till lokal lagring",
        "7. Avsluta",
      ];
      Menu mainMenu = Menu(options: options, prompt: prompt);

      consoleUtils.logo();
      print(mainMenu);

      // Lets user choose menu choice
      var input = stdin.readLineSync();

      switch (input) {
        case "1":
          await heroUI.addHeroUI();
          break;
        case "2":
          await heroUI.showHerosUI();
          break;
        case "3":
          await heroUI.showHerosAndVilliansUI();
          break;
        case "4":
          await heroUI.searchHeroUI();
          break;
        case "5":
          await heroUI.searchHeroApiUI();
          break;
        case "6":
          await updateLocalJson();
          break;
        case "7":
          await updateLocalJson();
          consoleUtils.endScreen();
          break;
        default:
          consoleUtils.invalidChoice();
      }
    }
  }

  // Function to load heroes/villians from local json file to local list _heroesList in DataManager
  Future<void> loadHeroesFromLocalJson() async {
    final dataManager = HeroDataManager();
    try {
      final count = await dataManager.loadHeroesFromJsonToHeroesList();

      print("✅ Laddade $count hjältar och skurkar från lokal JSON.");
      sleep(Duration(seconds: 2));

    } catch (e) {
      print("❌ Error: $e");
    }
  }

  // Function to update heroes/villians from local list _heroesList in DataManager to local json file
  Future<void> updateLocalJson() async {
    final consoleUtils = ConsoleUtils();
    final dataManager = HeroDataManager();

    consoleUtils.clearConsole();
    try {
      await dataManager.updateJsonWithHeroesList();
      print("💾 Hjältar och skurkar sparade!");
      sleep(Duration(seconds: 3));

    } catch (e) {
      print("❌ Error i uppdaterandet av lokal json-fil med hjältar och skurkar: $e");
    }
  }
}
