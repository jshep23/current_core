import 'package:current_core/current_core.dart';
import 'package:test/test.dart';

class DoubleViewModel extends CurrentStateViewModel {
  final percentage = CurrentDoubleProperty(10.0);

  @override
  Iterable<CurrentProperty> get currentProps => [percentage];

  @override
  void notifyListeners() {}
}

class NullableDoubleViewModel extends CurrentStateViewModel {
  final percentage = CurrentNullableDoubleProperty();

  @override
  Iterable<CurrentProperty> get currentProps => [percentage];

  @override
  void notifyListeners() {}
}

void main() {
  group('CurrentDoubleProperty Tests', () {
    late DoubleViewModel viewModel;

    setUp(() {
      viewModel = DoubleViewModel();
    });

    test('round - widget updates', () {
      const double expectedValue = 10;
      const double startingValue = 10.2;

      viewModel.percentage(startingValue);

      final result = viewModel.percentage.round();

      expect(result, equals(expectedValue));
    });

    test('roundToDouble - widget updates', () {
      const double expectedValue = 10.0;
      const double startingValue = 10.23;

      viewModel.percentage(startingValue);

      final result = viewModel.percentage.roundToDouble();

      expect(result, equals(expectedValue));
    });

    test('isNegative - number is negative - returns true', () {
      viewModel.percentage(-3);
      final result = viewModel.percentage.isNegative;
      expect(result, isTrue);
    });

    test('isNegative - number is not negative - returns true', () {
      viewModel.percentage(3);
      final result = viewModel.percentage.isNegative;
      expect(result, isFalse);
    });

    test('add - other is int - returns correct double value', () {
      const expected = 2;
      final number = CurrentDoubleProperty(1);
      final result = number.add(1);

      expect(result, equals(expected));
    });

    test('add - other is double - returns correct double value', () {
      const expected = 2.5;
      final number = CurrentDoubleProperty(1);
      final result = number.add(1.5);

      expect(result, equals(expected));
    });

    test('subtract - other is int - returns correct double value', () {
      const expected = 2;
      final number = CurrentDoubleProperty(3);
      final result = number.subtract(1);

      expect(result, equals(expected));
    });

    test('subtract - other is double - returns correct double value', () {
      const expected = 2.5;
      final number = CurrentDoubleProperty(4);
      final result = number.subtract(1.5);

      expect(result, equals(expected));
    });

    test('multiply - other is int - returns correct double value', () {
      const expected = 4;
      final number = CurrentDoubleProperty(2);
      final result = number.multiply(2);

      expect(result, equals(expected));
    });

    test('multiply - other is double - returns correct double value', () {
      const expected = 5.4;
      final number = CurrentDoubleProperty(2);
      final result = number.multiply(2.7);

      expect(result, equals(expected));
    });

    test('divide - returns correct double value', () {
      const expected = 4.0;
      final number = CurrentDoubleProperty(8);
      final result = number.divide(2);

      expect(result, equals(expected));
    });

    test('mod - other is int - returns correct double value', () {
      const expected = 2;
      final number = CurrentDoubleProperty(5);
      final result = number.mod(3);

      expect(result, equals(expected));
    });

    test('mod - other is double - returns correct double value', () {
      const expected = 1.5;
      final number = CurrentDoubleProperty(5);
      final result = number.mod(3.5);

      expect(result, equals(expected));
    });
  });

  group('CurrentNullableDoubleProperty Tests', () {
    late NullableDoubleViewModel viewModel;

    setUp(() {
      viewModel = NullableDoubleViewModel();
    });

    test('isNegative - value is null - returns false', () {
      expect(viewModel.percentage.isNegative, isFalse);
    });

    test('isNegative - number is negative - returns true', () {
      viewModel.percentage(-3.2);

      expect(viewModel.percentage.isNegative, isTrue);
    });

    test('toInt - value is null - returns null', () {
      expect(viewModel.percentage.toInt(), isNull);
    });

    test('toInt - value is set - returns truncated int', () {
      viewModel.percentage(10.75);

      expect(viewModel.percentage.toInt(), equals(10));
    });

    test('round - value is null - returns null', () {
      expect(viewModel.percentage.round(), isNull);
    });

    test('round - value is set - returns rounded int', () {
      viewModel.percentage(10.5);

      expect(viewModel.percentage.round(), equals(11));
    });

    test('roundToDouble - value is null - returns null', () {
      expect(viewModel.percentage.roundToDouble(), isNull);
    });

    test('roundToDouble - value is set - returns rounded double', () {
      viewModel.percentage(10.23);

      expect(viewModel.percentage.roundToDouble(), equals(10.0));
    });

    test('add - value is null - throws CurrentPropertyNullValueException', () {
      expect(() => viewModel.percentage.add(1), throwsA(isA<CurrentPropertyNullValueException>()));
    });

    test('add - value is set - returns correct double value', () {
      viewModel.percentage(1.0);

      expect(viewModel.percentage.add(1.5), equals(2.5));
    });

    test('subtract - value is null - throws CurrentPropertyNullValueException', () {
      expect(() => viewModel.percentage.subtract(1), throwsA(isA<CurrentPropertyNullValueException>()));
    });

    test('subtract - value is set - returns correct double value', () {
      viewModel.percentage(4.0);

      expect(viewModel.percentage.subtract(1.5), equals(2.5));
    });

    test('multiply - value is null - throws CurrentPropertyNullValueException', () {
      expect(() => viewModel.percentage.multiply(2), throwsA(isA<CurrentPropertyNullValueException>()));
    });

    test('multiply - value is set - returns correct double value', () {
      viewModel.percentage(2.0);

      expect(viewModel.percentage.multiply(2.7), equals(5.4));
    });

    test('divide - value is null - throws CurrentPropertyNullValueException', () {
      expect(() => viewModel.percentage.divide(2), throwsA(isA<CurrentPropertyNullValueException>()));
    });

    test('divide - value is set - returns correct double value', () {
      viewModel.percentage(8.0);

      expect(viewModel.percentage.divide(2), equals(4.0));
    });

    test('mod - value is null - throws CurrentPropertyNullValueException', () {
      expect(() => viewModel.percentage.mod(3), throwsA(isA<CurrentPropertyNullValueException>()));
    });

    test('mod - value is set - returns correct double value', () {
      viewModel.percentage(5.0);

      expect(viewModel.percentage.mod(3.5), equals(1.5));
    });
  });
}
