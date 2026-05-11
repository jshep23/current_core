import 'dart:async';
import 'dart:io';

import 'package:example/interstellar_spacecraft_view_model.dart';

Future<void> main(List<String> arguments) async {
  final spaceCraft = InterstellarSpacecraftViewModel();

  print(
    'Initial Spacecraft State: Destination - ${spaceCraft.destination.value}, Crew Count - ${spaceCraft.crewCount.value}',
  );

  stdout.writeln('Enter a new destination for the spacecraft:');

  final newDestination = stdin.readLineSync() ?? 'Unknown';

  spaceCraft.updateDestination(newDestination);

  print('Updating spacecraft destination to: $newDestination');

  print('\n\n');

  spaceCraft.ejectCrewMember();

  final timer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
    print('.');
  });

  // Simulate some delay to show the timer in action
  await Future.delayed(const Duration(seconds: 2));
  timer.cancel();

  print(
    'Arrival at destination: ${spaceCraft.destination.value} with ${spaceCraft.crewCount.value} crew members remaining.',
  );
}
