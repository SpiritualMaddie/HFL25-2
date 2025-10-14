import 'dart:io';
import 'package:v03/data/models/biography_model.dart';
import 'package:v03/data/models/appearance_model.dart';
import 'package:v03/data/models/powerstats_model.dart';
import 'package:v03/data/models/work_model.dart';
import 'package:v03/data/models/connections_model.dart';
import 'package:v03/data/models/image_model.dart';
import 'package:v03/utils/input_utils.dart';
import 'package:v03/utils/console_utils.dart';
import 'package:v03/validators/get_valid_int.dart';

class GetModelInput {

final inputUtils = InputUtils();
final consoleUtils = ConsoleUtils();
final getValidInt = GetValidInt();

  PowerstatsModel getPowerStatsInput(){
    stdout.writeln("\n💪 Powerstats - Fyll i hjältens styrkor:");

    int intelligence = getValidInt.getValidIntWithLoopMax100("Vad har superhjälten för intelligens (ange heltal)?");
    int strength = getValidInt.getValidIntWithLoopMax100("Vad har superhjälten för styrka (ange heltal)?");
    int speed = getValidInt.getValidIntWithLoopMax100("Vad har superhjälten för snabbhet (ange heltal)?");
    int durability = getValidInt.getValidIntWithLoopMax100("Vad har superhjälten för hållbarhet (ange heltal)?");
    int power = getValidInt.getValidIntWithLoopMax100("Vad har superhjälten för kraft (ange heltal)?");
    int combat = getValidInt.getValidIntWithLoopMax100("Vad har superhjälten för stridsvärde (ange heltal)?");

    return PowerstatsModel(
      intelligence: intelligence, 
      strength: strength, 
      speed: speed, 
      durability: durability, 
      power: power, 
      combat: combat);
  }

  BiographyModel getBiographyInput() {
    stdout.writeln("\n📜 Biografi - Fyll i hjälteinformation:");

    String fullName = inputUtils.promptOptional("Fullständigt namn  (Kan lämnas tomt):");
    String alterEgos = inputUtils.promptOptional("Alter egon (kan lämnas tomt):");
    List<String> aliases = inputUtils.promptList("Alias (separera med kommatecken):");
    String placeOfBirth = inputUtils.promptNotEmpty("Födelseplats:");
    String firstAppearance = inputUtils.promptNotEmpty("Första framträdande:");
    String publisher = inputUtils.promptNotEmpty("Utgivare:");
    String alignment = inputUtils.promptFromOptions(
      "Moral/alignment:",
      ["good", "neutral", "evil", "chaotic good", "neutral good"],
    );

    return BiographyModel(
      fullName: fullName,
      alterEgos: alterEgos,
      aliases: aliases,
      placeOfBirth: placeOfBirth,
      firstAppearance: firstAppearance,
      publisher: publisher,
      alignment: alignment,
    );
}

  AppearanceModel getAppearanceInput() {
    stdout.writeln("\n🧬 Utseende - Beskriv hjälten:");

    String gender = inputUtils.promptFromOptions("Kön:" , ["male", "female", "non-binary"]);
    String race = inputUtils.promptNotEmpty("Ras/art:");
    List<String> height = inputUtils.promptList("Längd (ex: 6'3, 191 cm):");
    List<String> weight = inputUtils.promptList("Vikt (ex: 225 lb, 102 kg):");
    String eyeColor = inputUtils.promptOptional("Ögonfärg  (Kan lämnas tomt):");
    String hairColor = inputUtils.promptOptional("Hårfärg  (Kan lämnas tomt):");

    return AppearanceModel(
      gender: gender,
      race: race,
      height: height,
      weight: weight,
      eyeColor: eyeColor,
      hairColor: hairColor,
    );
  }

  WorkModel getWorkInput() {
    stdout.writeln("\n💼 Arbete - Hjältens yrkesliv:");

    String occupation = inputUtils.promptOptional("Yrke (Kan lämnas tomt):");
    String base = inputUtils.promptOptional("Bas/plats (Kan lämnas tomt):");

    return WorkModel(
      occupation: occupation,
      base: base,
    );
  }

  ConnectionsModel getConnectionsInput() {
    stdout.writeln("\n🤝 Kontakter - Relationer och grupper:");

    String groupAffiliation = inputUtils.promptOptional("Gruppanknytning (Kan lämnas tomt):");
    String relatives = inputUtils.promptOptional("Anhöriga (Kan lämnas tomt):");

    return ConnectionsModel(
      groupAffiliation: groupAffiliation,
      relatives: relatives,
    );
  }

  ImageModel getImageInput() {
    stdout.writeln("\n🖼️ Bild - Ange en URL till hjältebild:");

    String url = inputUtils.promptNotEmpty("Bild-URL:");

    return ImageModel(url: url);
  }  
}