import 'package:flutter/material.dart';

import '../data/plant_library.dart';
import '../models/reminder.dart';

class RemindersScreen extends StatelessWidget {
  const RemindersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Reminders'),
        backgroundColor: Colors.green[700],
      ),
      body: ValueListenableBuilder(
        valueListenable: PlantLibrary.myPlants,
        builder: (context, plants, _) {
          final reminders = <Reminder>[];
          for (final plant in plants) {
            reminders.addAll(plant.reminders);
          }
          reminders.sort((a, b) => a.dueDate.compareTo(b.dueDate));
          if (reminders.isEmpty) {
            return const Center(child: Text('No reminders yet. Add a plant to receive alerts.'));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: reminders.length,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final reminder = reminders[index];
              return _ReminderCard(reminder: reminder);
            },
          );
        },
      ),
    );
  }
}

class _ReminderCard extends StatelessWidget {
  final Reminder reminder;

  const _ReminderCard({required this.reminder});

  @override
  Widget build(BuildContext context) {
    final dueIn = reminder.dueDate.difference(DateTime.now());
    final dueText = dueIn.isNegative ? 'Due now' : '${dueIn.inDays} days remaining';
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.green[100],
          child: const Icon(Icons.notifications_active, color: Colors.green),
        ),
        title: Text(reminder.title),
        subtitle: Text('${reminder.message}\n$dueText'),
        isThreeLine: true,
        trailing: Text(reminder.severity, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
