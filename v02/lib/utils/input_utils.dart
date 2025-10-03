
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
}