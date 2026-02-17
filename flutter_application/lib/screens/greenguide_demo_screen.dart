import 'package:flutter/material.dart';

class GreenGuideDemoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('GreenGuide – Smart Plant Care Companion')),
      body: ListView(
        padding: EdgeInsets.all(24),
        children: [
          ElevatedButton(
            onPressed: () {},
            child: Text('Scan/Add Plant'),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('My Plants'),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('Digital Care Guide'),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('Smart Reminders'),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('Nursery Store'),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('Product Recommendations'),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('Voice Reminders'),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('Weather-based Suggestions'),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('Nursery Loyalty Points'),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('Chat with Nursery Experts'),
          ),
        ],
      ),
    );
  }
}
