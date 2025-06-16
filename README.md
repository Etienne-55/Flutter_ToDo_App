# Todo App

A Flutter-based todo application for managing your daily tasks.

## Prerequisites

Before you begin, ensure you have the following installed:

- Flutter (3.0 or higher)
- Android Studio or VS Code
- Android SDK (API level 21 or higher)
- Git

## Installation & Setup

### 1. Clone the Repository
```bash
git clone https://github.com/Etienne-55/Flutter_ToDo_App.git
cd todo-app
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Configure Android
Ensure you have an Android device connected or an emulator running:
```bash
flutter devices
```

### 4. Run the App
```bash
flutter run
```

## Project Structure

```
lib/
├── main.dart              # App entry point
├── models/               # Data models (Todo, User)
├── screens/              # UI screens (Login, Home, etc.)
├── widgets/              # Reusable UI components
├── services/             # API/Database services
└── utils/                # Helper functions and constants
```

## Build APK

To build a release APK:
```bash
flutter build apk --release
```

The APK will be located at: `build/app/outputs/flutter-apk/app-release.apk`