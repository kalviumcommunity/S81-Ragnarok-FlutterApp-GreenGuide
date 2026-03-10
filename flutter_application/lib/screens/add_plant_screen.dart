import 'package:flutter/material.dart';

import '../data/plant_library.dart';
import '../models/plant.dart';
import '../models/reminder.dart';

class AddPlantScreen extends StatefulWidget {
  const AddPlantScreen({super.key});

  @override
  State<AddPlantScreen> createState() => _AddPlantScreenState();
}

class _AddPlantScreenState extends State<AddPlantScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _sunlightController = TextEditingController();
  final _wateringController = TextEditingController();
  final _fertilizerController = TextEditingController();
  final _repottingController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _sunlightController.dispose();
    _wateringController.dispose();
    _fertilizerController.dispose();
    _repottingController.dispose();
    super.dispose();
  }

  void _savePlant() {
    if (!_formKey.currentState!.validate()) return;

    final newPlant = Plant(
      id: 'custom-${DateTime.now().millisecondsSinceEpoch}',
      name: _nameController.text.trim(),
      image: 'https://images.unsplash.com/photo-1501004318641-b39e6451bec6?auto=format&fit=crop&w=800&q=60',
      wateringFrequency: _wateringController.text.trim().isEmpty
          ? 'Water as needed' : _wateringController.text.trim(),
      sunlight: _sunlightController.text.trim().isEmpty
          ? 'Bright indirect light' : _sunlightController.text.trim(),
      fertilizerNotes: _fertilizerController.text.trim().isEmpty
          ? 'Use balanced fertilizer monthly' : _fertilizerController.text.trim(),
      repottingWindow: _repottingController.text.trim().isEmpty
          ? 'Repot once a year' : _repottingController.text.trim(),
      description: 'Custom plant added from GreenGuide.',
      commonIssues: const [],
      reminders: _buildReminders(_nameController.text.trim()),
      productRecommendations: const [],
    );

    PlantLibrary.addPlant(newPlant);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Plant added to your library')));
    Navigator.pop(context);
  }

  List<Reminder> _buildReminders(String name) {
    final now = DateTime.now();
    return [
      Reminder(
        title: 'Water $name',
        message: 'Check the soil today and water if slightly dry.',
        severity: 'Medium',
        dueDate: now.add(const Duration(days: 4)),
      ),
      Reminder(
        title: 'Fertilize $name',
        message: 'Send a gentle fertilizer boost next week.',
        severity: 'Low',
        dueDate: now.add(const Duration(days: 10)),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Plant Manually'),
        backgroundColor: Colors.green[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Plant Name'),
                validator: (value) => value == null || value.isEmpty ? 'Enter a plant name' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _wateringController,
                decoration: const InputDecoration(labelText: 'Watering Frequency'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _sunlightController,
                decoration: const InputDecoration(labelText: 'Sunlight Needs'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _fertilizerController,
                decoration: const InputDecoration(labelText: 'Fertilizer Tips'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _repottingController,
                decoration: const InputDecoration(labelText: 'Repotting Window'),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _savePlant,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green[700]),
                child: const Text('Add to My Plants'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
