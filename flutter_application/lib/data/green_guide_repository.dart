import '../models/product.dart';
import '../models/plant.dart';
import '../models/reminder.dart';

class GreenGuideRepository {
  GreenGuideRepository._();

  static final List<Product> sampleProducts = [
    const Product(
      id: 'soil-mix',
      name: 'Eco Soil Mix',
      description: 'Aerated blend for succulents and indoor greens.',
      category: 'Soil',
      price: 18.0,
      imageUrl: 'https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?auto=format&fit=crop&w=800&q=60',
    ),
    const Product(
      id: 'fertilizer',
      name: 'Liquid Plant Booster',
      description: 'Balanced micro-nutrients for steady growth.',
      category: 'Fertilizer',
      price: 26.0,
      imageUrl: 'https://images.unsplash.com/photo-1524592093008-5c3b3b036e38?auto=format&fit=crop&w=800&q=60',
    ),
    const Product(
      id: 'pots',
      name: 'Smart Terra Pots',
      description: 'Self-watering ceramic pots to prevent overwatering.',
      category: 'Planter',
      price: 32.0,
      imageUrl: 'https://images.unsplash.com/photo-1501004318641-b39e6451bec6?auto=format&fit=crop&w=800&q=60',
    ),
  ];

  static final List<Plant> basePlants = [
    Plant(
      id: 'snake-plant',
      name: 'Snake Plant',
      image: 'https://images.unsplash.com/photo-1469474968028-56623f02e42e?auto=format&fit=crop&w=900&q=60',
      wateringFrequency: 'Water every 10-14 days. Allow top soil to dry between sessions.',
      sunlight: 'Bright indirect light or shade tolerant. Avoid direct noon sun.',
      fertilizerNotes: 'Feed with diluted liquid fertilizer once a month in spring/summer.',
      repottingWindow: 'Repot every 2-3 years when roots start lifting the pot.',
      description: 'A forgiving indoor plant perfect for busy schedules.',
      commonIssues: ['Yellowing tips = overwatering', 'Brown spots = direct sun'],
      reminders: _buildReminders('Snake Plant', const Duration(days: 5), const Duration(days: 30)),
      productRecommendations: [
        sampleProducts[0],
        sampleProducts[2],
      ],
    ),
    Plant(
      id: 'aloe-vera',
      name: 'Aloe Vera',
      image: 'https://images.unsplash.com/photo-1501004318641-b39e6451bec6?auto=format&fit=crop&w=900&q=60',
      wateringFrequency: 'Water every 21-28 days, let soil dry completely.',
      sunlight: 'Needs bright light with 4-6 hours of direct sun.',
      fertilizerNotes: 'Use cactus/succulent fertilizer once per season.',
      repottingWindow: 'Repot every 2 years or when pups crowd the pot.',
      description: 'Medicinal succulent that thrives on neglect.',
      commonIssues: ['Soft leaves = too much water', 'Brown tips = too much sun'],
      reminders: _buildReminders('Aloe Vera', const Duration(days: 9), const Duration(days: 60)),
      productRecommendations: [
        sampleProducts[0],
        sampleProducts[1],
      ],
    ),
    Plant(
      id: 'rose',
      name: 'Rose (Indoor Miniature)',
      image: 'https://images.unsplash.com/photo-1501004318641-b39e6451bec6?auto=format&fit=crop&w=900&q=60',
      wateringFrequency: 'Water twice weekly with room temperature water.',
      sunlight: 'Needs 6+ hours of bright light; morning sun is ideal.',
      fertilizerNotes: 'NPK 10-10-10 every 2 weeks during blooming.',
      repottingWindow: 'Repot annually in spring to refresh nutrition.',
      description: 'Compact rose variety for balconies and bright windows.',
      commonIssues: ['Powdery mildew = improve airflow', 'Drooping blooms = underwatering'],
      reminders: _buildReminders('Indoor Rose', const Duration(days: 2), const Duration(days: 14)),
      productRecommendations: [
        sampleProducts[1],
        sampleProducts[2],
      ],
    ),
  ];

  static final Map<String, Plant> plantCodes = {
    'ECO001': basePlants[0],
    'ECO002': basePlants[1],
    'ECO003': basePlants[2],
  };

  static List<Plant> get starterPlants => basePlants.map((plant) => plant.copyWith()).toList();

  static List<Reminder> _buildReminders(String plantName, Duration watering, Duration fertilizing) {
    final now = DateTime.now();
    return [
      Reminder(
        title: 'Water $plantName',
        message: '$plantName loves slow, deep watering today.',
        severity: 'High',
        dueDate: now.add(watering),
      ),
      Reminder(
        title: 'Fertilize $plantName',
        message: 'Schedule a nutrient boost for $plantName in the next week.',
        severity: 'Medium',
        dueDate: now.add(fertilizing),
      ),
    ];
  }
}
