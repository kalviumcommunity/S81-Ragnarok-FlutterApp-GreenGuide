import 'package:flutter/foundation.dart';

import 'product.dart';
import 'reminder.dart';

@immutable
class Plant {
  final String id;
  final String name;
  final String image;
  final String wateringFrequency;
  final String sunlight;
  final String fertilizerNotes;
  final String repottingWindow;
  final String description;
  final List<String> commonIssues;
  final List<Reminder> reminders;
  final List<Product> productRecommendations;

  const Plant({
    required this.id,
    required this.name,
    required this.image,
    required this.wateringFrequency,
    required this.sunlight,
    required this.fertilizerNotes,
    required this.repottingWindow,
    required this.description,
    this.commonIssues = const [],
    this.reminders = const [],
    this.productRecommendations = const [],
  });

  Plant copyWith({
    String? id,
    String? name,
    String? image,
    String? wateringFrequency,
    String? sunlight,
    String? fertilizerNotes,
    String? repottingWindow,
    String? description,
    List<String>? commonIssues,
    List<Reminder>? reminders,
    List<Product>? productRecommendations,
  }) {
    return Plant(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      wateringFrequency: wateringFrequency ?? this.wateringFrequency,
      sunlight: sunlight ?? this.sunlight,
      fertilizerNotes: fertilizerNotes ?? this.fertilizerNotes,
      repottingWindow: repottingWindow ?? this.repottingWindow,
      description: description ?? this.description,
      commonIssues: commonIssues ?? this.commonIssues,
      reminders: reminders ?? this.reminders,
      productRecommendations: productRecommendations ?? this.productRecommendations,
    );
  }
}
