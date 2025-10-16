import 'dart:io';

class InputUtils {

  // Function to capitalize a String
  String capitalizeWord(String word){
    if(word.isEmpty) return word;
    return word[0].toUpperCase() + word.substring(1).toLowerCase();
  }
  
  // Ask for input, repeat until user gives something not-empty
  String promptNotEmpty(String message) {
    while (true) {
      stdout.writeln(message);
      final input = stdin.readLineSync()?.trim() ?? "";
      if (input.isNotEmpty) return input;

      print("❗ Du måste skriva något. Försök igen.\n");
    }
  }

  // Ask for input, allow empty (returns empty string)
  String promptOptional(String message) {
    stdout.writeln(message);
    final input = stdin.readLineSync()?.trim() ?? "";
    return input;
  }

  // Ask for a list input optional, can be empty (comma-separated)
  List<String> promptListOptional(String message) {
    stdout.writeln(message);
    final input = stdin.readLineSync()?.trim() ?? "";
    if (input.isEmpty) return [];

    return input
        .split(", ")
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
  }

    // Ask for a list input non optional (comma-separated)
  List<String> promptList(String message) {
    while (true) { 
      stdout.writeln(message);
      final input = stdin.readLineSync()?.trim() ?? "";
      if (input.isNotEmpty) {
        return input
            .split(", ")
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList();
      }

        print("❗ Du måste skriva något. Försök igen.\n");
    }
  }

  // Ask user to choose from options (case-insensitive)
  String promptFromOptions(String message, List<String> options) {
    while (true) {
      stdout.writeln("$message (${options.join(", ")})");
      final input = stdin.readLineSync()?.trim().toLowerCase() ?? "";

      if (options.map((e) => e.toLowerCase()).contains(input)) {
        return input;
      }

      print("❗ Ogiltigt val. Välj ett av: ${options.join(", ")}.\n");
    }
  }

  // Capitalize each word in a text
  String capitalizeAllWords(String text) {
    if (text.isEmpty) return text;
    return text
        .split(" ")
        .map((word) =>
            word.isEmpty ? "" : word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(' ');
  }
}