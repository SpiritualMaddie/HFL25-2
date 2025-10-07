class HeroRepository {

  // Private constructor for Singelton
  HeroRepository._internal();

  // Stingle static instance
  static final HeroRepository _instance = HeroRepository._internal();

  // Public accessor of the Singleton
  factory HeroRepository() => _instance;

  // List of heroes, always the same thanks to Singleton
  final List<Map<String, dynamic>> heroesList = [];

  // Function to add hero to List
  void addHero(String name, int strength, String species, String alignment) {
    // If the List is empty => start at 1 otherwise add one to the last added Id
    int newId = heroesList.isEmpty 
        ? 1 
        : (heroesList.last["HeroId"] as int) + 1;

    heroesList.add({
      "HeroId": newId,
      "name": name,
      "powerstats": {
        "strength": strength,
      },
      "appearance": {
        "species": species,
      },
      "biography": {
        "alignment": alignment,
      },
    });
  }

  // Function to get all the heroes in the List
  List<Map<String, dynamic>> getAllHeros(){
    return heroesList;
  }

  // Function to create a nicer looking print of hero data
  String heroToString(Map<String, dynamic> heroMap) {
    return ("""
Id:     ${heroMap["HeroId"]}
Namn:   ${heroMap["name"]}
Styrka: ${heroMap["powerstats"]["strength"]}
Art:    ${heroMap["appearance"]["species"]}
Moral:  ${heroMap["biography"]["alignment"]}
""");
  }
}