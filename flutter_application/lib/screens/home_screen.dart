import 'package:flutter/material.dart';

import '../data/plant_library.dart';
import '../models/plant.dart';
import '../models/reminder.dart';
import 'add_plant_screen.dart';
import 'my_plants_screen.dart';
import 'nursery_store_screen.dart';
import 'plant_detail_screen.dart';
import 'plant_scan_screen.dart';
import 'reminders_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GreenGuide – Smart Plant Care Companion'),
        backgroundColor: Colors.green[700],
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 16, 18, 80),
        children: [
          _buildHero(context),
          const SizedBox(height: 18),
          _buildUpcomingReminder(context),
          const SizedBox(height: 22),
          _buildMyPlantsPreview(context),
          const SizedBox(height: 26),
          _buildQuickActions(context),
          const SizedBox(height: 24),
          _buildExperienceBooster(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const PlantScanScreen()));
        },
        icon: const Icon(Icons.qr_code_scanner),
        label: const Text('Scan plants'),
        backgroundColor: Colors.green[700],
      ),
    );
  }

  Widget _buildHero(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.eco, size: 42, color: Colors.green),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Keep your plants thriving', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text('GreenGuide keeps nursery knowledge, reminders, and product ideas in one spot.'),
            ],
          ),
        ),
        const CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(Icons.person, color: Colors.green),
        )
      ],
    );
  }

  Widget _buildUpcomingReminder(BuildContext context) {
    return ValueListenableBuilder<List<Plant>>(
      valueListenable: PlantLibrary.myPlants,
      builder: (context, plants, _) {
        final reminder = _soonestReminder(plants);
        if (reminder == null) {
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                children: const [
                  Icon(Icons.notifications_none, color: Colors.green),
                  SizedBox(width: 12),
                  Expanded(child: Text('Add a plant to receive smart reminders tailored to your nursery.')),
                ],
              ),
            ),
          );
        }

        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Reminder today', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Text(reminder.title, style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 4),
                Text(reminder.message, style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 6),
                Text('Due ${_formatDate(reminder.dueDate)}', style: const TextStyle(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        );
      },
    );
  }

  Reminder? _soonestReminder(List<Plant> plants) {
    final reminders = <Reminder>[];
    for (final plant in plants) {
      reminders.addAll(plant.reminders);
    }
    if (reminders.isEmpty) return null;
    reminders.sort((a, b) => a.dueDate.compareTo(b.dueDate));
    return reminders.first;
  }

  String _formatDate(DateTime value) => '${value.month}/${value.day}/${value.year}';

  Widget _buildMyPlantsPreview(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('My Plants', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        ValueListenableBuilder<List<Plant>>(
          valueListenable: PlantLibrary.myPlants,
          builder: (context, plants, _) {
            if (plants.isEmpty) {
              return const Text('No plants yet. Scan a tag or add one manually!');
            }
            return SizedBox(
              height: 170,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: plants.length,
                separatorBuilder: (context, index) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final plant = plants[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => PlantDetailScreen(plant: plant)),
                      );
                    },
                    child: _PlantCard(plant: plant),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Quick Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 2.9,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          children: [
            _ActionCard(icon: Icons.qr_code, label: 'Scan / Add Plant', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PlantScanScreen()))),
            _ActionCard(icon: Icons.list_alt, label: 'My Plant Library', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MyPlantsScreen()))),
            _ActionCard(icon: Icons.menu_book, label: 'Digital Care Guide', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MyPlantsScreen()))),
            _ActionCard(icon: Icons.alarm, label: 'Smart Reminders', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RemindersScreen()))),
            _ActionCard(icon: Icons.storefront, label: 'Nursery Store', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NurseryStoreScreen()))),
            _ActionCard(icon: Icons.add_circle_outline, label: 'Add Plant Manually', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddPlantScreen()))),
          ],
        ),
      ],
    );
  }

  Widget _buildExperienceBooster() {
    final tips = [
      'Voice reminders in your local language',
      'Weather-based watering nudges',
      'Loyalty points for nursery purchases',
      'Chat with nursery experts for quick help',
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Unique experiences', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        ...tips.map(
          (tip) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                const Icon(Icons.check_circle, size: 20, color: Colors.green),
                const SizedBox(width: 8),
                Expanded(child: Text(tip)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _PlantCard extends StatelessWidget {
  final Plant plant;

  const _PlantCard({required this.plant});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(color: Color(0x33000000), blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(18), topRight: Radius.circular(18)),
            child: Image.network(
              plant.image,
              height: 102,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(plant.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Text(plant.wateringFrequency, maxLines: 2, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionCard({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Ink(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.green[50],
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.green[100]!),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.green[700]),
            const SizedBox(width: 8),
            Expanded(child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600))),
          ],
        ),
      ),
    );
  }
}
