import 'package:v03/managers/hero_data_manager.dart';
import 'package:v03/ui/application.dart';
import 'package:v03/data/mock_data.dart';

Future<void> main(List<String> arguments) async {
  final app = Application();
  final dataManager = HeroDataManager();
  MockData mockData = MockData();

  await mockData.loadMockHeroes(dataManager);

  app.startMenu();
}
