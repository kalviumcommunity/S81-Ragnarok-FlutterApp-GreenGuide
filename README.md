# GreenGuide – Smart Plant Care Companion

A complete, fully-functional Flutter learning application demonstrating professional architecture, state management, and reactive UI patterns.

## 📱 Features

### Core Functionality
- **Splash Screen** - Auto-navigates after 2 seconds
- **Login System** - Email/password authentication (mock with demo credentials)
- **My Plants** - Browse and manage your plant collection
- **Add Plant** - Search, select, or add plants with care guides
- **Plant Details** - View comprehensive care information and watering tracker
- **Reminders** - Receive watering reminders for your plants
- **Store** - Browse nursery products (soil, fertilizer, pots)

### Architecture Highlights
- ✅ 7 complete screens with proper navigation
- ✅ Data models for Plant and Product
- ✅ Proper StatelessWidget vs StatefulWidget usage
- ✅ Const constructors for optimal performance
- ✅ Isolated state management (partial rebuilds)
- ✅ Material 3 theming
- ✅ Single-file implementation (lib/main.dart)

## 🔐 Login Credentials

```
Email:    user@greenguide.com
Password: password123
```

## 📁 Project Structure

```
S81-Ragnarok-FlutterApp-GreenGuide/
├── lib/
│   └── main.dart           # Complete Flutter application
├── pubspec.yaml            # Dependencies and project config
├── .gitignore             # Git ignore rules
└── README.md              # This file
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.0+
- Dart SDK 3.0+
- Android Studio or VS Code with Flutter extension

### Installation

1. Clone this repository:
```bash
git clone https://github.com/yourusername/GreenGuide.git
cd S81-Ragnarok-FlutterApp-GreenGuide
```

2. Get dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## 📖 Documentation

### Screens

#### 1. **SplashScreen** (StatelessWidget)
- Displays the GreenGuide logo
- Auto-navigates to LoginScreen after 2 seconds
- Uses Material 3 gradient background

#### 2. **LoginScreen** (StatefulWidget)
- Email and password input fields
- Fake login validation (test with demo credentials)
- Loading state during authentication
- Navigation to HomeScreen on success

#### 3. **HomeScreen** (StatelessWidget)
- Displays user's plant collection as a ListView
- Floating action button to add new plants
- BottomNavigationBar with three sections:
  - Home: My Plants
  - Reminders: Watering reminders
  - Store: Nursery products

#### 4. **AddPlantScreen** (StatefulWidget)
- Search plant by name
- Enter plant code (optional)
- Dropdown with sample plants (Snake Plant, Aloe Vera, Rose)
- Preview selected plant information
- Add to collection

#### 5. **PlantDetailScreen** (StatefulWidget)
- Comprehensive plant care information
- Watering schedule, sunlight requirements, fertilizer guide
- Repotting instructions and common problems
- **Water Counter Widget**: Tracks times watered
- "Mark as Watered" button triggers setState() for reactive update

#### 6. **RemindersScreen** (StatelessWidget)
- Mock watering reminders list
- Dismiss reminders functionality

#### 7. **StoreScreen** (StatelessWidget)
- Grid of nursery products
- Price display and add-to-cart functionality

## 🎓 Key Learning Concepts

### StatelessWidget vs StatefulWidget

**StatelessWidget:**
- Immutable, no internal state
- Used for: SplashScreen, RemindersScreen, StoreScreen, PlantTile, PlantInfoCard
- More efficient, lighter weight

**StatefulWidget:**
- Mutable, tracks state changes
- Used for: LoginScreen, AddPlantScreen, PlantDetailScreen
- Allows user interaction and data changes

### State Management & Performance

**Const Constructors:**
All supporting widgets (PlantTile, PlantInfoCard, WaterCounterWidget) use `const` constructors. This enables Flutter to:
- Reuse widget objects across rebuilds
- Skip rebuild of unchanged widgets
- Maintain 60+ FPS performance

**Partial Rebuilds:**
When "Mark as Watered" is tapped in PlantDetailScreen:
1. setState() is called on PlantDetailScreenState
2. build() creates a new widget tree
3. Flutter's diffing algorithm detects only WaterCounterWidget changed
4. Only WaterCounterWidget rebuilds (others are reused from const cache)
5. PlantInfoCard and care cards remain unchanged

### Data Model

```dart
// Plant: Complete care information
class Plant {
  String id;
  String name;
  String watering;      // e.g., "Every 3 days"
  String sunlight;      // e.g., "Indirect, 6-8 hours"
  String fertilizer;    // e.g., "Monthly"
  String repotting;     // e.g., "Every 18 months"
  List<String> problems; // Common issues
}

// Product: Store items
class Product {
  String id;
  String name;
  double price;
}

// UserPlant: Tracks watering count
class UserPlant {
  Plant plant;
  int wateredCount;
}
```

### In-Memory Data (Firebase Simulation)

The `AppState` singleton stores:
- Sample plants database
- Store products
- User's plant collection (userPlants)
- Mock reminders
- Logged-in user information

This simulates a database layer without Firebase. Easy to swap with real Firebase later using async/await.

## 🔄 Navigation Flow

```
SplashScreen (2s) → LoginScreen → HomeScreen
                      ↓                ↓
                   [Demo Credentials]  ├→ AddPlantScreen
                                       ├→ PlantDetailScreen
                                       ├→ RemindersScreen (BottomNav)
                                       └→ StoreScreen (BottomNav)
```

## 🎨 UI/UX Features

- Material 3 theme with green color scheme
- Responsive layout (works on all screen sizes)
- Smooth navigation with MaterialPageRoute
- Error handling with SnackBars
- Loading states during authentication
- Professional typography and spacing
- Card-based design for plant information

## 📊 Code Statistics

- **Total Lines**: ~2,000+ (including documentation)
- **Widgets**: 16 (7 screens + 9 supporting)
- **State Management**: 3 StatefulWidgets
- **Data Models**: 4 classes
- **In-Memory Collections**: 4 lists

## 🚀 Future Enhancements

- ✨ Firebase Authentication
- 🌐 Firestore for plant persistence
- 📸 Camera integration for plant identification
- 🔔 Local notifications for reminders
- 📍 Location-based nursery finder
- 🎯 User profiles and preferences
- 💬 Community plant care tips

## 📝 University Assignment Requirements

✅ All 7 screens implemented
✅ Proper use of StatelessWidget and StatefulWidget
✅ setState() for reactive updates
✅ Const constructors for performance
✅ Navigation between all screens working
✅ Data models (Plant, Product)
✅ In-memory data storage (Firebase simulation)
✅ Material 3 theme
✅ Clean, well-commented code
✅ Single main.dart file
✅ Comprehensive documentation at bottom of code

## 🤝 Contributing

This is a university assignment project. Feel free to fork and extend it for your learning.

## 📄 License

MIT License - feel free to use this for educational purposes.

## ✨ Acknowledgments

Built as a demonstration of Flutter's widget-based architecture, state management, and the Dart reactive rendering model.

---

**Questions?** Check the comprehensive documentation in `lib/main.dart` at the bottom of the file for detailed explanations of Flutter concepts.
