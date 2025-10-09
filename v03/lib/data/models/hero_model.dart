import 'package:v03/data/models/appearance_model.dart';
import 'package:v03/data/models/biography_model.dart';
import 'package:v03/data/models/connections.dart';
import 'package:v03/data/models/image_model.dart';
import 'package:v03/data/models/powerstats_model.dart';
import 'package:v03/data/models/work_model.dart';

class HeroModel {

  int heroId;  
  String name;

  final PowerstatsModel powerstats;
  final BiographyModel biography;
  final AppearanceModel appearance;
  final ImageModel image;
  final WorkModel? work;
  final Connections? connections;

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
        heroId : json["hero-id"],
        name : json["name"],
        powerstats : json["powerstats"],
        biography : json["biography"],
        appearance : json["appearance"],
        work : json["work"],
        connections : json["connections"],
        image : json["image"],
    );
  }
    
  // Serialization
  Map<String, dynamic> toJson() => {
    "hero-id": heroId,
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