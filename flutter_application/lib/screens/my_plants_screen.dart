import 'package:flutter/material.dart';

import '../data/plant_library.dart';
import '../models/plant.dart';
import 'plant_detail_screen.dart';

class MyPlantsScreen extends StatelessWidget {
  const MyPlantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Plants Library'),
        backgroundColor: Colors.green[700],
      ),
      body: ValueListenableBuilder<List<Plant>>(
        valueListenable: PlantLibrary.myPlants,
        builder: (context, plants, _) {
          if (plants.isEmpty) {
            return const Center(child: Text('Add a plant to get started'));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: plants.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final plant = plants[index];
              return _PlantTile(plant: plant, onTap: () => _openDetail(context, plant));
            },
          );
        },
      ),
    );
  }

  void _openDetail(BuildContext context, Plant plant) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => PlantDetailScreen(plant: plant)),
    );
  }
}

class _PlantTile extends StatelessWidget {
  final Plant plant;
  final VoidCallback onTap;

  const _PlantTile({required this.plant, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 3,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              child: Image.network(
                plant.image,
                width: 110,
                height: 110,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(plant.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    Text(plant.wateringFrequency, style: const TextStyle(fontSize: 14)),
                    const SizedBox(height: 6),
                    Text('Sunlight: ${plant.sunlight}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Chip(label: Text('${plant.reminders.length} reminders')),
                        const SizedBox(width: 6),
                        const Chip(label: Text('Care guide')),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
