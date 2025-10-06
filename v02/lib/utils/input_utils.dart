
class InputUtils {

  // Function to capitalize a String
  String capitalizeWord(String word){
    if(word.isEmpty) return word;
    return word[0].toUpperCase() + word.substring(1).toLowerCase();
  }

  // Function to capitalize two words in a String
  String capitalizeAllWords(String allWords){
    if (allWords.isEmpty) return allWords;

    // Split twoWords by spaces
    List<String> words = allWords.trim().split(RegExp(r"\s+"));

    // Capitalize each word
    List<String> capitalizedWords = words.map((word) {
      if(word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).toList();

    // Join them back into one string
    return capitalizedWords.join(" ");
  }
}