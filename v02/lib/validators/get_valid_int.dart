import 'dart:io';

class GetValidInt {

  // Validating input as int, looping unless correct, with prompt to create customizable start message to user
  int getValidIntWithLoopMaxTwenty(String prompt) {
    while (true) {
      stdout.writeln(prompt);
      String input = stdin.readLineSync()?.trim() ?? "";

      if (input.isEmpty) {
        stdout.writeln("Ops, du måste skriva något.");
        continue;
      }

      // try to check that input is an int
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