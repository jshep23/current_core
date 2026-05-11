import 'package:current_core/current_core.dart';

class InterstellarSpacecraftViewModel extends CurrentStateViewModel {
  final destination = CurrentProperty.string(initialValue: 'Alpha Centauri');
  final crewCount = CurrentProperty.integer(initialValue: 5);

  @override
  Iterable<CurrentProperty<dynamic>> get currentProps => [crewCount, destination];

  @override
  void notifyListeners() {
    // In a real application, this would trigger UI updates. (eg via ChangeNotifier in Flutter)
    print(
      'Notify Listeners Automatically Called on Property Updated -> Spacecraft state updated: Destination - ${destination.value}, Crew Count - ${crewCount.value}',
    );
  }

  void updateDestination(String newDestination) {
    destination.value = newDestination;
  }

  void ejectCrewMember() {
    if (crewCount.value > 0) {
      crewCount.value -= 1;
    }

    print(
      'Crew member stole another crew member\'s last coffee and got ejected. Remaining crew count: ${crewCount.value}',
    );
  }
}
