import 'package:current_core/current_core.dart';
import 'package:test/test.dart';

class BoolViewModel extends CurrentStateViewModel {
  final isAwesome = CurrentBoolProperty(true);

  @override
  Iterable<CurrentProperty> get currentProps => [isAwesome];
  @override
  void notifyListeners() {}
}

class NullableBoolViewModel extends CurrentStateViewModel {
  final isAwesome = CurrentNullableBoolProperty();

  @override
  Iterable<CurrentProperty> get currentProps => [isAwesome];
  @override
  void notifyListeners() {}
}

void main() {
  group('CurrentBoolProperty Tests', () {
    late BoolViewModel viewModel;
    setUp(() {
      viewModel = BoolViewModel();
    });

    test('isTrue - value is true - returns true', () {
      viewModel.isAwesome(true);
      expect(viewModel.isAwesome.isTrue, isTrue);
    });

    test('isTrue - value is false - returns false', () {
      viewModel.isAwesome(false);
      expect(viewModel.isAwesome.isTrue, isFalse);
    });

    test('isFalse - value is false - returns true', () {
      viewModel.isAwesome(false);
      expect(viewModel.isAwesome.isFalse, isTrue);
    });

    test('isFalse - value is true - returns false', () {
      viewModel.isAwesome(true);
      expect(viewModel.isAwesome.isFalse, isFalse);
    });

    test('setTrue - value is true', () {
      viewModel.isAwesome.set(false);
      viewModel.isAwesome.setTrue();
      expect(viewModel.isAwesome.isTrue, isTrue);
    });

    test('setFalse - value is false', () {
      viewModel.isAwesome.set(true);
      viewModel.isAwesome.setFalse();
      expect(viewModel.isAwesome.isFalse, isTrue);
    });
  });

  group('CurrentNullableBoolProperty Tests', () {
    late NullableBoolViewModel viewModel;

    setUp(() {
      viewModel = NullableBoolViewModel();
    });

    test('isTrue - value is true - returns true', () {
      viewModel.isAwesome(true);
      expect(viewModel.isAwesome.isTrue, isTrue);
    });

    test('isTrue - value is false - returns false', () {
      viewModel.isAwesome(false);
      expect(viewModel.isAwesome.isTrue, isFalse);
    });

    test('isTrue - value is null - returns false', () {
      viewModel.isAwesome(null);
      expect(viewModel.isAwesome.isTrue, isFalse);
    });

    test('isFalse - value is false - returns true', () {
      viewModel.isAwesome(false);
      expect(viewModel.isAwesome.isFalse, isTrue);
    });

    test('isFalse - value is true - returns false', () {
      viewModel.isAwesome(true);
      expect(viewModel.isAwesome.isFalse, isFalse);
    });

    test('isFalse - value is null - returns false', () {
      viewModel.isAwesome(null);
      expect(viewModel.isAwesome.isFalse, isFalse);
    });

    test('setTrue - value is true', () {
      viewModel.isAwesome.set(false);
      viewModel.isAwesome.setTrue();
      expect(viewModel.isAwesome.isTrue, isTrue);
    });

    test('setFalse - value is false', () {
      viewModel.isAwesome.set(true);
      viewModel.isAwesome.setFalse();
      expect(viewModel.isAwesome.isFalse, isTrue);
    });

    test('setNull - value is null', () {
      viewModel.isAwesome.set(false);
      viewModel.isAwesome.setNull();
      expect(viewModel.isAwesome.isNull, isTrue);
    });
  });
}
