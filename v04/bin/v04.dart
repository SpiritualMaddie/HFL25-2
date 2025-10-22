import 'package:v04/data/models/appearance_model.dart';
import 'package:v04/data/models/biography_model.dart';
import 'package:v04/data/models/connections_model.dart';
import 'package:v04/data/models/hero_model.dart';
import 'package:v04/data/models/image_model.dart';
import 'package:v04/data/models/powerstats_model.dart';
import 'package:v04/data/models/work_model.dart';
import 'package:v04/managers/hero_data_manager.dart';
import 'package:v04/managers/mock_data_manager.dart';
import 'package:v04/ui/application.dart';
import 'package:v04/data/mock_data.dart';

// TODO "reponse : success" in json when adding to the json
Future<void> main(List<String> arguments) async {
  final app = Application();
  final dataManager = HeroDataManager();
  final mockDataManager = MockDataManager();
  MockData mockData = MockData();

  await mockDataManager.loadHeroesFromJsonToHeroesList();

  //await mockData.loadMockHeroes(dataManager);
  //app.startMenu();

  final testHero = HeroModel(
  heroId: 0, // will be auto-updated in createHero()
  name: "Neura Flux",
  powerstats: PowerstatsModel(
    intelligence: 95,
    strength: 60,
    speed: 70,
    durability: 65,
    power: 90,
    combat: 75,
  ),
  biography: BiographyModel(
    fullName: "Dr. Nova Elara",
    alterEgos: "The Mind Weaver",
    aliases: ["Flux", "Neura", "Dr. Elara"],
    placeOfBirth: "Stockholm, Sweden",
    firstAppearance: "Neural Nexus #1 (2024)",
    publisher: "InnerVerse Studios",
    alignment: "good",
  ),
  appearance: AppearanceModel(
    gender: "Female",
    race: "Human (Cyborg-enhanced)",
    height: ["1.72 m", "5'8"],
    weight: ["62 kg", "137 lbs"],
    eyeColor: "Silver",
    hairColor: "Iridescent Purple",
  ),
  work: WorkModel(
    occupation: "Neuropsychologist & AI Developer",
    base: "The Nexus Lab, hidden under Uppsala University",
  ),
  connections: ConnectionsModel(
    groupAffiliation: "The Synaptic Order",
    relatives: "Unknown (rumored digital consciousness parents)",
  ),
  image: ImageModel(
    url: "https://example.com/images/neura_flux.png",
  ),
);
  await mockDataManager.createHero(testHero);

  await mockDataManager.updateJsonWithHeroesList();
}
