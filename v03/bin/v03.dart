import 'package:v03/ui/application.dart';
import 'package:v03/data/dummy_data.dart';
void main(List<String> arguments) {
  Application app = Application();
  DummyData dummyData = DummyData();

  dummyData.dummyData();
  app.startMenu();
}
