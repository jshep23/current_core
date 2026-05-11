import 'package:current_core/current_core.dart';
import 'package:current_core/src/current_exceptions.dart';
import 'package:test/test.dart';

class IntViewModel extends CurrentStateViewModel {
  final age = CurrentIntProperty(10);

  @override
  Iterable<CurrentProperty> get currentProps => [age];

  @override
  void notifyListeners() {}
}

class NullableIntViewModel extends CurrentStateViewModel {
  final age = CurrentNullableIntProperty(value: 10);

  @override
  Iterable<CurrentProperty> get currentProps => [age];

  @override
  void notifyListeners() {}
}

void main() {
  group('CurrentIntProperty Tests', () {
    late IntViewModel viewModel;

    setUp(() {
      viewModel = IntViewModel();
    });

    test('isOdd - number is odd - returns true', () {
      viewModel.age(3);
      final result = viewModel.age.isOdd;
      expect(result, isTrue);
    });

    test('isOdd - number is not odd - returns false', () {
      viewModel.age(2);
      final result = viewModel.age.isOdd;
      expect(result, isFalse);
    });

    test('isEven - number is even - returns true', () {
      viewModel.age(2);
      final result = viewModel.age.isEven;
      expect(result, isTrue);
    });

    test('isEven - number is not even - returns true', () {
      viewModel.age(3);
      final result = viewModel.age.isEven;
      expect(result, isFalse);
    });

    test('isNegative - number is negative - returns true', () {
      viewModel.age(-3);
      final result = viewModel.age.isNegative;
      expect(result, isTrue);
    });

    test('isNegative - number is not negative - returns true', () {
      viewModel.age(3);
      final result = viewModel.age.isNegative;
      expect(result, isFalse);
    });

    test('increment - returns increment value', () {
      const int expected = 4;
      viewModel.age(3);
      final result = viewModel.age.increment();
      expect(result, equals(expected));
      expect(viewModel.age.value, equals(expected));
    });

    test('decrement - returns decremented value', () {
      const int expected = 2;
      viewModel.age(3);
      final result = viewModel.age.decrement();
      expect(result, equals(expected));
      expect(viewModel.age.value, equals(expected));
    });

    test('add - other is int - returns correct int value', () {
      const expected = 2;
      final number = CurrentIntProperty(1);
      final result = number.add(1);

      expect(result, equals(expected));
    });

    test('add - explicit num generic with int value - returns num value', () {
      const num expected = 2;
      final number = CurrentIntProperty(1);
      final result = number.add<num>(1);

      expect(result, equals(expected));
    });

    test('addNumber - int value - returns numeric value', () {
      const num expected = 2;
      final number = CurrentIntProperty(1);
      final result = number.addNumber(1);

      expect(result, equals(expected));
    });

    test('add - other is double - returns correct double value', () {
      const expected = 2.5;
      final number = CurrentIntProperty(1);
      final result = number.add(1.5);

      expect(result, equals(expected));
    });

    test('addNumber - double value - returns numeric value', () {
      const num expected = 2.5;
      final number = CurrentIntProperty(1);
      final result = number.addNumber(1.5);

      expect(result, equals(expected));
    });

    test('subtract - other is int - returns correct int value', () {
      const expected = 2;
      final number = CurrentIntProperty(3);
      final result = number.subtract(1);

      expect(result, equals(expected));
    });

    test('subtractNumber - int value - returns numeric value', () {
      const num expected = 2;
      final number = CurrentIntProperty(3);
      final result = number.subtractNumber(1);

      expect(result, equals(expected));
    });

    test('subtract - other is double - returns correct double value', () {
      const expected = 2.5;
      final number = CurrentIntProperty(4);
      final result = number.subtract(1.5);

      expect(result, equals(expected));
    });

    test('subtractNumber - double value - returns numeric value', () {
      const num expected = 2.5;
      final number = CurrentIntProperty(4);
      final result = number.subtractNumber(1.5);

      expect(result, equals(expected));
    });

    test('multiply - other is int - returns correct int value', () {
      const expected = 4;
      final number = CurrentIntProperty(2);
      final result = number.multiply(2);

      expect(result, equals(expected));
    });

    test('multiplyNumber - int value - returns numeric value', () {
      const num expected = 4;
      final number = CurrentIntProperty(2);
      final result = number.multiplyNumber(2);

      expect(result, equals(expected));
    });

    test('multiply - other is double - returns correct double value', () {
      const expected = 5.4;
      final number = CurrentIntProperty(2);
      final result = number.multiply(2.7);

      expect(result, equals(expected));
    });

    test('multiplyNumber - double value - returns numeric value', () {
      const num expected = 5.4;
      final number = CurrentIntProperty(2);
      final result = number.multiplyNumber(2.7);

      expect(result, equals(expected));
    });

    test('divide - returns correct double value', () {
      const expected = 4.0;
      final number = CurrentIntProperty(8);
      final result = number.divide(2);

      expect(result, equals(expected));
    });

    test('mod - other is int - returns correct int value', () {
      const expected = 2;
      final number = CurrentIntProperty(5);
      final result = number.mod(3);

      expect(result, equals(expected));
    });

    test('modNumber - int value - returns numeric value', () {
      const num expected = 2;
      final number = CurrentIntProperty(5);
      final result = number.modNumber(3);

      expect(result, equals(expected));
    });

    test('mod - other is double - returns correct double value', () {
      const expected = 1.5;
      final number = CurrentIntProperty(5);
      final result = number.mod(3.5);

      expect(result, equals(expected));
    });

    test('modNumber - double value - returns numeric value', () {
      const num expected = 1.5;
      final number = CurrentIntProperty(5);
      final result = number.modNumber(3.5);

      expect(result, equals(expected));
    });

    test('nullable addNumber - null value - throws CurrentPropertyNullValueException', () {
      final number = CurrentNullableIntProperty();

      expect(() => number.addNumber(1), throwsA(isA<CurrentPropertyNullValueException>()));
    });

    test('nullable addNumber - double value - returns numeric value', () {
      final number = CurrentNullableIntProperty(value: 1);
      final result = number.addNumber(1.5);

      expect(result, equals(2.5));
    });

    test('nullable subtractNumber - null value - throws CurrentPropertyNullValueException', () {
      final number = CurrentNullableIntProperty();

      expect(() => number.subtractNumber(1), throwsA(isA<CurrentPropertyNullValueException>()));
    });

    test('nullable subtractNumber - double value - returns numeric value', () {
      final number = CurrentNullableIntProperty(value: 4);
      final result = number.subtractNumber(1.5);

      expect(result, equals(2.5));
    });

    test('nullable multiplyNumber - null value - throws CurrentPropertyNullValueException', () {
      final number = CurrentNullableIntProperty();

      expect(() => number.multiplyNumber(2), throwsA(isA<CurrentPropertyNullValueException>()));
    });

    test('nullable multiplyNumber - double value - returns numeric value', () {
      final number = CurrentNullableIntProperty(value: 2);
      final result = number.multiplyNumber(2.7);

      expect(result, equals(5.4));
    });

    test('nullable modNumber - null value - throws CurrentPropertyNullValueException', () {
      final number = CurrentNullableIntProperty();

      expect(() => number.modNumber(3), throwsA(isA<CurrentPropertyNullValueException>()));
    });

    test('nullable modNumber - double value - returns numeric value', () {
      final number = CurrentNullableIntProperty(value: 5);
      final result = number.modNumber(3.5);

      expect(result, equals(1.5));
    });
  });
}
