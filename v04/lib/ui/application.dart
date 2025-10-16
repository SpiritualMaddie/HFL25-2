import 'dart:io';
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

  // Function to run menu
  Future<void> startMenu() async {
    final consoleUtils = ConsoleUtils();
    final heroUI = HeroUI();

    while (true) {
      consoleUtils.clearConsole();

      final String prompt = "Vad vill du göra?\n";
      List<String> options = ["1. Lägga till hjälte",
                              "2. Visa hjältar",
                              "3. Sök hjälte",
                              "4. Avsluta"];
      Menu mainMenu = Menu(options: options, prompt: prompt);

      consoleUtils.logo();
      print(mainMenu);

      // Lets user choose menu choice
      var input = stdin.readLineSync();

      switch(input){
        case "1": await heroUI.addHeroUI(); break;
        case "2": await heroUI.showHerosUI(); break;
        case "3": await heroUI.searchHeroUI(); break;
        case "4": consoleUtils.endScreen(); break;      
        default: consoleUtils.invalidChoice();
      }
    }
  }
}