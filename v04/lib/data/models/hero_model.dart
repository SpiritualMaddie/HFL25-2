import 'package:v04/data/models/appearance_model.dart';
import 'package:v04/data/models/biography_model.dart';
import 'package:v04/data/models/connections_model.dart';
import 'package:v04/data/models/image_model.dart';
import 'package:v04/data/models/powerstats_model.dart';
import 'package:v04/data/models/work_model.dart';

class HeroModel {

  int heroId;  
  String name;

  final PowerstatsModel powerstats;
  final BiographyModel biography;
  final AppearanceModel appearance;
  final ImageModel image;
  final WorkModel? work;
  final ConnectionsModel? connections;

  HeroModel({
      this.heroId = 0,
      required this.name,
      required this.powerstats,
      required this.biography,
      required this.appearance,
      required this.image,
      this.work,
      this.connections
  });

  // Deserialization
  factory HeroModel.fromJson(Map<String, dynamic> json){
    List<String> missingFields = [];

    if(json["hero-id"] == null) missingFields.add("hero-id");
    if(json["name"] == null) missingFields.add("name");
    if(json["powerstats"] == null) missingFields.add("intelligence");
    if(json["biography"] == null) missingFields.add("strength");
    if(json["appearance"] == null) missingFields.add("speed");
    if(json["image"] == null) missingFields.add("image");

    if(missingFields.isNotEmpty){
        throw FormatException("Missing required fields: ${missingFields.join(", ")}");
    }

    return HeroModel(
        heroId : int.parse(json["hero-id"]),
        name : json["name"],
        powerstats : json["powerstats"] != null
                    ? PowerstatsModel.fromJson(json["powerstats"])
                    : PowerstatsModel(intelligence: 0, strength: 0, speed: 0, durability: 0, power: 0, combat: 0),
        biography : json["biography"] != null
                    ? BiographyModel.fromJson(json["biography"])
                    : BiographyModel(placeOfBirth: "unknown", firstAppearance: "unknown", publisher: "unknown", alignment: "unknown"),
        appearance : json["appearance"] != null
                    ? AppearanceModel.fromJson(json["appearance"])
                    : AppearanceModel(gender: "unknown", race: "unknown", height: ["unknown"], weight: ["unknown"]),
        work : WorkModel.fromJson(json["work"]),
        connections : ConnectionsModel.fromJson(json["connections"]),
        image : json["image"] != null
                ? ImageModel.fromJson(json["image"])
                : ImageModel(url: "unknown"),
    );
  }
    
  // Serialization
  Map<String, dynamic> toJson() => {
    "hero-id": heroId.toString(),
    "name": name,
    "powerstats": powerstats.toJson(),
    "biography": biography.toJson(),
    "appearance": appearance.toJson(),
    "image": image.toJson(),
    "work": work?.toJson(),
    "connections": connections?.toJson()
  };

  // Function to override toString and print the HeroModel more user friendly
  @override
  String toString() {
    return ("""
=====================================================
Id:     $heroId
Namn:   $name
${powerstats.toString()}
${biography.toString()}
${appearance.toString()}
${work.toString()}
${connections.toString()}
=====================================================
""");
  }
}