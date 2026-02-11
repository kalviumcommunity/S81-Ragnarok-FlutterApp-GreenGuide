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

- Learned how Flutter organizes projects (entry point in `main.dart`, platform folders, and the `lib` directory for Dart code).
- Practiced composing UIs with core widgets like `Scaffold`, `AppBar`, `Column`, `Text`, `Icon`, and `ElevatedButton`.
- Understood how simple state is managed with `StatefulWidget` and `setState`, and how UI rebuilds react to state changes.
- Saw how a modular folder structure (screens, widgets, models, services) will help keep the codebase maintainable as more features and complex UIs are added in future sprints.

---

## Useful Flutter & Dart Resources

- Official Flutter docs: https://docs.flutter.dev/
- Flutter widgets catalog: https://docs.flutter.dev/ui/widgets
- Dart language tour: https://dart.dev/guides/language/language-tour
- Flutter layout basics: https://docs.flutter.dev/ui/layout
- State management overview: https://docs.flutter.dev/development/data-and-backend/state-mgmt
