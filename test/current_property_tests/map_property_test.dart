import 'package:current_core/current_core.dart';
import 'package:test/test.dart';

class MapViewModel extends CurrentStateViewModel {
  final data = CurrentMapProperty<String, String>.empty(propertyName: 'data');

  @override
  Iterable<CurrentProperty> get currentProps => [data];

  @override
  void notifyListeners() {}
}

void main() {
  group('CurrentMapProperty Tests', () {
    late MapViewModel viewModel;

    setUp(() {
      viewModel = MapViewModel();
    });

    test('containsKey - has matching key - returns true', () {
      const String key = 'name';
      const String value = 'Bob';

      viewModel.data.add(key, value);

      final result = viewModel.data.containsKey(key);

      expect(result, isTrue);
    });

    test('containsKey - has no matching key - returns false', () {
      const String key = 'name';
      const String value = 'Bob';
      const String missingKey = 'lastName';

      viewModel.data.add(key, value);

      final result = viewModel.data.containsKey(missingKey);

      expect(result, isFalse);
    });

    test('containsValue - has matching value - returns true', () {
      const String key = 'name';
      const String value = 'Bob';

      viewModel.data.add(key, value);

      final result = viewModel.data.containsValue(value);

      expect(result, isTrue);
    });

    test('containsValue - has no matching value - returns false', () {
      const String key = 'name';
      const String value = 'Bob';
      const String missingValue = 'Smith';

      viewModel.data.add(key, value);

      final result = viewModel.data.containsValue(missingValue);

      expect(result, isFalse);
    });

    test('[] operator - has matching key - returns value', () {
      const String key = 'name';
      const String value = 'Bob';

      viewModel.data.add(key, value);

      final result = viewModel.data[key];

      expect(result, equals(value));
    });

    test('[] operator - has no matching key - returns null', () {
      const String key = 'name';
      const String value = 'Bob';
      const String missingKey = 'lastName';

      viewModel.data.add(key, value);

      final result = viewModel.data[missingKey];

      expect(result, isNull);
    });

    test('isDirty - map is unchanged from original value - returns false', () {
      final data = CurrentMapProperty<String, String>({'name': 'Bob'});

      expect(data.isDirty, isFalse);
    });

    test('add - emits event with property metadata', () async {
      CurrentStateChanged? receivedEvent;

      final subscription = viewModel.addAnyStateChangedListener((event) => receivedEvent = event);

      viewModel.data.add('name', 'Bob');
      await Future<void>.microtask(() {});

      expect(receivedEvent, isNotNull);
      final nextValue = receivedEvent?.nextValue as MapEntry<String, String>?;
      expect(nextValue?.key, equals('name'));
      expect(nextValue?.value, equals('Bob'));
      expect(receivedEvent?.previousValue, isNull);
      expect(receivedEvent?.propertyName, equals('data'));
      expect(receivedEvent?.sourceHashCode, equals(viewModel.data.sourceHashCode));

      await subscription.cancel();
    });

    test('addAll - capturePrevious captures previous map state', () async {
      CurrentStateChanged? receivedEvent;
      final subscription = viewModel.addAnyStateChangedListener((event) => receivedEvent = event);

      viewModel.data.addAll({'name': 'Bob'}, notifyChanges: false);
      viewModel.data.addAll({'planet': 'Earth'}, capturePrevious: true);
      await Future<void>.microtask(() {});

      expect(receivedEvent?.previousValue, equals({'name': 'Bob'}));
      await subscription.cancel();
    });

    test('addEntries - capturePrevious captures previous map state', () async {
      CurrentStateChanged? receivedEvent;
      final subscription = viewModel.addAnyStateChangedListener((event) => receivedEvent = event);

      viewModel.data.addAll({'name': 'Bob'}, notifyChanges: false);
      viewModel.data.addEntries([const MapEntry('planet', 'Earth')], capturePrevious: true);
      await Future<void>.microtask(() {});

      final previousEntries = receivedEvent?.previousValue as Iterable<MapEntry<String, String>>?;
      expect(previousEntries?.first.key, equals('name'));
      expect(previousEntries?.first.value, equals('Bob'));
      await subscription.cancel();
    });

    test('clear - emits a concrete snapshot of previous items', () async {
      CurrentStateChanged? receivedEvent;

      final subscription = viewModel.addAnyStateChangedListener((event) => receivedEvent = event);

      viewModel.data.addAll({'name': 'Bob', 'planet': 'Earth'}, notifyChanges: false);
      viewModel.data.clear();
      await Future<void>.microtask(() {});

      expect(receivedEvent, isNotNull);
      expect(receivedEvent?.previousValue, isNull);
      expect(receivedEvent?.nextValue, equals(<String, String>{}));
      expect(receivedEvent?.propertyName, equals('data'));

      await subscription.cancel();
    });

    test('clear - capturePrevious captures previous map state', () async {
      CurrentStateChanged? receivedEvent;
      final subscription = viewModel.addAnyStateChangedListener((event) => receivedEvent = event);

      viewModel.data.addAll({'name': 'Bob'}, notifyChanges: false);
      viewModel.data.clear(capturePrevious: true);
      await Future<void>.microtask(() {});

      expect(receivedEvent?.previousValue, equals({'name': 'Bob'}));
      await subscription.cancel();
    });

    test('isDirty - map changes from original value - returns true', () {
      final data = CurrentMapProperty<String, String>({'name': 'Bob'});
      data.setViewModel(viewModel);

      data.add('lastName', 'Smith', notifyChanges: false);

      expect(data.isDirty, isTrue);
    });

    test('reset - starting map is empty - add item - should be empty after reset', () {
      final data = CurrentMapProperty<String, String>.empty();
      data.setViewModel(viewModel);
      data.add('name', 'Bob');

      expect(data.isNotEmpty, isTrue);

      data.reset();

      expect(data.isEmpty, isTrue);
    });

    test('reset - starting map has data - add item - only original data after reset', () {
      const String key = 'firstName';
      const String value = 'Bob';
      const String tmpKey = 'lastName';
      const String tmpValue = 'Smith';

      final data = CurrentMapProperty<String, String>({key: value});
      data.setViewModel(viewModel);

      expect(data.containsKey(key), isTrue);
      expect(data.containsValue(value), isTrue);

      data.add(tmpKey, tmpValue);

      expect(data.containsKey(tmpKey), isTrue);
      expect(data.containsValue(tmpValue), isTrue);

      data.reset();

      expect(data.containsKey(tmpKey), isFalse);
      expect(data.containsValue(tmpValue), isFalse);
      expect(data.containsKey(key), isTrue);
      expect(data.containsValue(value), isTrue);
    });

    test('resetting retains original value', () {
      final data = CurrentMapProperty<String, String>.empty();
      data.setViewModel(viewModel);
      data.add('name', 'Bob');

      data.reset();

      expect(data.isEmpty, isTrue);

      data.add('name', 'Bob');

      expect(data.originalValue.isEmpty, isTrue);
    });
  });
}
