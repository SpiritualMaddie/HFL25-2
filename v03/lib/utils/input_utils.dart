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

  // Ask for input, allow empty (returns empty string) TODO should it be null?
  String promptOptional(String message) {
    stdout.writeln(message);
    final input = stdin.readLineSync()?.trim() ?? "";
    return input;
  }

  // Ask for a list input (comma-separated)
  List<String> promptList(String message) {
    stdout.writeln(message);
    final input = stdin.readLineSync()?.trim() ?? "";
    if (input.isEmpty) return [];

    return input
        .split(", ")
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
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

  // Capitalize each word (like "peter parker" → "Peter Parker")
  String capitalizeAllWords(String text) {
    if (text.isEmpty) return text;
    return text
        .split(" ")
        .map((word) =>
            word.isEmpty ? "" : word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(' ');
  }

  // // TODO remove if other works - Function to capitalize two words in a String
  // String capitalizeAllWords(String words){
  //   if (words.isEmpty) return words;

  //   // Split twoWords by spaces
  //   List<String> wordsSplit = words.trim().split(RegExp(r"\s+"));

  //   // Capitalize each word
  //   List<String> capitalizedWords = wordsSplit.map((word) {
  //     if(word.isEmpty) return word;
  //     return word[0].toUpperCase() + word.substring(1).toLowerCase();
  //   }).toList();

  //   // Join them back into one string
  //   return capitalizedWords.join(" ");
  // }
}