import 'package:v03/data/models/appearance_model.dart';
import 'package:v03/data/models/biography_model.dart';
import 'package:v03/data/models/connections_model.dart';
import 'package:v03/data/models/hero_model.dart';
import 'package:v03/data/models/image_model.dart';
import 'package:v03/data/models/powerstats_model.dart';
import 'package:v03/data/models/work_model.dart';
import 'package:v03/managers/hero_data_manager.dart';
import 'dart:io';

class MockData {

  Future<void> loadMockHeroes(HeroDataManager dataManager) async {
    final heroes = <HeroModel>[
      HeroModel(
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
          relatives:
              "Lois Lane (wife), Jonathan and Martha Kent (adoptive parents)",
        ),
        image: ImageModel(
          url:
              "https://images.pexels.com/photos/28245751/pexels-photo-28245751.jpeg",
        ),        
      ),
      HeroModel(
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
          url:
              "https://images.pexels.com/photos/3180273/pexels-photo-3180273.jpeg",
        ),      
      ),
      HeroModel(
        heroId: 3,
        name: "Spider-Man",
        powerstats: PowerstatsModel(
          intelligence: 90,
          strength: 55,
          speed: 67,
          durability: 75,
          power: 74,
          combat: 85,
        ),
        biography: BiographyModel(
          fullName: "Peter Parker",
          alterEgos: "Scarlet Spider, Spider-Carnage",
          aliases: ["Spidey", "Web-Slinger", "Friendly Neighborhood Spider-Man"],
          placeOfBirth: "Queens, New York",
          firstAppearance: "Amazing Fantasy #15 (1962)",
          publisher: "Marvel Comics",
          alignment: "good",
        ),
        appearance: AppearanceModel(
          gender: "Male",
          race: "Human (mutated)",
          height: ["5'10", "178 cm"],
          weight: ["167 lb", "76 kg"],
          eyeColor: "Hazel",
          hairColor: "Brown",
        ),
        work: WorkModel(
          occupation: "Photographer, Scientist, Teacher",
          base: "New York City",
        ),
        connections: ConnectionsModel(
          groupAffiliation: "Avengers, formerly Fantastic Four",
          relatives: "May Parker (aunt), Ben Parker (uncle, deceased)",
        ),
        image: ImageModel(
          url: "https://images.unsplash.com/photo-1635805737707-575885ab0820",
        ),
      ),
      HeroModel(
        heroId: 4,
        name: "Doctor Strange",
        powerstats: PowerstatsModel(
          intelligence: 100,
          strength: 10,
          speed: 12,
          durability: 84,
          power: 100,
          combat: 60,
        ),
        biography: BiographyModel(
          fullName: "Stephen Strange",
          alterEgos: "None",
          aliases: ["Sorcerer Supreme", "Master of the Mystic Arts"],
          placeOfBirth: "Philadelphia, Pennsylvania",
          firstAppearance: "Strange Tales #110 (1963)",
          publisher: "Marvel Comics",
          alignment: "good",
        ),
        appearance: AppearanceModel(
          gender: "Male",
          race: "Human",
          height: ["6'2", "188 cm"],
          weight: ["180 lb", "82 kg"],
          eyeColor: "Grey",
          hairColor: "Black with white streaks",
        ),
        work: WorkModel(
          occupation: "Sorcerer Supreme, Former Neurosurgeon",
          base: "Sanctum Sanctorum, New York City",
        ),
        connections: ConnectionsModel(
          groupAffiliation: "Defenders, Illuminati",
          relatives: "Donna Strange (sister, deceased)",
        ),
        image: ImageModel(
          url:
              "https://cdn.pixabay.com/photo/2023/06/16/13/54/fire-8068068_1280.jpg",
        ),
      ),
      HeroModel(
        heroId: 5,
        name: "Captain Marvel",
        powerstats: PowerstatsModel(
          intelligence: 84,
          strength: 88,
          speed: 85,
          durability: 95,
          power: 100,
          combat: 90,
        ),
        biography: BiographyModel(
          fullName: "Carol Danvers",
          alterEgos: "Binary, Warbird",
          aliases: ["Ms. Marvel", "Binary", "Warbird"],
          placeOfBirth: "Boston, Massachusetts",
          firstAppearance: "Marvel Super-Heroes #13 (1968)",
          publisher: "Marvel Comics",
          alignment: "good",
        ),
        appearance: AppearanceModel(
          gender: "Female",
          race: "Human/Kree Hybrid",
          height: ["5'11", "180 cm"],
          weight: ["165 lb", "75 kg"],
          eyeColor: "Blue",
          hairColor: "Blonde",
        ),
        work: WorkModel(
          occupation: "Pilot, Superhero",
          base: "Alpha Flight Space Station",
        ),
        connections: ConnectionsModel(
          groupAffiliation: "Avengers, Alpha Flight",
          relatives: "Marie Danvers (mother), Joe Danvers Sr. (father)",
        ),
        image: ImageModel(
          url:
              "https://cdn.pixabay.com/photo/2023/09/12/10/10/ai-generated-8248520_1280.jpg",
        ),
      ),
      HeroModel(
        heroId: 6,
        name: "Neural Weaver",
        powerstats: PowerstatsModel(
          intelligence: 95,
          strength: 45,
          speed: 60,
          durability: 55,
          power: 85,
          combat: 50,
        ),
        biography: BiographyModel(
          fullName: "Lyra Venn",
          alterEgos: "None",
          aliases: ["The Empathic Engineer"],
          placeOfBirth: "Oslo, Norway",
          firstAppearance: "Mindguard Chronicles #1",
          publisher: "Mindforge Comics",
          alignment: "good",
        ),
        appearance: AppearanceModel(
          gender: "Female",
          race: "Human (Enhanced)",
          height: ["5'7", "170 cm"],
          weight: ["135 lb", "61 kg"],
          eyeColor: "Green",
          hairColor: "Blue",
        ),
        work: WorkModel(
          occupation: "Neuroscientist and Emotional Architect",
          base: "The Mindforge Institute",
        ),
        connections: ConnectionsModel(
          groupAffiliation: "Mindguard Collective",
          relatives: "Unknown",
        ),
        image: ImageModel(
          url: "https://images.unsplash.com/photo-1634448313064-012033d81935",
        ),
      ),
      HeroModel(
        heroId: 7,
        name: "Code Saint",
        powerstats: PowerstatsModel(
          intelligence: 98,
          strength: 40,
          speed: 55,
          durability: 60,
          power: 78,
          combat: 45,
        ),
        biography: BiographyModel(
          fullName: "Morgan Ailenn",
          alterEgos: "None",
          aliases: ["The Digital Prophet"],
          placeOfBirth: "Dublin, Ireland",
          firstAppearance: "Quantum Dawn #3",
          publisher: "Mindforge Comics",
          alignment: "neutral good",
        ),
        appearance: AppearanceModel(
          gender: "Non-binary",
          race: "Cyborg",
          height: ["5'9", "175 cm"],
          weight: ["150 lb", "88 kg"],
          eyeColor: "Blue",
          hairColor: "No hair",
        ),
        work: WorkModel(
          occupation: "AI Developer and Hacker",
          base: "The Neon Archive",
        ),
        connections: ConnectionsModel(
          groupAffiliation: "Digital Vanguard",
          relatives: "None known",
        ),
        image: ImageModel(
          url: "https://images.unsplash.com/photo-1658116369704-da83f927f192",
        ),
      ),
      HeroModel(
        heroId: 8,
        name: "Echoheart",
        powerstats: PowerstatsModel(
          intelligence: 88,
          strength: 50,
          speed: 45,
          durability: 65,
          power: 90,
          combat: 40,
        ),
        biography: BiographyModel(
          fullName: "Sarai Kellen",
          alterEgos: "None",
          aliases: ["The Voice of Ages"],
          placeOfBirth: "Cairo, Egypt",
          firstAppearance: "Songs of the Veil #1",
          publisher: "Mindforge Comics",
          alignment: "good",
        ),
        appearance: AppearanceModel(
          gender: "Female",
          race: "Human",
          height: ["5'8", "173 cm"],
          weight: ["140 lb", "63 kg"],
          eyeColor: "Amber",
          hairColor: "Black",
        ),
        work: WorkModel(
          occupation: "Spiritual Healer and Historian",
          base: "Temple of the Veil",
        ),
        connections: ConnectionsModel(
          groupAffiliation: "Order of the Veil",
          relatives: "Descendant of ancient oracle line",
        ),
        image: ImageModel(
          url: "https://images.unsplash.com/photo-1648904944129-320e8079957d",
        ),
      ),
      HeroModel(
        heroId: 9,
        name: "Synapse Knight",
        powerstats: PowerstatsModel(
          intelligence: 90,
          strength: 70,
          speed: 65,
          durability: 80,
          power: 60,
          combat: 85,
        ),
        biography: BiographyModel(
          fullName: "Arden Voss",
          alterEgos: "None",
          aliases: ["The Focused One"],
          placeOfBirth: "Reykjavik, Iceland",
          firstAppearance: "Cognitive Wars #2",
          publisher: "Mindforge Comics",
          alignment: "good",
        ),
        appearance: AppearanceModel(
          gender: "Male",
          race: "Human",
          height: ["6'0", "183 cm"],
          weight: ["180 lb", "82 kg"],
          eyeColor: "Steel blue",
          hairColor: "Dark brown",
        ),
        work: WorkModel(
          occupation: "Former Soldier turned Monk",
          base: "The Silent Citadel",
        ),
        connections: ConnectionsModel(
          groupAffiliation: "Neural Vanguard",
          relatives: "None known",
        ),
        image: ImageModel(
          url: "https://images.unsplash.com/photo-1728325430058-d14f990cb727",
        ),
      ),
      HeroModel(
        heroId: 10,
        name: "Ghostline",
        powerstats: PowerstatsModel(
          intelligence: 92,
          strength: 45,
          speed: 85,
          durability: 55,
          power: 88,
          combat: 60,
        ),
        biography: BiographyModel(
          fullName: "Nova Wynn",
          alterEgos: "None",
          aliases: ["The Digital Phantom"],
          placeOfBirth: "Seattle, USA",
          firstAppearance: "Ethernetics #1",
          publisher: "Mindforge Comics",
          alignment: "chaotic good",
        ),
        appearance: AppearanceModel(
          gender: "Female",
          race: "Human (Digitally Altered)",
          height: ["5'6", "168 cm"],
          weight: ["125 lb", "57 kg"],
          eyeColor: "Glowing teal",
          hairColor: "Dark brown",
        ),
        work: WorkModel(
          occupation: "Hacker and Data Ghost",
          base: "The Ether Grid",
        ),
        connections: ConnectionsModel(
          groupAffiliation: "Ethernetics",
          relatives: "Unknown",
        ),
        image: ImageModel(
          url: "https://images.unsplash.com/photo-1711662171213-4141abec218f",
        ),        
      )
    ];

    // Adding all the mock heroes to the heroesList in HeroDataManager
    for(final hero in heroes){
      await dataManager.createHero(hero);
    }

    print("✅ Loaded ${heroes.length} mock heroes into HeroDataManager!");
    sleep(Duration(seconds: 3));
  }
}
