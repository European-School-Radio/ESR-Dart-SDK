# European School Radio Dart SDK

A Dart client for interacting with the [European School Radio API](https://europeanschoolradio.eu).  
Easily fetch podcasts, episodes, user data and more through a clean, typed interface.

> 📡 Built for Flutter & Dart developers who want to integrate with the European School Radio platform.

---

## ✨ Features

- Call all available REST API methods from the European School Radio
- Easy-to-use interfaces for fetching podcasts, episodes, and user info
- Designed with async/await and error-handling in mind
- Pure Dart (works in Flutter and server-side Dart apps)

---

## 🚀 Getting Started

### Install

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  esr_dart_sdk:
  git:
    url: https://github.com/European-School-Radio/ESR-Dart-SDK
    ref: main
```

Then run:
```bash
flutter pub get
```

## 🔧 Usage

```dart
import 'package:esr_dart_sdk/esr_dart_sdk.dart';

void main() async {
  await ESRSDK.init(
    apiKey: "apiKey",
    env: ESREnvironments.test,
  );
}
```