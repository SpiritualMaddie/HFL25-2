
import 'dart:io';

class InputUtils {

  String capitalizeWord(String word){
    if(word.isEmpty) return word;
    return word[0].toUpperCase() + word.substring(1).toLowerCase();
  }

  String capitalizeTwoWords(String twoWords){
    if (twoWords.isEmpty) return twoWords;

    // Split twoWords by spaces
    List<String> words = twoWords.trim().split(RegExp(r"\s+"));

    // Capitalize each word
    List<String> capitalizedWords = words.map((word) {
      if(word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).toList();

    // Join them back into one string
    return capitalizedWords.join(" ");
  }

// Validating input as int, looping unless correct, with prompt to create customizable start message to user
  int getValidIntWithLoopMaxTwenty(String prompt) {
    while (true) {
      stdout.writeln(prompt);
      String input = stdin.readLineSync()?.trim() ?? "";

      if (input.isEmpty) {
        stdout.writeln("Ops, du måste skriva något.");
        continue;
      }

      try {
        int valueInt = int.parse(input);
        if (valueInt < 1) {
          stdout.writeln("Siffran kan inte vara noll eller negativt. Försök igen.");
          continue;
        }
        if (valueInt > 20) {
          stdout.writeln("Siffran kan inte vara över 20. Försök igen.");
          continue;
        }
        return valueInt;
      } on FormatException {
        stdout.writeln("Ogiltigt värde. Ange ett heltal.");
      }
    }
  }
}