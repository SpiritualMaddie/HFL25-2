import 'package:test/test.dart';
import 'package:v04/data/models/appearance_model.dart';
import 'package:v04/data/models/biography_model.dart';
import 'package:v04/data/models/connections_model.dart';
import 'package:v04/data/models/hero_model.dart';
import 'package:v04/data/models/image_model.dart';
import 'package:v04/data/models/powerstats_model.dart';
import 'package:v04/data/models/work_model.dart';
import 'package:v04/managers/hero_data_manager.dart';


void main() {
  group('HeroDataManager', () {
    test('should add heroes and retrieve them correctly', () async {
      final dataManager = HeroDataManager();

      final currentHeroes = await dataManager.getAllHeroes();
      currentHeroes.clear();

      final superman = HeroModel(
        heroId: 1,
        name: "Superman",
        powerstats: PowerstatsModel(
          intelligence: 94,
          strength: 100,
          speed: 100,
          durability: 100,
          power: 100,
          combat: 85,
        ),
        biography: BiographyModel(
          fullName: "Clark Kent",
          alterEgos: "Superboy, Kal-El",
          aliases: ["Man of Steel", "The Last Son of Krypton"],
          placeOfBirth: "Krypton",
          firstAppearance: "Action Comics #1 (1938)",
          publisher: "DC Comics",
          alignment: "good",
        ),
        appearance: AppearanceModel(
          gender: "Male",
          race: "Kryptonian",
          height: ["6'3", "191 cm"],
          weight: ["225 lb", "102 kg"],
          eyeColor: "Blue",
          hairColor: "Black",
        ),
        work: WorkModel(occupation: "Reporter", base: "Metropolis"),
        connections: ConnectionsModel(
          groupAffiliation: "Justice League of America",
          relatives: "Lois Lane (wife), Jonathan and Martha Kent (adoptive parents)",
        ),
        image: ImageModel(
          url: "https://images.pexels.com/photos/28245751/pexels-photo-28245751.jpeg",
        ),
      );

      final wonderWoman = HeroModel(
        heroId: 2,
        name: "Wonder Woman",
        powerstats: PowerstatsModel(
          intelligence: 88,
          strength: 100,
          speed: 79,
          durability: 100,
          power: 100,
          combat: 95,
        ),
        biography: BiographyModel(
          fullName: "Diana Prince",
          alterEgos: "None",
          aliases: ["Princess Diana of Themyscira"],
          placeOfBirth: "Themyscira",
          firstAppearance: "All Star Comics #8 (1941)",
          publisher: "DC Comics",
          alignment: "good",
        ),
        appearance: AppearanceModel(
          gender: "Female",
          race: "Amazon",
          height: ["6'0", "183 cm"],
          weight: ["165 lb", "75 kg"],
          eyeColor: "Blue",
          hairColor: "Black",
        ),
        work: WorkModel(occupation: "Ambassador, Warrior", base: "Themyscira"),
        connections: ConnectionsModel(
          groupAffiliation: "Justice League of America",
          relatives: "Queen Hippolyta (mother)",
        ),
        image: ImageModel(
          url: "https://images.pexels.com/photos/3180273/pexels-photo-3180273.jpeg",
        ),
      );

      await dataManager.createHero(superman);
      await dataManager.createHero(wonderWoman);

      final heroes = await dataManager.getAllHeroes();

      // Assert total count
      expect(heroes.length, equals(2));

      // Assert properties directly
      expect(heroes[0].name, equals("Superman"));
      expect(heroes[1].name, equals("Wonder Woman"));

      // Assert nested objects
      expect(heroes[0].powerstats.strength, equals(100));
      expect(heroes[1].biography.alignment, equals("good"));
    });
  });
}