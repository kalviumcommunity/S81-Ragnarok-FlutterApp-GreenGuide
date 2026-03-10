import 'package:flutter/material.dart';

import 'screens/animated_box_demo.dart';
import 'screens/animated_opacity_demo.dart';
import 'screens/asset_demo_screen.dart';
import 'screens/details_screen.dart';
import 'screens/greenguide_demo_screen.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/rotate_logo_demo.dart';
import 'screens/responsive_demo.dart';
import 'screens/responsive_home.dart';
import 'screens/scrollable_views.dart';
import 'screens/stateless_stateful_demo.dart';
import 'screens/state_management_demo.dart';
import 'screens/user_input_form.dart';
import 'screens/widget_tree_demo.dart';
import 'screens/welcome_screen.dart';
import 'screens/second_screen.dart';
import 'screens/dashboard_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GreenGuide',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/second': (context) => const SecondScreen(),
        '/greenguide-demo': (context) => GreenGuideDemoScreen(),
        '/responsive': (context) => const ResponsiveHome(),
        '/scrollable-views': (context) => ScrollableViews(),
        '/user-input-form': (context) => UserInputForm(),
        '/state-management-demo': (context) => StateManagementDemo(),
        '/details': (context) => DetailsScreen(),
        '/responsive-demo': (context) => ResponsiveDemo(),
        '/asset-demo': (context) => AssetDemoScreen(),
        '/animated-box-demo': (context) => AnimatedBoxDemo(),
        '/animated-opacity-demo': (context) => AnimatedOpacityDemo(),
        '/rotate-logo-demo': (context) => RotateLogoDemo(),
        '/welcome': (context) => const WelcomeScreen(),
        '/widget-tree-demo': (context) => const WidgetTreeDemoScreen(),
        '/stateless-stateful-demo': (context) => const StatelessStatefulDemoScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
