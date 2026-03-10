import 'screens/greenguide_demo_screen.dart';
import 'screens/asset_demo_screen.dart';
import 'screens/animated_box_demo.dart';
import 'screens/animated_opacity_demo.dart';
import 'screens/rotate_logo_demo.dart';
import 'screens/responsive_demo.dart';
import 'screens/details_screen.dart';
import 'screens/state_management_demo.dart';
import 'screens/user_input_form.dart';
import 'screens/scrollable_views.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/welcome_screen.dart';
import 'screens/responsive_home.dart';
import 'screens/login_screen.dart';
import 'screens/widget_tree_demo.dart';
import 'screens/stateless_stateful_demo.dart';
import 'screens/home_screen.dart';
import 'screens/second_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screens/auth_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final bool firebaseConfigured = await _initializeFirebase();
  runApp(MyApp(firebaseConfigured: firebaseConfigured));
}

Future<bool> _initializeFirebase() async {
  try {
    await Firebase.initializeApp();
    return true;
  } on FirebaseException catch (error) {
    debugPrint('Firebase init failed: ${error.message ?? error.code}');
  } catch (error) {
    debugPrint('Firebase init failed: $error');
  }
  return false;
}

class MyApp extends StatelessWidget {
  final bool firebaseConfigured;

  const MyApp({super.key, required this.firebaseConfigured});

  @override
  Widget build(BuildContext context) {
    if (!firebaseConfigured) {
      return const MaterialApp(home: FirebaseUnavailableScreen());
    }

    return MaterialApp(
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            return HomeScreen();
          }
          return AuthScreen();
        },
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => AuthScreen(),
        '/second': (context) => SecondScreen(),
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
        '/login': (context) => const LoginScreen(),
        '/widget-tree-demo': (context) => const WidgetTreeDemoScreen(),
        '/stateless-stateful-demo': (context) => const StatelessStatefulDemoScreen(),
      },
    );
  }
}

class FirebaseUnavailableScreen extends StatelessWidget {
  const FirebaseUnavailableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Firebase Unavailable')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            Icon(Icons.cloud_off, size: 72, color: Colors.redAccent),
            SizedBox(height: 24),
            Text(
              'Unable to initialize Firebase. Please configure Firebase for this project by running `flutterfire configure` or updating firebase_options.dart.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text('The app can still run offline; reconfigure Firebase to enable authentication and data services.'),
          ],
        ),
      ),
    );
  }
}

