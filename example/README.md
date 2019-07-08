# Flutter Automation
This package contains various automation scripts that will help you automate various aspects of your flutter project.

## Usage
To use this plugin, add `flutter_automation` as a [dependency in your pubspec.yaml file](https://flutter.io/docs/development/packages-and-plugins/using-packages).

## Running scripts
From terminal in your flutter project run,
```
flutter pub pub run flutter_automation --firebase-auth --google-maps --android-sign --firestore-crud
```
### 1. Firebase Auth
This sets up firebase authentication with google and email based login automatically in your flutter project. Also copies boilerplate login ui flow using `provider` package for state management

```
flutter pub pub run flutter_automation --firebase-auth
```

### 2. Google Maps
sets up google maps flutter plugin on android platform in a flutter project.

After you run the script in your flutter project you need to modify `android/app/src/main/res/values/strings.xml` file changing the text `YOUR_API_KEY` to your actual google maps Api key.

```
flutter pub pub run flutter_automation --google-maps
```

### 3. Android Signing
Generates keystore and sets up android signing config in your flutter project.

It uses `keytool` to generate keystore so, for this script to work `keytool` must be in path.

```
flutter pub pub run flutter_automation --android-sign
```

### 4. Firestore CRUD
Provides a simple firestore CRUD operation boilerplate

```
flutter pub pub run flutter_automation --firestore-crud
```