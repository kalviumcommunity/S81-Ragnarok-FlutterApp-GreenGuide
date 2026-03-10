import 'package:flutter/material.dart';

import '../models/plant.dart';
import '../models/product.dart';
import '../models/reminder.dart';

class PlantDetailScreen extends StatelessWidget {
  final Plant plant;

  const PlantDetailScreen({super.key, required this.plant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(plant.name),
        backgroundColor: Colors.green[700],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.network(
                plant.image,
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(plant.description, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            _buildSection('Watering', plant.wateringFrequency, const Icon(Icons.water_drop, color: Colors.green)),
            _buildSection('Sunlight', plant.sunlight, const Icon(Icons.wb_sunny, color: Colors.amber)),
            _buildSection('Fertilizer', plant.fertilizerNotes, const Icon(Icons.local_florist, color: Colors.teal)),
            _buildSection('Repotting', plant.repottingWindow, const Icon(Icons.restart_alt, color: Colors.orange)),
            if (plant.commonIssues.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text('Common problems & solutions', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              ...plant.commonIssues.map((issue) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        const Icon(Icons.bug_report, size: 18, color: Colors.green),
                        const SizedBox(width: 6),
                        Expanded(child: Text(issue)),
                      ],
                    ),
                  )),
            ],
            const SizedBox(height: 16),
            const Text('Reminders', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...plant.reminders.map((reminder) => _buildReminderTile(reminder)),
            const SizedBox(height: 16),
            const Text('Recommended products', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...plant.productRecommendations.map((product) => _buildProductTile(product)),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content, Widget icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          icon,
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(content, style: const TextStyle(fontSize: 14, color: Colors.black87)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReminderTile(Reminder reminder) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.green[100],
          child: const Icon(Icons.alarm, color: Colors.green),
        ),
        title: Text(reminder.title),
        subtitle: Text('${reminder.message}\nDue ${_formatDate(reminder.dueDate)}'),
        isThreeLine: true,
        trailing: Text(reminder.severity, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildProductTile(Product product) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: Image.network(product.imageUrl, width: 50, fit: BoxFit.cover),
        title: Text(product.name),
        subtitle: Text(product.description),
        trailing: Text('\$${product.price.toStringAsFixed(0)}'),
      ),
    );
  }

  String _formatDate(DateTime value) {
    return '${value.month}/${value.day}/${value.year}';
  }
}
