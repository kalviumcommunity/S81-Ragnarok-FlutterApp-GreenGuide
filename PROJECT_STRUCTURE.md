# GreenGuide - Project File Guide

## 📂 Project Structure

```
S81-Ragnarok-FlutterApp-GreenGuide/
│
├── 📄 README.md
│   └── Complete project documentation
│       - Feature overview
│       - Getting started guide
│       - Screen descriptions
│       - Learning concepts
│       - Architecture patterns
│
├── 📄 pubspec.yaml
│   └── Flutter project configuration
│       - Dependencies
│       - SDK requirements
│       - Project metadata
│
├── 📄 .gitignore
│   └── Git ignore rules
│       - Flutter build artifacts
│       - IDE configurations
│       - Dependencies
│
├── 📄 IMPLEMENTATION_SUMMARY.md
│   └── Project completion checklist
│       - Feature checklist
│       - Code statistics
│       - Learning points
│       - Future roadmap
│
├── 📁 lib/
│   └── 📄 main.dart (2,000+ lines)
│       ├── App Entry Point (main & GreenGuideApp)
│       │
│       ├── Data Models
│       │   ├── Plant (id, name, watering, sunlight, fertilizer, repotting, problems)
│       │   ├── Product (id, name, price)
│       │   └── UserPlant (plant, wateredCount)
│       │
│       ├── Global State (AppState singleton)
│       │   ├── samplePlants: List<Plant>
│       │   ├── storeProducts: List<Product>
│       │   ├── userPlants: List<UserPlant>
│       │   ├── reminders: List<String>
│       │   └── loggedInUser: String?
│       │
│       ├── Screen Widgets
│       │   ├── SplashScreen (StatelessWidget)
│       │   │   └── Displays logo, auto-navigates after 2s
│       │   │
│       │   ├── LoginScreen (StatefulWidget)
│       │   │   ├── Email input field
│       │   │   ├── Password input field
│       │   │   ├── Fake auth logic with loading state
│       │   │   └── Navigation to HomeScreen
│       │   │
│       │   ├── HomeScreen (StatelessWidget)
│       │   │   ├── ListView of user plants
│       │   │   ├── FloatingActionButton (Add Plant)
│       │   │   └── BottomNavigationBar (Home, Reminders, Store)
│       │   │
│       │   ├── AddPlantScreen (StatefulWidget)
│       │   │   ├── Search plant field
│       │   │   ├── Plant code input
│       │   │   ├── Dropdown (Snake Plant, Aloe Vera, Rose)
│       │   │   └── Add button (setState called)
│       │   │
│       │   ├── PlantDetailScreen (StatefulWidget)
│       │   │   ├── Plant info card
│       │   │   ├── Water counter widget (tracks wateredCount)
│       │   │   ├── Care information cards
│       │   │   ├── Common problems list
│       │   │   └── "Mark as Watered" button (triggers setState)
│       │   │
│       │   ├── RemindersScreen (StatelessWidget)
│       │   │   └── ListView of mock reminders
│       │   │
│       │   └── StoreScreen (StatelessWidget)
│       │       └── GridView of products
│       │
│       ├── Supporting Widgets (all const constructors)
│       │   ├── PlantTile (displays plant in list)
│       │   ├── PlantInfoCard (shows basic plant info)
│       │   └── WaterCounterWidget (tracks watering count)
│       │
│       └── Documentation (500+ lines)
│           ├── Widget-based architecture & Skia engine
│           ├── Dart reactive rendering model
│           ├── StatelessWidget vs StatefulWidget
│           ├── setState() and partial rebuilds
│           ├── Laggy To-Do App case study
│           ├── How GreenGuide avoids unnecessary rebuilds
│           ├── async/await with Firebase
│           └── UI optimization triangle
│
└── .git/
    └── Version control
        ├── main branch: Original code
        └── Concept1 branch: Complete GreenGuide implementation
```

---

## 🎯 Files Overview

### 1. **lib/main.dart** - The Complete App (2,000+ lines)

**Size**: ~2,000 lines of code + documentation
**Purpose**: Single-file Flutter application
**Contains**:
- 7 complete screens
- 4 data models
- 16 total widgets
- Comprehensive comments
- 500+ lines of educational documentation

**Key Sections**:
- Lines 1-10: Imports
- Lines 12-130: Data models (Plant, Product, UserPlant)
- Lines 132-190: Global state (AppState singleton)
- Lines 192-210: Main app setup
- Lines 212-280: SplashScreen (StatelessWidget)
- Lines 282-380: LoginScreen (StatefulWidget)
- Lines 382-450: HomeScreen (StatelessWidget)
- Lines 452-630: AddPlantScreen (StatefulWidget)
- Lines 632-850: PlantDetailScreen (StatefulWidget)
- Lines 852-920: RemindersScreen (StatelessWidget)
- Lines 922-1050: StoreScreen (StatelessWidget)
- Lines 1052-1150: Supporting widgets (PlantTile, PlantInfoCard, WaterCounterWidget)
- Lines 1152-2000: Comprehensive documentation

---

### 2. **pubspec.yaml** - Project Configuration

```yaml
name: greenguide
description: GreenGuide – Smart Plant Care Companion
version: 1.0.0+1

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter

dev_dependencies:
  flutter_test:
    sdk: flutter

flutter:
  uses-material-design: true
```

**Purpose**: Defines project metadata, SDK requirements, and dependencies

---

### 3. **.gitignore** - Git Ignore Rules

Excludes from version control:
- Flutter build artifacts (build/, .dart_tool/)
- Generated code (*.g.dart, *.config.dart)
- IDE files (.vscode/, .idea/)
- Platform-specific folders (ios/, android/, web/, windows/, macos/, linux/)
- OS files (.DS_Store, Thumbs.db)
- Dependencies (pubspec.lock)

---

### 4. **README.md** - Project Documentation

**Sections**:
- Features overview
- Login credentials
- Project structure
- Getting started guide
- Screen descriptions with details
- Learning concepts (StatelessWidget vs StatefulWidget)
- State management & performance
- Data model explanation
- Navigation flow diagram
- UI/UX features
- Code statistics
- Future enhancements
- Assignment requirements checklist

---

### 5. **IMPLEMENTATION_SUMMARY.md** - Completion Checklist

**Sections**:
- ✅ All requirements met
- 📊 Code statistics
- 🚀 Running the app
- 📱 App flow diagram
- 🎓 Key learning points
- 🔮 Future enhancements
- 📝 Assignment checklist

---

## 🔄 Navigation Map

```
START
  ↓
SplashScreen.build()
  ├─ Shows "GreenGuide" logo
  ├─ Gradient background (green theme)
  └─ Future.delayed(2s) → Navigator.pushReplacement(LoginScreen)
       ↓
   LoginScreen.build()
       ├─ Email input field
       ├─ Password input field
       ├─ "Login" button → _handleLogin()
       │   ├─ setState() { isLoading = true }
       │   ├─ Future.delayed(1s) → validate credentials
       │   └─ If valid: Navigator.pushReplacement(HomeScreen)
       └─ Demo credentials displayed
            ↓
        HomeScreen.build()
            ├─ ListView.builder(AppState().userPlants)
            │   └─ Each item: PlantTile (const widget)
            │       └─ OnTap: Navigator.push(PlantDetailScreen)
            │            ↓
            │        PlantDetailScreen.build()
            │            ├─ PlantInfoCard (const)
            │            ├─ WaterCounterWidget
            │            │   └─ "Mark as Watered" button
            │            │       └─ setState() { wateredCount++ }
            │            │           └─ Only WaterCounterWidget rebuilds
            │            └─ Care cards (const)
            │
            ├─ FloatingActionButton(+)
            │   └─ Navigator.push(AddPlantScreen)
            │        ↓
            │    AddPlantScreen.build()
            │        ├─ Search field
            │        ├─ Plant code field
            │        ├─ Dropdown (3 sample plants)
            │        │   └─ setState() on selection change
            │        └─ "Add to My Plants" button
            │            └─ AppState().userPlants.add(UserPlant)
            │            └─ Navigator.pop()
            │
            └─ BottomNavigationBar
                ├─ "Reminders" → Navigator.push(RemindersScreen)
                │   └─ RemindersScreen.build()
                │       └─ ListView(AppState().reminders)
                │
                └─ "Store" → Navigator.push(StoreScreen)
                    └─ StoreScreen.build()
                        └─ GridView(AppState().storeProducts)
```

---

## 💾 Git History

```
Concept1 branch:
  ├─ 10702ff (HEAD) docs: add implementation summary and project completion checklist
  ├─ 3dcab32 feat: implement complete GreenGuide Flutter app with 7 screens
  │
main branch:
  ├─ c281e63 Rename project from PlantPal to GreenGuide
  └─ accb9be Initial commit
```

---

## 🎓 Code Patterns Used

### Pattern 1: Singleton Pattern (AppState)
```dart
class AppState {
  static final AppState _instance = AppState._internal();
  
  factory AppState() => _instance;
  AppState._internal();
}
```
Global state management without external libraries.

### Pattern 2: Const Constructor (Performance)
```dart
const PlantTile({
  super.key,
  required this.userPlant,
  required this.onTap,
});
```
Enables widget reuse and avoids unnecessary rebuilds.

### Pattern 3: StatefulWidget Isolation
```dart
// Only rebuild WaterCounterWidget on state change
class WaterCounterWidget extends StatelessWidget {
  final int wateredCount;
  final VoidCallback onWatered;
  
  const WaterCounterWidget({
    required this.wateredCount,
    required this.onWatered,
  });
}
```
Parent (PlantDetailScreen) receives updated count and passes to const child.

### Pattern 4: Future-Based Navigation
```dart
Future.delayed(const Duration(seconds: 2), () {
  Navigator.pushReplacement(...);
});
```
Auto-navigation without external dependencies.

---

## 📋 Checklist for Running

- [ ] Flutter SDK 3.0+ installed
- [ ] Dart SDK 3.0+ installed
- [ ] Android Studio or VS Code with Flutter extension
- [ ] Run: `flutter pub get`
- [ ] Run: `flutter run`
- [ ] Test login with user@greenguide.com / password123
- [ ] Navigate through all screens
- [ ] Test "Add Plant" functionality
- [ ] Test "Mark as Watered" to verify setState works
- [ ] Check BottomNav navigation to Reminders and Store

---

**Ready to use!** Start with `flutter run` in the project directory.
