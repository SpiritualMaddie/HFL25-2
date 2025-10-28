import 'package:v04/ui/application.dart';

Future<void> main(List<String> arguments) async {
  final app = Application();
  await app.loadHeroesFromLocalJson();
  app.startMenu();
}
