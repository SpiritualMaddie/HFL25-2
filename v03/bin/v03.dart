import 'dart:io';

import 'package:v03/data/models/appearance_model.dart';
import 'package:v03/data/models/biography_model.dart';
import 'package:v03/data/models/connections_model.dart';
import 'package:v03/data/models/hero_model.dart';
import 'package:v03/data/models/image_model.dart';
import 'package:v03/data/models/powerstats_model.dart';
import 'package:v03/data/models/work_model.dart';
import 'package:v03/managers/mock_data_manager.dart';
import 'package:v03/ui/application.dart';
import 'package:v03/data/dummy_data.dart';

Future<void> main(List<String> arguments) async {
  // Application app = Application();
  // DummyData dummyData = DummyData();

  // dummyData.dummyData();
  // app.startMenu();

  MockDataManager mockData = MockDataManager();

  await mockData.syncListAndJsonData();

  final testHero = HeroModel(
 // will be auto-updated in createHero()
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
    height: ["1.72 m", "5'8\""],
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

print("create hero:");
await mockData.createHero(testHero);
print("getAllHeros.toString:");
var allHeroes = await mockData.getAllHeroes();
print(allHeroes.toString());
print("sync list and json:");
await mockData.syncListAndJsonData();
print("check if added");
var lastHero = await mockData.getAllHeroes();
print(lastHero.last.toString());
}
