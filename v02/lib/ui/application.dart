import 'dart:io';
import 'package:v02/ui/hero_ui.dart';
import 'package:v02/utils/console_utils.dart';
import 'package:v02/utils/menu.dart';

class Application{

  // Private constructor for Singelton
  Application._internal();

  // Stingle static instance
  static final Application _instance = Application._internal();

  // Public accessor of the Singleton
  factory Application() => _instance;

  void startMenu(){
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

      //consoleUtils.logo();
      print(mainMenu);

      var input = stdin.readLineSync();
      consoleUtils.clearConsole();

      switch(input){
        case "1":
        //heroUI.addHeroUI();
        print("Lägg till hjälte - användaren skriver in namn, styrka (int), och kanske en specialkraft.");
        stdin.readLineSync();
        break;
        case "2":
        heroUI.showHerosUI();
        break;
        case "3":
        heroUI.searchHeroUI();
        //print("Sök hjälte - låt användaren skriva in en bokstav eller ett namn och visa matchande hjältar.");
        //stdin.readLineSync();
        break;
        case "4":
        consoleUtils.endScreen();
        break;      
        default:
        consoleUtils.invalidChoice();
      }
    }
  }
}