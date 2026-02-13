## GreenGuide – Sustainable Habits Companion

GreenGuide is a cross-platform Flutter app concept that helps users build simple, sustainable daily habits (like saving water, reducing waste, and tracking eco-friendly actions). This sprint focuses on setting up the Flutter environment, understanding project structure, and building core app features.

---

## Project Structure Overview

📚 **For detailed documentation, see [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md)**

This Flutter project follows a standardized, scalable folder structure:

### Visual Hierarchy

```
flutter_application/
├── lib/                   # 📦 Main application code
│   ├── main.dart          # App entry point
│   ├── firebase_options.dart
│   ├── screens/           # UI screens/pages
│   │   ├── welcome_screen.dart
│   │   ├── login_screen.dart
│   │   ├── signup_screen.dart
│   │   ├── dashboard_screen.dart
│   │   ├── responsive_home.dart
│   │   └── widget_tree_demo.dart          # Widget Tree & Reactive UI demo
│   └── services/          # Business logic & APIs
│       ├── auth_service.dart
│       └── firestore_service.dart
├── android/               # Android platform config
├── ios/                   # iOS platform config
├── web/                   # Web platform files
├── windows/               # Windows desktop files
├── test/                  # Automated tests
├── pubspec.yaml           # Dependencies & config
└── README.md              # This file
```

### Key Folders Explained

| Folder | Purpose |
|--------|---------|
| `lib/` | All Dart source code for the app |
| `lib/screens/` | Full-page UI components (screens) |
| `lib/services/` | Business logic, API calls, Firebase services |
| `lib/widgets/` | Reusable UI components (planned) |
| `lib/models/` | Data classes and models (planned) |
| `android/` | Android-specific build configuration |
| `ios/` | iOS-specific build configuration |
| `test/` | Unit, widget, and integration tests |

### Key Files

| File | Purpose |
|------|---------|
| `main.dart` | App entry point, routing, theme setup |
| `pubspec.yaml` | Dependencies, assets, project metadata |
| `analysis_options.yaml` | Dart linting and style rules |
| `.gitignore` | Files excluded from version control |

### Naming Conventions

- **Files:** `snake_case.dart` (e.g., `welcome_screen.dart`)
- **Classes:** `PascalCase` (e.g., `WelcomeScreen`)
- **Variables/Functions:** `camelCase` (e.g., `toggleMessage()`)

### Why Understanding Structure Matters

1. **Faster Development:** Know exactly where to add new features
2. **Team Collaboration:** Everyone follows the same organization
3. **Easier Debugging:** Logical grouping helps isolate issues
4. **Scalability:** Clean structure grows without becoming chaotic
5. **Cross-Platform:** Understand how Flutter builds for multiple targets

### How Structure Helps Team Collaboration

- **Parallel Work:** Team members can work on different folders simultaneously
- **Code Reviews:** Clear organization makes PRs easier to understand
- **Onboarding:** New developers can navigate the project quickly
- **Consistency:** Standard conventions across all Flutter projects

---

## Setup & Running the Project

### 1. Install Flutter SDK

Follow the official docs: https://docs.flutter.dev/get-started/install

Ensure Flutter is on your PATH and run:

```bash
flutter doctor
```

Fix any reported issues (Android SDK, emulators, etc.).

### 2. Open the project

1. Open this folder in VS Code or Android Studio.
2. Make sure you have the Flutter and Dart extensions/plugins installed.

### 3. Fetch dependencies & run

From the project root (where `pubspec.yaml` lives), run:

```bash
flutter pub get
flutter run
```

Select an emulator or physical device. The app should launch showing the GreenGuide Welcome screen with an icon and a button that toggles the welcome message.

---

---

## Sprint #2: Understanding the Widget Tree & Reactive UI Model

### 3.13 - Widget Tree & Reactive UI Concepts

This section demonstrates Flutter's core architectural concepts: the **widget tree** and the **reactive UI model**.

#### What is a Widget Tree?

In Flutter, everything is a widget. A **widget tree** is a hierarchical representation of all UI elements in your app, similar to a family tree where each parent widget can have multiple child widgets.

**Key Points:**
- Every visible element (Text, Button, Container, etc.) is a widget
- Widgets are arranged in a tree structure starting from a root widget (MaterialApp)
- Each widget is immutable and describes a part of the UI
- The tree structure mirrors how elements are nested in the code

**Example Widget Tree Structure:**

```
MaterialApp
 ├─ Scaffold
 │   ├─ AppBar
 │   │   ├─ Text ("title")
 │   │   └─ Icon
 │   └─ Body (Center)
 │       └─ Column
 │           ├─ Container
 │           │   └─ Icon
 │           ├─ Text ("Count: 5")
 │           ├─ Row
 │           │   ├─ ElevatedButton ("Decrease")
 │           │   └─ ElevatedButton ("Increase")
 │           └─ Card
 │               ├─ Text ("About Widget Trees")
 │               └─ Text (description)
```

#### How the Widget Tree Works

1. **Build Process:** Flutter traverses the widget tree and calls the `build()` method on each widget
2. **Rendering:** Each widget returns its visual representation
3. **Composition:** Widgets combine to create the complete UI
4. **Reusability:** Widgets can be reused throughout the app

#### Understanding Flutter's Reactive UI Model

Flutter follows a **reactive programming model**, meaning the UI automatically updates when the app's state changes. Instead of manually updating views, you simply change the state, and Flutter handles the re-rendering.

**Key Concepts:**

##### Stateless vs Stateful Widgets

- **StatelessWidget:** Immutable, no internal state. Used for static UI elements.
- **StatefulWidget:** Can maintain state. Used when UI needs to change based on user interaction or data changes.

##### How setState() Works

When you call `setState()`, Flutter:
1. Marks the widget as needing a rebuild
2. Calls the `build()` method again
3. Re-renders only the affected widgets (efficient!)
4. Updates the UI on screen

**Example Pattern:**

```dart
class CounterApp extends StatefulWidget {
  @override
  State<CounterApp> createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  int count = 0;

  void increment() {
    setState(() {
      count++;  // Update state
    });
    // Flutter automatically rebuilds the widget!
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('Count: $count'),
            ElevatedButton(
              onPressed: increment,
              child: Text('Increment'),
            ),
          ],
        ),
      ),
    );
  }
}
```

#### Why Flutter's Reactive Model is Efficient

Unlike traditional imperative frameworks where you manually update UI elements, Flutter:

- ✅ **Only rebuilds affected widgets** - Not the entire screen
- ✅ **Compares widget trees** - Uses diffing to find changes
- ✅ **Manages rendering efficiently** - Leverages GPU acceleration
- ✅ **Maintains performance** - Even complex UIs remain smooth

**Visual Comparison:**

| Imperative (Traditional) | Reactive (Flutter) |
|---|---|
| Manually update: `textView.setText("Count: 5")` | Change state: `count = 5` → UI updates automatically |
| Easy to introduce bugs | Predictable and safer |
| Need to track all state manually | Framework handles state changes |

#### GreenGuide Widget Tree Demo

We created a dedicated demo screen (`widget_tree_demo.dart`) inside `lib/screens/` that demonstrates these concepts interactively.

**To view the demo:**

```bash
# Run the app and navigate to /widget-tree-demo
# Or modify main.dart to use WidgetTreeDemoScreen as the home screen
```

**Demo Features:**

1. **Counter Example** - Shows state changes with increment/decrement buttons
2. **Expandable Card** - Demonstrates conditional rendering (expand/collapse)
3. **Theme Toggle** - Changes colors to show reactive updates across the tree
4. **Reset Button** - Resets all state to initial values
5. **Clear Widget Hierarchy** - Code uses helper methods to show organizational structure

#### Widget Tree Structure for GreenGuide Demo

```
Scaffold (WidgetTreeDemoScreen)
 ├─ AppBar
 │   └─ Text ("Widget Tree & Reactive UI Demo")
 ├─ Body
 │   └─ Container
 │       └─ SingleChildScrollView
 │           └─ Column
 │               ├─ _buildHeaderSection()
 │               │   └─ Column
 │               │       ├─ Text ("Widget Tree Hierarchy")
 │               │       └─ Text (description)
 │               ├─ _buildCounterCard()
 │               │   └─ Card
 │               │       └─ Padding
 │               │           └─ Column
 │               │               ├─ Text ("Counter Example")
 │               │               ├─ Container (count display)
 │               │               │   └─ Text ("Count: $_counterValue")
 │               │               └─ Row
 │               │                   ├─ ElevatedButton ("Decrease")
 │               │                   └─ ElevatedButton ("Increase")
 │               ├─ _buildInfoCard()
 │               │   └─ Card
 │               │       └─ Column
 │               │           ├─ GestureDetector
 │               │           │   └─ Row
 │               │           │       ├─ Text ("About Widget Trees")
 │               │           │       └─ Icon (expand/collapse)
 │               │           └─ [Conditional] Container + Text (info)
 │               └─ _buildActionButtons()
 │                   └─ Column
 │                       ├─ Row
 │                       │   └─ ElevatedButton ("Toggle Theme")
 │                       └─ OutlinedButton ("Reset All")
```

#### Key Takeaways

1. **Everything is a Widget** - Text, buttons, layouts—all widgets in a tree
2. **Reactive Updates** - Change state → UI updates automatically
3. **Efficient Rendering** - Flutter rebuilds only what changed
4. **Hierarchical Structure** - Widgets nest and compose to build complex UIs
5. **Predictable Behavior** - Same state = same UI output (deterministic)

---

## Setup Verification

This section documents the Flutter environment setup and first app run for Sprint #2.

### Flutter Doctor Output

The following screenshot shows the output of `flutter doctor -v` command, verifying that the Flutter SDK is properly installed and configured:

![Flutter Doctor Output](screenshots/flutter_doctor.png)

**Command output summary:**
```
[√] Flutter (Channel stable, 3.38.9, on Microsoft Windows)
    • Flutter version 3.38.9 on channel stable
    • Framework revision 67323de285
    • Dart version 3.10.8
    • DevTools version 2.51.1

[√] Windows Version (11 Home Single Language 64-bit, 25H2)

[√] Chrome - develop for the web
    • Chrome at C:\Program Files\Google\Chrome\Application\chrome.exe

[√] Connected device (3 available)
    • Windows (desktop)
    • Chrome (web)
    • Edge (web)

[√] Network resources - All expected network resources are available
```

### Running App on Device/Emulator

The following screenshot shows the GreenGuide Flutter app running successfully:

![App Running on Device](screenshots/app_running.png)

**Steps to run:**
```bash
cd flutter_application
flutter pub get
flutter run -d chrome
```

### Installation Steps Followed

1. **Downloaded Flutter SDK** from [flutter.dev](https://docs.flutter.dev/get-started/install/windows)
2. **Extracted to** `C:\Users\Mohammed Shammas\Flutter SDK\flutter`
3. **Added to PATH** via Environment Variables → System PATH → `flutter\bin`
4. **Verified installation** with `flutter doctor`
5. **Installed VS Code extensions:** Flutter and Dart from Marketplace
6. **Created project** with `flutter create flutter_application`
7. **Ran app** with `flutter run -d chrome`

### Reflection

**Challenges faced during installation:**
- Initial PATH configuration required restarting the terminal for changes to take effect
- Ensuring all necessary components were detected by `flutter doctor`
- Configuring the correct device target (Chrome for web development)

**How this setup prepares for building real mobile apps:**
- The Flutter SDK provides a complete toolkit for cross-platform development (iOS, Android, Web, Desktop)
- Hot reload enables rapid UI iteration without full app restarts
- `flutter doctor` ensures a healthy environment for consistent builds
- VS Code integration with Flutter/Dart extensions provides excellent developer experience with auto-complete, debugging, and widget previews

---

## Welcome Screen UI (Sprint #2)

The default counter app has been replaced with a custom stateful Welcome screen:

- Uses `Scaffold` with an `AppBar` titled **GreenGuide**.
- The `body` contains a `Column` with:
  - A title text that changes when the button is pressed.
  - An eco-themed `Icon` to represent sustainability.
  - A full-width `ElevatedButton` that toggles the message using `setState`.

This demonstrates understanding of widgets, layout, and basic state management in Flutter.

---

## Responsive Layout Screen (Sprint #2 – Responsive Design)

### Overview

A new `responsive_home.dart` screen demonstrates adaptive UI design that scales beautifully across all device types and orientations. The screen uses **MediaQuery**, **LayoutBuilder**, and flexible widgets to detect screen dimensions and adjust layouts dynamically.

### Key Features

✅ **Responsive Header** – AppBar sizing adapts based on device type  
✅ **Dynamic Content Grid** – Stats section switches between 2-column (phones) and 3-column (tablets) layouts  
✅ **Adaptive Typography** – Font sizes scale based on `MediaQuery.of(context).size.width`  
✅ **Orientation Awareness** – Portrait mode shows horizontal scrolling tips; landscape displays grid layout  
✅ **Flexible Widgets** – Uses `Expanded`, `Flexible`, `FittedBox`, and `AspectRatio` for natural scaling  
✅ **Touch-friendly Navigation** – Footer buttons and interactive tip cards with visual feedback  

### How to Access

1. Run the app
2. From the Welcome screen, tap **"Explore Responsive Layout"** button
3. Or navigate directly: `Navigator.pushNamed(context, '/responsive')`

### Code Snippets

#### 1. MediaQuery for Device Detection

```dart
// Detect screen dimensions and device type
double screenWidth = MediaQuery.of(context).size.width;
double screenHeight = MediaQuery.of(context).size.height;
bool isTablet = screenWidth > 600;

// Detect orientation
bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

// Adjust padding dynamically
final horizontalPadding = isTablet ? 32.0 : 16.0;
final verticalPadding = isTablet ? 24.0 : 16.0;
```

#### 2. LayoutBuilder for Responsive Layouts

```dart
LayoutBuilder(
  builder: (context, constraints) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: constraints.maxHeight),
        child: IntrinsicHeight(
          child: Column(
            children: [
              // Main content adapts to available space
              Expanded(
                child: _buildMainContent(context, constraints),
              ),
              // Footer stays at bottom
              _buildFooter(context),
            ],
          ),
        ),
      ),
    );
  },
)
```

#### 3. Conditional Layout (Phone vs Tablet)

```dart
// Portrait: Single column with horizontal scrolling tips
if (isLandscape)
  _buildTipsLandscape(context, isTablet, screenWidth)
else
  _buildTipsPortrait(context, isTablet, screenWidth),

// Stats grid adapts column count
GridView.count(
  crossAxisCount: isTablet ? 3 : 2,  // 3 cols on tablet, 2 on phone
  childAspectRatio: isTablet ? 1.2 : 1.0,  // Adjust card proportions
  children: [...],
)
```

#### 4. Flexible & Adaptive Widgets

```dart
// FittedBox scales text without overflow
FittedBox(
  fit: BoxFit.scaleDown,
  child: Text(
    value,
    style: TextStyle(fontSize: isTablet ? 20 : 16),
  ),
)

// Flexible buttons share space equally
Row(
  children: [
    Expanded(
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.favorite_border),
        label: const Text('Favorite'),
      ),
    ),
    SizedBox(width: isTablet ? 12 : 8),
    Expanded(
      child: OutlinedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.share),
        label: const Text('Share'),
      ),
    ),
  ],
)
```

### Testing Across Devices

#### Test on Phone Emulator (Portrait)

```bash
# Run on default emulator
flutter run

# Or specify a device
flutter run -d "Pixel 6"
```

**Expected behavior:**
- Single-column layout for tips
- 2-column grid for stats
- Compact spacing and smaller font sizes
- Horizontal scrolling for tip cards

#### Test on Tablet Emulator (Portrait)

```bash
# Launch a tablet emulator (iPad, Pixel Tablet)
flutter run -d "iPad"
# or
flutter run -d "Pixel Tablet"
```

**Expected behavior:**
- Larger header and typography
- 3-column grid for stats
- More generous padding and spacing
- Horizontal scrolling with larger cards

#### Test Landscape Orientation

1. Run the app on any emulator
2. Rotate the device (press `Ctrl+Right Arrow` on Android Studio, or rotate in simulator)

**Expected behavior:**
- Tips switch from horizontal scroll to full grid layout
- Layout remains stable without overflow
- Footer buttons remain accessible
- Text scales appropriately

#### Screenshots Checklist

- [ ] Phone – Portrait mode
- [ ] Phone – Landscape mode
- [ ] Tablet – Portrait mode
- [ ] Tablet – Landscape mode
- [ ] All states: No text overflow, proper alignment, touch targets > 48x48 dp

### Responsive Design Challenges & Solutions

#### Challenge 1: Maintaining Visual Hierarchy Across Sizes

**Problem:** Large fonts on tablets can make content feel cluttered; small fonts on phones become unreadable.

**Solution:** Used dynamic font sizing with MediaQuery breakpoints:
```dart
fontSize: isTablet ? 32 : 24  // AppBar title
fontSize: isTablet ? 22 : 18  // Section headers
fontSize: isTablet ? 16 : 14  // Body text
```

#### Challenge 2: Avoiding Overflow & Clipping

**Problem:** Fixed-size widgets can overflow on small screens.

**Solution:** Employed `Flexible`, `Expanded`, and `FittedBox`:
```dart
FittedBox(fit: BoxFit.scaleDown, child: Text(...))  // Scales down to fit
Flexible(child: Text(..., maxLines: 2, overflow: TextOverflow.ellipsis))  // Wraps text
```

#### Challenge 3: Layout Changes Between Portrait & Landscape

**Problem:** A horizontal scrolling list works in portrait but wastes space in landscape.

**Solution:** Conditional widget building:
```dart
if (isLandscape)
  GridView(...)  // Full-width grid when rotated
else
  SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(...))
```

#### Challenge 4: Touch Target Sizing

**Problem:** Buttons too small on tablets, too large on phones.

**Solution:** Responsive padding:
```dart
padding: EdgeInsets.all(isTablet ? 20 : 16),
padding: EdgeInsets.symmetric(vertical: isTablet ? 12 : 8),
```

### Real-World Impact of Responsive Design

**Improved User Experience:**
- Users with different devices see an optimized experience tailored to their screen
- No wasted space or cramped layouts
- Faster task completion without excessive scrolling or pinch-zooming

**Business Benefits:**
- Single codebase serves all devices (cost-effective)
- Future-proof for new screen sizes and form factors
- Higher App Store ratings due to polish on all platforms
- Broader audience reach (phones, tablets, foldables)

**Developer Advantages:**
- Reusable responsive components speed up future development
- Maintenance simplified (one screen = all breakpoints)
- Easier to test and debug compared to platform-specific versions



## Demo

Add a screenshot of the running app here:

```markdown
![GreenGuide Welcome Screen](docs/images/welcome_screen.png)
```

Suggested steps:

1. Run the app on an emulator or device.
2. Capture a screenshot of the Welcome screen.
3. Save it at `docs/images/welcome_screen.png` (create the folders if needed).
4. Commit the image so it appears in this README.

---

## Reflection

### Sprint #1 Learning

- Learned how Flutter organizes projects (entry point in `main.dart`, platform folders, and the `lib` directory for Dart code).
- Practiced composing UIs with core widgets like `Scaffold`, `AppBar`, `Column`, `Text`, `Icon`, and `ElevatedButton`.
- Understood how simple state is managed with `StatefulWidget` and `setState`, and how UI rebuilds react to state changes.
- Saw how a modular folder structure (screens, widgets, models, services) will help keep the codebase maintainable as more features and complex UIs are added in future sprints.

### Sprint #2 Learning – Responsive Design

#### What We Learned

1. **MediaQuery is Powerful** – Simple `MediaQuery.of(context).size.width` checks unlock massive flexibility. Instead of hardcoding assumptions about device width, we now query at runtime and adapt accordingly.

2. **LayoutBuilder Complements MediaQuery** – While MediaQuery gives us device info, `LayoutBuilder` provides constraints from parent widgets. Together, they enable truly adaptive layouts that respect both screen size and available space.

3. **Flexible Widgets Scale Naturally** – `Expanded`, `Flexible`, `FittedBox`, and `AspectRatio` handle the heavy lifting. They prevent overflow and maintain proportions across different screen densities.

4. **Orientation Switching Requires Conditional Logic** – Detecting `Orientation.landscape` vs. `Orientation.portrait` lets us restructure entire sections (e.g., tips in horizontal scroll on portrait, full grid on landscape).

5. **Typography Scales Gracefully** – Font sizes aren't one-size-fits-all. Using breakpoints (`isTablet` boolean) to scale heading, body, and caption text creates visual hierarchy that feels native across all devices.

#### Challenges Faced

- **Overthinking Breakpoints:** Initially tried too many size categories; learned that two breakpoints (`isTablet = width > 600`) covers most use cases.
- **Testing Across Devices:** Running on both emulators and physical devices revealed edge cases (e.g., status bar height affecting layout). Thorough testing is essential.
- **Balancing Aesthetics & Performance:** Conditional layouts (many if/else branches) can reduce readability. Extracted into separate widget methods to keep code clean.
- **Adapting Padding/Spacing:** What looks good on a phone (16dp) looks sparse on a tablet. Dynamic spacing is necessary but requires careful tuning.

#### Key Takeaway

**Responsive design is about delivering *one great experience* across all devices**, not building multiple versions. By using Flutter's built-in responsive tools, we've created a single `responsive_home.dart` that elegantly adapts to phones, tablets, and any screen size in between.

This approach is **scalable, maintainable, and user-centric** – the hallmark of professional mobile development.



---

## Firebase Integration (Sprint #2 – Authentication & Firestore)

### Overview

GreenGuide now features **Firebase Authentication** and **Cloud Firestore** integration for secure user login and real-time data storage. This enables:

- ✅ **User Registration & Login** – Secure email/password authentication
- ✅ **User Profiles** – Store user data in Firestore
- ✅ **Eco Tips Storage** – Add, edit, delete, and track sustainability tips
- ✅ **Real-time Updates** – StreamBuilder for live data synchronization
- ✅ **User Statistics** – Track completion rates and progress

### Firebase Setup

#### 1. Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com)
2. Click **"Create Project"** and name it (e.g., "GreenGuide")
3. Enable Google Analytics (optional)
4. Click **"Create"**

#### 2. Add Flutter App to Firebase

1. In Firebase Console, click **"Add App"** → select **"Flutter"**
2. Register each platform you're targeting (Android, iOS, Web, Windows)
3. Download the required configuration files:
   - **Android:** `google-services.json` → place in `android/app/`
   - **iOS:** `GoogleService-Info.plist` → place in `ios/Runner/`
   - **Web:** Auto-configured by FlutterFire CLI
   - **Windows:** Auto-configured by FlutterFire CLI

#### 3. Install FlutterFire CLI and Configure

Run this command from your project root:

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

This command will:
- Detect your platforms (Android, iOS, Web, etc.)
- Create/update `firebase_options.dart` with your credentials
- Enable necessary APIs in Firebase Console

**After running this command, your `firebase_options.dart` will be auto-generated with your actual Firebase credentials.**

#### 4. Install Firebase Dependencies

Your `pubspec.yaml` should already include:

```yaml
dependencies:
  firebase_core: ^3.0.0
  firebase_auth: ^5.0.0
  cloud_firestore: ^5.0.0
```

Run:

```bash
flutter pub get
```

### Code Implementation

#### AuthService (lib/services/auth_service.dart)

Handles all Firebase Authentication operations:

```dart
class AuthService {
  /// Sign up with email and password
  Future<UserCredential?> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential;
    } catch (e) {
      rethrow;
    }
  }

  /// Login with email and password
  Future<UserCredential?> login({
    required String email,
    required String password,
  }) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }

  /// Sign out
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}
```

#### FirestoreService (lib/services/firestore_service.dart)

Implements CRUD operations for storing user data and eco tips:

```dart
class FirestoreService {
  /// Save user profile to Firestore
  Future<void> saveUserProfile({
    required String uid,
    required String email,
    required String displayName,
  }) async {
    await _firestore.collection('users').doc(uid).set({
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  /// Add eco tip for user
  Future<String> addEcoTip({
    required String uid,
    required String title,
    required String description,
    required String category,
  }) async {
    final docRef = await _firestore
        .collection('users')
        .doc(uid)
        .collection('ecoTips')
        .add({
      'title': title,
      'description': description,
      'category': category,
      'completed': false,
      'createdAt': FieldValue.serverTimestamp(),
    });
    return docRef.id;
  }

  /// Stream eco tips (real-time updates)
  Stream<QuerySnapshot> streamUserEcoTips(String uid) {
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('ecoTips')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  /// Toggle completion status
  Future<void> toggleEcoTipCompletion({
    required String uid,
    required String tipId,
    required bool completed,
  }) async {
    await _firestore
        .collection('users')
        .doc(uid)
        .collection('ecoTips')
        .doc(tipId)
        .update({'completed': completed});
  }

  /// Delete eco tip
  Future<void> deleteEcoTip({
    required String uid,
    required String tipId,
  }) async {
    await _firestore
        .collection('users')
        .doc(uid)
        .collection('ecoTips')
        .doc(tipId)
        .delete();
  }
}
```

#### SignupScreen & LoginScreen

User-friendly forms with validation and error handling for account creation and authentication.

#### DashboardScreen

Displays:
- **User Statistics:** Total tips, completed, pending, completion rate
- **Eco Tips List:** StreamBuilder for real-time tip updates
- **Add/Edit/Delete:** Full CRUD operations on eco tips
- **Logout:** Sign out functionality

### Firestore Database Structure

```
users/
  {uid}/
    - uid: string
    - email: string
    - displayName: string
    - createdAt: timestamp
    - updatedAt: timestamp
    ecoTips/
      {tipId}/
        - title: string
        - description: string
        - category: string (enum: Water Conservation, Energy Savings, etc.)
        - completed: boolean
        - createdAt: timestamp
        - updatedAt: timestamp
```

### Testing Firebase Features

#### Test Signup

1. Tap **"Sign Up"** on login screen
2. Enter email, name, and password
3. Verify user created in Firebase Console → **Authentication** tab
4. User profile should appear in Firestore under `users/{uid}`

#### Test Login

1. Use registered credentials to log in
2. Should navigate to **DashboardScreen**
3. See user name in AppBar

#### Test Firestore CRUD

1. On dashboard, tap **"Add Tip"** button
2. Enter title, select category, add description
3. Tap **"Add Tip"** → observe real-time update in tips list
4. Check Firebase Console → **Firestore Database** → navigate to `users/{uid}/ecoTips/{tipId}`
5. Toggle completion checkbox → data updates instantly
6. Delete by tapping trash icon → document removed from Firestore

#### Verify Firebase Console

After testing, check:
- **Authentication:**  User email registered
- **Firestore:** Data structure matches schema above
- **Real-time Updates:** Changes in app reflect instantly in Console

### Authentication Error Handling

The app gracefully handles:
- Weak passwords (< 6 characters)
- Email already in use
- Invalid credentials during login
- Missing fields

All errors display user-friendly messages in a red banner.

### Challenges & Solutions

#### Challenge 1: Async Initialization

**Problem:** Firebase initialization happens asynchronously; UI renders before config loads.

**Solution:** Used `WidgetsFlutterBinding.ensureInitialized()` and `await Firebase.initializeApp()` in `main()` to ensure Firebase is ready before `runApp()`.

#### Challenge 2: Real-time Data Sync

**Problem:** Users expect instant updates when data changes.

**Solution:** Used `StreamBuilder` with `FirebaseFirestore.instance.collection(...).snapshots()` to listen to changes and rebuild UI automatically.

#### Challenge 3: User-Specific Data

**Problem:** One user's tips shouldn't be visible to another.

**Solution:** Used user's UID as document ID and collection path: `users/{uid}/ecoTips/{tipId}`.

#### Challenge 4: Error Handling

**Problem:** Firebase throws specific errors that need user-friendly messages.

**Solution:** Caught `FirebaseAuthException` with specific error codes (`weak-password`, `user-not-found`, etc.) and displayed meaningful messages.

### Security Rules for Firestore

Add these rules in **Firebase Console** → **Firestore Database** → **Rules tab:**

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users can only access their own documents
    match /users/{uid} {
      allow read, write: if request.auth.uid == uid;
      
      match /ecoTips/{document=**} {
        allow read, write: if request.auth.uid == uid;
      }
    }
  }
}
```

### Next Steps

1. ✅ Implement notification when tips are completed
2. ✅ Add tips sharing functionality
3. ✅ Implement leaderboard (top eco contributors)
4. ✅ Analytics tracking (how many users, total tips added, etc.)

---



- Official Flutter docs: https://docs.flutter.dev/
- Flutter widgets catalog: https://docs.flutter.dev/ui/widgets
- Dart language tour: https://dart.dev/guides/language/language-tour
- Flutter layout basics: https://docs.flutter.dev/ui/layout
- State management overview: https://docs.flutter.dev/development/data-and-backend/state-mgmt
