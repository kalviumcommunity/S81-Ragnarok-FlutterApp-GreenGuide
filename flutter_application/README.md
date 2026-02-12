## GreenGuide – Sustainable Habits Companion

GreenGuide is a cross-platform Flutter app concept that helps users build simple, sustainable daily habits (like saving water, reducing waste, and tracking eco-friendly actions). This sprint focuses on setting up the Flutter environment and building the first "Welcome" screen.

---

## Folder Structure (lib/)

This project follows a modular structure under the `lib` directory:

- `lib/main.dart` – App entry point. Sets up `MaterialApp`, global theme, and routes to the first screen.
- `lib/screens/` – Screen-level widgets (full pages). Currently contains `welcome_screen.dart` for the main Welcome UI.
- `lib/widgets/` – Reusable, smaller UI components (buttons, cards, form fields). This will be used more in future sprints.
- `lib/models/` – (Planned) Data models for domain objects like `Habit`, `Category`, etc.
- `lib/services/` – (Planned) API, Firebase, and local storage logic.

### How this supports modular design

- Separates concerns: UI screens, reusable widgets, data models, and services live in different folders.
- Easier scaling: New features can be added by creating new screens, models, and services without touching unrelated code.
- Improved readability: Team members quickly know where to look for a particular type of file.

### Naming conventions

- Files: `snake_case.dart` (e.g., `welcome_screen.dart`, `habit_model.dart`).
- Classes & Widgets: `PascalCase` (e.g., `WelcomeScreen`, `HabitModel`).
- Variables & functions: `camelCase` (e.g., `selectedHabit`, `toggleMessage()`).

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

## Useful Flutter & Dart Resources

- Official Flutter docs: https://docs.flutter.dev/
- Flutter widgets catalog: https://docs.flutter.dev/ui/widgets
- Dart language tour: https://dart.dev/guides/language/language-tour
- Flutter layout basics: https://docs.flutter.dev/ui/layout
- State management overview: https://docs.flutter.dev/development/data-and-backend/state-mgmt
