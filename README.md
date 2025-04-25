# Recipe-Flutter-Application
# recipr 🍽️

**recipr** is a multilingual recipe app built with Flutter. It supports seamless language switching thanks to full integration of internationalization (i18n) and localization (l10n).

## ✨ Features

- 🔐 User Authentication (Login/Signup)
- 📖 Browse a collection of cooking recipes
- ❤️ Add recipes to your favorites
- ⭐ Rate recipes
- 🌐 Switch between 3 supported languages dynamically

## 🚀 Getting Started

To run the app locally:

1. **Install dependencies:**

   ```bash
   flutter pub get
2. **Generate localization files:**
   ```bash
   flutter gen-l10n

3. **Run the app:**
- Start your emulator or connect a physical device.
- Run the app with:
   ```bash
   flutter run lib/main.dart

## 📁 Project Structure

- **lib/** – Main application source code  
- **l10n/** – Localization ARB files  
- **pubspec.yaml** – Project configuration and dependencies  

## 📦 Tech Stack

- **Flutter**  
- **Dart**  
- **Flutter Intl (l10n/i18n)**  

## 💬 Localization

**recipr** currently supports 3 languages with dynamic switching. All texts are translated using ARB files, and Flutter's localization tool handles the rest.

## 🔧 Requirements

- Flutter SDK (latest stable)  
- Dart SDK  
- Android Studio / VSCode (recommended)  
- Emulator or physical device