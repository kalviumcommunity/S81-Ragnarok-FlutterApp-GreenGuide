import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'services/auth_service.dart';
import 'services/firestore_service.dart';
import 'services/storage_service.dart';

/*
==============================================================================
  GreenGuide – Smart Plant Care Companion
  Firebase-Integrated Edition
  
  Complete Flutter app with:
  - Firebase Authentication (email/password signup & login)
  - Cloud Firestore for real-time plant data sync
  - Firebase Storage for plant images
  - StreamBuilder for reactive UI updates
  - Material 3 design with green theme
  
  Architecture:
  - lib/services/ - Business logic (auth, firestore, storage)
  - screens in main.dart - UI layer
  - Firebase handles all backend operations
  
  Real-time Magic:
  - Plants added on phone appear instantly on tablet
  - No polling needed - Firestore streams push updates
  - Images stored globally on Firebase CDN
  
  The "Mobile Efficiency Triangle": Real-time sync + Secure auth + Scalable storage
  Firebase solves all three problems without custom backend servers.
==============================================================================
*/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const GreenGuideApp());
}

// ============================================================================
// MAIN APP
// ============================================================================

class GreenGuideApp extends StatelessWidget {
  const GreenGuideApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GreenGuide',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.light,
        ),
      ),
      home: const AuthWrapper(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// ============================================================================
// AUTH WRAPPER - Routes based on Firebase Auth state
// ============================================================================

/// Wrapper that decides which screen to show based on authentication state.
/// 
/// This uses StreamBuilder to listen to Firebase Auth state changes.
/// When user logs in/out, the UI automatically updates.
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: AuthService().authStateChanges,
      builder: (context, snapshot) {
        // Loading state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // User is logged in
        if (snapshot.hasData) {
          return const HomeScreen();
        }

        // User is not logged in
        return const AuthScreen();
      },
    );
  }
}

// ============================================================================
// SCREEN 1: AUTH SCREEN (Login/Signup tabs)
// ============================================================================

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.green.shade600,
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.eco,
                    size: 60,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'GreenGuide',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    'Smart Plant Care Companion',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            // Tabs
            TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: 'Login'),
                Tab(text: 'Sign Up'),
              ],
            ),
            // Tab content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  LoginTab(),
                  SignupTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// LOGIN TAB
// ============================================================================

class LoginTab extends StatefulWidget {
  @override
  State<LoginTab> createState() => _LoginTabState();
}

class _LoginTabState extends State<LoginTab> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService authService = AuthService();
  bool isLoading = false;
  String? errorMessage;

  void _handleLogin() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      await authService.login(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
      // Navigation handled by AuthWrapper stream
    } catch (e) {
      if (mounted) {
        setState(() {
          errorMessage = e.toString();
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 30),
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              prefixIcon: const Icon(Icons.email),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            keyboardType: TextInputType.emailAddress,
            enabled: !isLoading,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: const Icon(Icons.lock),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            obscureText: true,
            enabled: !isLoading,
          ),
          if (errorMessage != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                border: Border.all(color: Colors.red),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                errorMessage!,
                style: TextStyle(color: Colors.red.shade700),
              ),
            ),
          ],
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: isLoading ? null : _handleLogin,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade600,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Text(
                      'Login',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

// ============================================================================
// SIGNUP TAB
// ============================================================================

class SignupTab extends StatefulWidget {
  @override
  State<SignupTab> createState() => _SignupTabState();
}

class _SignupTabState extends State<SignupTab> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final AuthService authService = AuthService();
  final FirestoreService firestoreService = FirestoreService();
  bool isLoading = false;
  String? errorMessage;

  void _handleSignup() async {
    // Validate
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      setState(() => errorMessage = 'Email and password required');
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      setState(() => errorMessage = 'Passwords do not match');
      return;
    }

    if (passwordController.text.length < 6) {
      setState(() => errorMessage = 'Password must be at least 6 characters');
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final credential = await authService.signUp(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      // Create user document in Firestore
      if (credential.user != null) {
        await firestoreService.createUserDocument(
          credential.user!.uid,
          credential.user!.email ?? '',
        );
      }

      // Navigation handled by AuthWrapper stream
    } catch (e) {
      if (mounted) {
        setState(() {
          errorMessage = e.toString();
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 20),
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              prefixIcon: const Icon(Icons.email),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            keyboardType: TextInputType.emailAddress,
            enabled: !isLoading,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: const Icon(Icons.lock),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            obscureText: true,
            enabled: !isLoading,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: confirmPasswordController,
            decoration: InputDecoration(
              labelText: 'Confirm Password',
              prefixIcon: const Icon(Icons.lock),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            obscureText: true,
            enabled: !isLoading,
          ),
          if (errorMessage != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                border: Border.all(color: Colors.red),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                errorMessage!,
                style: TextStyle(color: Colors.red.shade700),
              ),
            ),
          ],
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: isLoading ? null : _handleSignup,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade600,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Password must be at least 6 characters',
            style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}

// ============================================================================
// SCREEN 2: HOME SCREEN (Real-time plant list with StreamBuilder)
// ============================================================================

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirestoreService firestoreService = FirestoreService();
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = authService.currentUser;
    if (user == null) {
      return const Scaffold(body: Center(child: Text('Not logged in')));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Plants'),
        backgroundColor: Colors.green.shade600,
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () async {
                  await authService.logout();
                },
                child: const Text('Logout'),
              ),
            ],
          ),
        ],
      ),
      body: StreamBuilder<List<Plant>>(
        stream: firestoreService.getPlantsStream(user.uid),
        builder: (context, snapshot) {
          // Loading state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Error state
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          // Empty state
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.local_florist_outlined,
                      size: 80, color: Colors.grey.shade400),
                  const SizedBox(height: 16),
                  Text(
                    'No plants yet',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 18),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddPlantScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Add Your First Plant'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade600,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            );
          }

          // Plants list
          final plants = snapshot.data!;
          return ListView.builder(
            itemCount: plants.length,
            itemBuilder: (context, index) {
              final plant = plants[index];
              return PlantListItem(
                plant: plant,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PlantDetailScreen(plant: plant, uid: user.uid),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPlantScreen()),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Plant'),
        backgroundColor: Colors.green.shade600,
      ),
    );
  }
}

// ============================================================================
// PLANT LIST ITEM WIDGET
// ============================================================================

class PlantListItem extends StatelessWidget {
  final Plant plant;
  final VoidCallback onTap;

  const PlantListItem({
    required this.plant,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.green.shade100,
          ),
          child: plant.imageUrl.isNotEmpty
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    plant.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.local_florist,
                          color: Colors.green.shade600);
                    },
                  ),
                )
              : Icon(Icons.local_florist, color: Colors.green.shade600),
        ),
        title: Text(
          plant.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Watered ${plant.wateringCount} times',
          style: TextStyle(color: Colors.grey.shade600),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}

// ============================================================================
// SCREEN 3: ADD PLANT SCREEN
// ============================================================================

class AddPlantScreen extends StatefulWidget {
  const AddPlantScreen({super.key});

  @override
  State<AddPlantScreen> createState() => _AddPlantScreenState();
}

class _AddPlantScreenState extends State<AddPlantScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController wateringController = TextEditingController();
  final TextEditingController sunlightController = TextEditingController();
  final TextEditingController fertilizerController = TextEditingController();
  final TextEditingController repottingController = TextEditingController();
  final TextEditingController problemsController = TextEditingController();

  final FirestoreService firestoreService = FirestoreService();
  final StorageService storageService = StorageService();
  final ImagePicker imagePicker = ImagePicker();
  final AuthService authService = AuthService();

  File? selectedImage;
  bool isLoading = false;

  void _pickImage() async {
    final pickedFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }

  void _handleAddPlant() async {
    final user = authService.currentUser;
    if (user == null) return;

    if (nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Plant name required')),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      // Create plant object
      var plant = Plant(
        id: '', // Firestore will generate ID
        name: nameController.text,
        watering: wateringController.text.isEmpty
            ? 'As needed'
            : wateringController.text,
        sunlight: sunlightController.text.isEmpty
            ? 'Bright indirect'
            : sunlightController.text,
        fertilizer: fertilizerController.text.isEmpty
            ? 'Monthly'
            : fertilizerController.text,
        repotting: repottingController.text.isEmpty
            ? 'Every 12-18 months'
            : repottingController.text,
        problems: problemsController.text.isEmpty
            ? 'None'
            : problemsController.text,
      );

      // Add plant to Firestore
      final plantId = await firestoreService.addPlant(user.uid, plant);

      // Upload image if selected
      if (selectedImage != null) {
        final imageUrl = await storageService.uploadPlantImage(
          uid: user.uid,
          plantId: plantId,
          imageFile: selectedImage!,
        );

        // Update plant with image URL
        await firestoreService.updatePlant(user.uid, plantId, {
          'imageUrl': imageUrl,
        });
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Plant added successfully!')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Plant'),
        backgroundColor: Colors.green.shade600,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Image section
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: selectedImage != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(selectedImage!, fit: BoxFit.cover),
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.image_outlined,
                              size: 48, color: Colors.grey.shade400),
                          const SizedBox(height: 8),
                          Text('No image selected',
                              style: TextStyle(color: Colors.grey.shade600)),
                        ],
                      ),
                    ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.photo_camera),
              label: const Text('Pick Image'),
            ),
            const SizedBox(height: 24),
            // Form fields
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Plant Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              enabled: !isLoading,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: wateringController,
              decoration: InputDecoration(
                labelText: 'Watering Schedule',
                hintText: 'e.g., Every 3 days',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              enabled: !isLoading,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: sunlightController,
              decoration: InputDecoration(
                labelText: 'Sunlight Requirements',
                hintText: 'e.g., Bright indirect',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              enabled: !isLoading,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: fertilizerController,
              decoration: InputDecoration(
                labelText: 'Fertilizer',
                hintText: 'e.g., Monthly',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              enabled: !isLoading,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: repottingController,
              decoration: InputDecoration(
                labelText: 'Repotting Schedule',
                hintText: 'e.g., Every 12-18 months',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              enabled: !isLoading,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: problemsController,
              decoration: InputDecoration(
                labelText: 'Common Problems',
                hintText: 'e.g., None',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              enabled: !isLoading,
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading ? null : _handleAddPlant,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade600,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text(
                        'Add Plant',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    wateringController.dispose();
    sunlightController.dispose();
    fertilizerController.dispose();
    repottingController.dispose();
    problemsController.dispose();
    super.dispose();
  }
}

// ============================================================================
// SCREEN 4: PLANT DETAIL SCREEN
// ============================================================================

class PlantDetailScreen extends StatefulWidget {
  final Plant plant;
  final String uid;

  const PlantDetailScreen({
    required this.plant,
    required this.uid,
    super.key,
  });

  @override
  State<PlantDetailScreen> createState() => _PlantDetailScreenState();
}

class _PlantDetailScreenState extends State<PlantDetailScreen> {
  final FirestoreService firestoreService = FirestoreService();
  final StorageService storageService = StorageService();
  final ImagePicker imagePicker = ImagePicker();
  late Plant currentPlant;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    currentPlant = widget.plant;
  }

  void _waterPlant() async {
    setState(() => isLoading = true);

    try {
      await firestoreService.incrementWateringCount(widget.uid, widget.plant.id);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  void _updatePlantImage() async {
    final pickedFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      setState(() => isLoading = true);

      try {
        final imageUrl = await storageService.uploadPlantImage(
          uid: widget.uid,
          plantId: widget.plant.id,
          imageFile: File(pickedFile.path),
        );

        await firestoreService.updatePlant(
          widget.uid,
          widget.plant.id,
          {'imageUrl': imageUrl},
        );

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Image updated!')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $e')),
          );
        }
      } finally {
        if (mounted) {
          setState(() => isLoading = false);
        }
      }
    }
  }

  void _deletePlant() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Plant?'),
        content: const Text('This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              setState(() => isLoading = true);

              try {
                // Delete image from Storage
                if (widget.plant.imageUrl.isNotEmpty) {
                  await storageService.deleteImage(
                    uid: widget.uid,
                    plantId: widget.plant.id,
                  );
                }

                // Delete plant from Firestore
                await firestoreService.deletePlant(
                  widget.uid,
                  widget.plant.id,
                );

                if (mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Plant deleted!')),
                  );
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: $e')),
                  );
                  setState(() => isLoading = false);
                }
              }
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Plant?>(
      stream: Stream.value(currentPlant), // Start with current plant
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: const Text('Plant Details')),
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        }

        final plant = snapshot.data ?? currentPlant;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Plant Details'),
            backgroundColor: Colors.green.shade600,
            foregroundColor: Colors.white,
            actions: [
              IconButton(
                onPressed: isLoading ? null : _deletePlant,
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Image
                GestureDetector(
                  onTap: isLoading ? null : _updatePlantImage,
                  child: Container(
                    height: 250,
                    color: Colors.grey.shade200,
                    child: plant.imageUrl.isNotEmpty
                        ? Image.network(
                            plant.imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(Icons.local_florist,
                                  size: 80, color: Colors.grey.shade400);
                            },
                          )
                        : Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add_photo_alternate_outlined,
                                    size: 64, color: Colors.grey.shade400),
                                const SizedBox(height: 8),
                                Text('Tap to add image',
                                    style: TextStyle(
                                        color: Colors.grey.shade600)),
                              ],
                            ),
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        plant.name,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Watered ${plant.wateringCount} times',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                      if (plant.lastWatered != null)
                        Text(
                          'Last watered: ${plant.lastWatered!.toString().split('.')[0]}',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                      const SizedBox(height: 24),
                      // Care instructions
                      _buildCareSection('Watering', plant.watering),
                      _buildCareSection('Sunlight', plant.sunlight),
                      _buildCareSection('Fertilizer', plant.fertilizer),
                      _buildCareSection('Repotting', plant.repotting),
                      _buildCareSection('Problems', plant.problems),
                      const SizedBox(height: 24),
                      // Water button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: isLoading ? null : _waterPlant,
                          icon: const Icon(Icons.opacity),
                          label: const Text('Mark as Watered'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade600,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCareSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          content,
          style: TextStyle(color: Colors.grey.shade700),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
