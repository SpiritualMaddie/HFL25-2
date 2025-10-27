import 'dart:convert';
import 'dart:io';

import 'package:dotenv/dotenv.dart' as dotenv;
import 'package:v04/data/models/hero_model.dart';
import 'package:v04/interfaces/ilocal_file_repository.dart';

class LocalFileRepository implements ILocalFileRepository {
  final String localFilePath;

  LocalFileRepository({required this.localFilePath});

  // Env
  final env = dotenv.DotEnv()..load();

  // Path to json "lib/data/hero_mock_data.json"

  // Reads the local file in the localFilePath and returns a list of HeroModel objects based on whats in the local json file
  @override
  Future<List<HeroModel>> readLocalHeroFile() async {
    try {
      final file = File(localFilePath);

      if (!await file.exists()) {
        print("⚠️ Ingen lokal fil hittades, returnerar tom lista.");
        return [];
      }

      final contents = await file.readAsString();
      final List<dynamic> jsonData = jsonDecode(contents);

      final heroes = jsonData
          .map<HeroModel>((h) => HeroModel.fromJson(h))
          .toList();
      return heroes;
    } catch (e) {
      print("❌ Misslyckades att ladda hjältar och skurkar: $e");
      return [];
    }
  }

  // Updates and writes over the local file in the localFilePath with the List of HeroModel objects passed as an argument
  @override
  Future<void> updateLocalHeroFile(List<HeroModel> heroesList) async {
    try {
      final file = File(localFilePath);

      await file.writeAsString(
        jsonEncode(heroesList),
        flush: true,
        mode: FileMode.write,
      );

      print("💾 Hjältar och skurkar sparade.");
    } catch (e, st) {
      print("❌ Misslyckades att spara hjältar och skurkar: $e");
      print("Stack trace: $st");
    }
  }
}
