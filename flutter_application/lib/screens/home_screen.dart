import 'package:flutter/material.dart';
import '../widgets/info_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GreenGuide – Smart Plant Care Companion'),
        backgroundColor: Colors.green[700],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Icon(Icons.eco, size: 60, color: Colors.green[700]),
                    SizedBox(height: 8),
                    Text(
                      'Welcome to GreenGuide!',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[900],
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Your smart plant care companion',
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Quick Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green[800])),
                      SizedBox(height: 16),
                      _featureButton(context, Icons.qr_code_scanner, 'Scan/Add Plant', () {}),
                      _featureButton(context, Icons.local_florist, 'My Plants', () {}),
                      _featureButton(context, Icons.menu_book, 'Digital Care Guide', () {}),
                      _featureButton(context, Icons.alarm, 'Smart Reminders', () {}),
                      _featureButton(context, Icons.store, 'Nursery Store', () {}),
                      _featureButton(context, Icons.shopping_bag, 'Product Recommendations', () {}),
                      _featureButton(context, Icons.record_voice_over, 'Voice Reminders', () {}),
                      _featureButton(context, Icons.wb_sunny, 'Weather-based Suggestions', () {}),
                      _featureButton(context, Icons.card_giftcard, 'Nursery Loyalty Points', () {}),
                      _featureButton(context, Icons.chat, 'Chat with Nursery Experts', () {}),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 32),
              Text('Demo Navigation', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green[800])),
              SizedBox(height: 8),
              ElevatedButton.icon(
                icon: Icon(Icons.arrow_forward),
                label: Text('Go to Second Screen'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[600],
                  minimumSize: Size(double.infinity, 48),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/second');
                },
              ),
              SizedBox(height: 24),
              InfoCard(title: 'Profile', subtitle: 'View details', icon: Icons.person),
              InfoCard(title: 'Settings', subtitle: 'Manage preferences', icon: Icons.settings),
              InfoCard(title: 'Logout', subtitle: 'Exit your account', icon: Icons.exit_to_app),
            ],
          ),
        ),
      ),
    );

  }

  Widget _featureButton(BuildContext context, IconData icon, String label, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: ElevatedButton.icon(
        icon: Icon(icon, color: Colors.green[800]),
        label: Text(label, style: TextStyle(color: Colors.green[900], fontWeight: FontWeight.w500)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green[50],
          minimumSize: Size(double.infinity, 44),
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          side: BorderSide(color: Colors.green[100]!),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
