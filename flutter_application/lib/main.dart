import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/responsive_home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GreenGuide',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const WelcomeScreen(),
      routes: {
        '/responsive': (context) => const ResponsiveHome(),
      },
    );
  }
}
