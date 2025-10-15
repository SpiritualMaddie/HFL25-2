import 'dart:convert';
import 'dart:io';

import 'package:v03/data/models/hero_model.dart';
import 'package:v03/managers/hero_data_managing.dart';

class MockDataManager implements HeroDataManaging{

  // Private constructor for Singleton
  MockDataManager._internal();

  // Single static instance
  static final MockDataManager _instance = MockDataManager._internal();

  // Public accessor of the Singleton
  factory MockDataManager() => _instance;

  // List of heroes
  final List<HeroModel> _mockHeroesList = [];

  // Path to json (can be switched to API uri or db)
  // final uri = Uri.parse("http://");
  String mockDataPath = "lib/data/hero_mock_data.json";
  
  @override
  Future<HeroModel> createHero(HeroModel hero) async {
    // Auto-increment ID adding +1 from the highest existing ID
    int newId = _mockHeroesList.isEmpty 
                ? 1 
                : _mockHeroesList.map((h) => h.heroId).reduce((a, b) => a > b ? a : b) + 1;
              // _mockHeroesList.last.heroId + 1; - Auto-increment ID based on the last hero in the list

    final newHero = HeroModel(
      heroId: newId,
      name: hero.name,
      powerstats: hero.powerstats,
      biography: hero.biography,
      appearance: hero.appearance,
      image: hero.image,
      work: hero.work,
      connections: hero.connections,
    );
    _mockHeroesList.add(newHero);
    return hero;
  }
  
  @override
  Future<List<HeroModel>> getAllHeroes() async {
    return _mockHeroesList;
  }
  
  @override
  Future<List<HeroModel>> getHeroByName(String heroName) async {
    final search = heroName.toLowerCase();
    return _mockHeroesList
        .where((h) => h.name.toLowerCase().contains(search))
        .toList();
  }
  
  // @override
  // Future<void> deleteHero(int id) async {
  //   _mockHeroesList.removeWhere((h) => h.heroId == id);
  // }
  
  // TODO check if works as expected
  // @override
  // Future<HeroModel> updateHero(HeroModel updatedHero) async {
  //   final index = _mockHeroesList.indexWhere((h) => h.heroId == updatedHero.heroId);
  //   if (index == -1) {
  //     throw Exception("Hero with ID ${updatedHero.heroId} not found");
  //   }
  //   _mockHeroesList[index] = updatedHero;
  //   return updatedHero;
  // }
  
  // @override
  // Future<HeroModel?> getHeroById(int id) async {
  //   return _mockHeroesList.firstWhere((h) => h.heroId == id, orElse: () => null);
  // }

Future<void> loadHeroesFromJsonToHeroesList() async {
  try {
    final file = File(mockDataPath);
    final contents = await file.readAsString();
    final List<dynamic> jsonData = jsonDecode(contents);

    _mockHeroesList.clear();
    _mockHeroesList.addAll(
      jsonData.map((h) => HeroModel.fromJson(h)).toList(),
    );

    print("✅ Loaded ${_mockHeroesList.length} heroes from JSON.");
    //print("First hero:\n${_mockHeroesList.first}");
  } catch (e) {
    print("❌ Failed to load heroes: $e");
  }
}

// TODO remove when safe
Future<void> syncListAndJsonData() async {
  try {
    final file = File(mockDataPath);

    if (!await file.exists()) {
      print("⚠️ JSON file not found at $mockDataPath.");
      return;
    }

    // 
    final contents = await file.readAsString();
    final List<dynamic> jsonData = jsonDecode(contents);

    if(_mockHeroesList.isEmpty){
      _mockHeroesList.clear();
      _mockHeroesList.addAll(
        jsonData.map((h) => HeroModel.fromJson(h)).toList(),
      );
    }

    // Convert jsonData -> HeroModel list
    final List<HeroModel> loadedHeroes = jsonData
        .map((item) => HeroModel.fromJson(item as Map<String, dynamic>))
        .toList();

    // Compare with in-memory list and if not matching updating JSON to match in-memory list
    if (_mockHeroesList.length != loadedHeroes.length) {
      print("🔄 Updating JSON from in-memory list (${loadedHeroes.length} heroes).");
      // Convert the mockHeroesList to the json so that json reflects in-memory list
    } else {
      print("✅ List already up-to-date with JSON (${_mockHeroesList.length} heroes).");
    }

  } catch (e) {
    print("❌ Failed to sync heroes: $e");
  }
}

// Use append
Future<void> saveHeroToJson(HeroModel newHero) async {
  final file = File(mockDataPath);
  final jsonData = newHero.toJson();
  await file.writeAsString(jsonEncode(jsonData), flush: true, mode: FileMode.append);
  print("💾 Hero saved to file.");
}


}