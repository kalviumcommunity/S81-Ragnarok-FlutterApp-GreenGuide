import 'package:flutter/foundation.dart';

import '../data/green_guide_repository.dart';
import '../models/plant.dart';

class PlantLibrary {
  PlantLibrary._();

  static final ValueNotifier<List<Plant>> myPlants = ValueNotifier(
    GreenGuideRepository.starterPlants,
  );

  static void addPlant(Plant plant) {
    final updated = List<Plant>.from(myPlants.value)..add(plant);
    myPlants.value = updated;
  }

  static bool addPlantFromCode(String code) {
    final trimmed = code.trim().toUpperCase();
    final template = GreenGuideRepository.plantCodes[trimmed];
    if (template == null) {
      return false;
    }
    final newPlant = template.copyWith(id: '$trimmed-${DateTime.now().millisecondsSinceEpoch}');
    addPlant(newPlant);
    return true;
  }
}
