class HeroRepository {

  // Private constructor for Singelton
  HeroRepository._internal();

  // Stingle static instance
  static final HeroRepository _instance = HeroRepository._internal();

  // Public accessor of the Singleton
  factory HeroRepository() => _instance;

  final List<Map<String, dynamic>> heroesList = [];

  // TODO - any more error handling?
  void addHero(int heroId, String name, int strength, String species, String alignment){
    heroesList.add({
      "HeroId" : heroId,
      "name" : name,
      "powerstats" : {
        "strength" : strength,
      },
      "appearance" : {
        "species" : species,
      },
      "biography" : {
        "alignment" : alignment,
      },
    });
  }

  // TODO - error handling, check if list is empty or not?
  List<Map<String, dynamic>> getAllHeros(){
    return heroesList;
  }

String heroToString(Map<String, dynamic> heroMap) {
  return ("""
Id: ${heroMap["HeroId"]}
Namn: ${heroMap["name"]}
Styrka: ${heroMap["powerstats"]["strength"]}
Art: ${heroMap["appearance"]["species"]}
Moral: ${heroMap["biography"]["alignment"]}
""");
}
}