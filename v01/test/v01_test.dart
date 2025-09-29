import 'package:test/test.dart';
import 'package:v01/v01.dart';

void main() {
  // Groups tests together instead of running several single tests
  group('calculate', () {
    // Test to check the addition equation works in the calculate() function
    // and proseeds to check every operation in that function
    test('adds two numbers', () {
      expect(calculate(40, 2, '+'), equals(42));
    });

    test('subtracts two numbers', () {
      expect(calculate(50, 8, '-'), equals(42));
    });

    test('multiplies two numbers', () {
      expect(calculate(21, 2, '*'), equals(42));
    });

    test('divides two numbers', () {
      expect(calculate(84, 2, '/'), equals(42));
    });
  });
}



// void main() {
//   test('calculate', () {
//     expect(calculate(), 42);
//   });
// }
