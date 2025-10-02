
class InputUtils {

  String capitalizeWord(String word){
    if(word.isEmpty) return word;
    return word[0].toUpperCase() + word.substring(1).toLowerCase();
  }

  String capitalizeTwoWords(String name){
    if (name.isEmpty) return name;

    // Split by spaces
    List<String> words = name.trim().split(RegExp(r"\s+"));

    // Capitalize each word
    List<String> capitalizedWords = words.map((word) {
      if(word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).toList();

    // Join them back into one string
    return capitalizedWords.join(" ");
  }
}