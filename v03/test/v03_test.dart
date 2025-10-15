import 'package:test/test.dart';
import 'package:v03/managers/hero_data_manager.dart';


void main() {
  // Test to check if addHero adds a hero correctly
  // group('HeroRepository', () {
  //   test('should add a hero and auto-increment ID', () {
  //     final dataManager = HeroDataManager();

  //     dataManager.createHero('Batman', 9, 'Human', 'Good');
  //     dataManager.createHero('Spiderman',8, 'Mutant', 'Good');

  //     final heroes = dataManager.getAllHeroes();

  //     // There should be exactly 2 heroes (if the list is empty to start of with)
  //     expect(heroes.length, equals(2));

  //     // First hero should have ID 1 and correct name
  //     expect(heroes[0]['HeroId'], equals(1));
  //     expect(heroes[0]['name'], equals('Batman'));

  //     // Second hero should have ID 2
  //     expect(heroes[1]['HeroId'], equals(2));
  //     expect(heroes[1]['name'], equals('Spiderman'));

  //     // Check nested structure
  //     expect(heroes[1]['powerstats']['strength'], equals(8));
  //     expect(heroes[1]['appearance']['species'], equals('Mutant'));
  //     expect(heroes[1]['biography']['alignment'], equals('Good'));
  //   });
  // });
}
