import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _isWelcome = true;

  void _toggleMessage() {
    setState(() {
      _isWelcome = !_isWelcome;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color highlightColor = _isWelcome ? Colors.green : Colors.blueGrey;

    return Scaffold(
      appBar: AppBar(title: const Text('GreenGuide')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                _isWelcome
                    ? 'Welcome to GreenGuide'
                    : 'Let\'s build greener habits!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: highlightColor.withOpacity(0.15),
                ),
                padding: const EdgeInsets.all(24),
                child: Icon(Icons.eco, size: 72, color: highlightColor),
              ),
              const SizedBox(height: 24),
              Text(
                'Tap the button to toggle the mood of your journey.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _toggleMessage,
                  child: Text(_isWelcome ? 'I\'m Ready' : 'Reset Welcome'),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/responsive');
                  },
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('Explore Responsive Layout'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[700],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
