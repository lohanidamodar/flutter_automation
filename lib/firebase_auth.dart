import 'dart:io';
import 'package:path/path.dart' as path;

import './commons.dart' as commons;

List<String> plugins = ["firebase_auth", "provider", "google_sign_in"];
Map<String, dynamic> config = commons.loadConfig();
const String gradlePropertiesPath = "./android/gradle.properties";

/// Main firebase auth script function that setups firebase authentication with the help of other functions
void firebaseAuth() {
  upgradeToAndroidX();
  addDependencise();
  addGoogleService();
  copyStockFiles();
  stdout.write("firebase auth implemented\n");
}

/// Adds firebase auth related dependencies to the pubspec.yaml file
void addDependencise() {
  String pubspec = commons.getFileAsString(commons.pubspecPath);
  plugins = plugins.where((plugin) {
    return !pubspec.contains(plugin);
  }).toList();
  plugins = plugins.map((plugin) {
    return "  $plugin: ${config['plugins'][plugin]}";
  }).toList();
  String content = plugins.join("\n");
  commons.addDependencise(content);
  stdout.writeln("added dependencies");
}

/// adds google services configuration to build.gradle files
void addGoogleService() {
  String pbuild = commons.getFileAsString(commons.projectBuildPath);
  if (!pbuild.contains("com.google.gms:google-services")) {
    commons.replaceFirstStringInfile(
        commons.projectBuildPath,
        RegExp("dependencies.*{"),
        "dependencies {\n        classpath 'com.google.gms:google-services:${config['google_services']}'\n");
    stdout.writeln("added google services");
  }
}

/// upgrades project to androidx if not already
void upgradeToAndroidX() {
  String properties = commons.getFileAsString(gradlePropertiesPath);
  if (!properties.contains("android.useAndroidX")) {
    properties =
        "$properties\n\nandroid.enableJetifier=true\nandroid.useAndroidX=true\n";
    commons.writeStringToFile(gradlePropertiesPath, properties);
  }

  List<String> contents = commons.getFileAsLines(commons.appBuildPath);
  contents = contents.map((line) {
    if (line.contains("testInstrumentationRunner"))
      return "        testInstrumentationRunner \"androidx.test.runner.AndroidJUnitRunner\"\n";
    else if (line
        .contains("androidTestImplementation 'com.android.support.test:runner"))
      return "    androidTestImplementation 'androidx.test:runner:1.1.1'\n";
    else if (line.contains(
        "androidTestImplementation 'com.android.support.test.espresso:espresso-core"))
      return "    androidTestImplementation 'androidx.test.espresso:espresso-core:3.1.1'\n";
    else
      return line;
  }).toList();
  String content = contents.join("\n");
  content = "$content\napply plugin: 'com.google.gms.google-services'\n";
  commons.writeStringToFile(commons.appBuildPath, content);
  stdout.write("upgraded to androidx\n");
}

/// copies stock files related to firebase authentication
void copyStockFiles() {
  String stockPath = "${commons.scriptRoot}${path.separator}lib${path.separator}auth_stock${path.separator}lib";
  commons.copyFilesRecursive(stockPath, '.${path.separator}', renameBaseDir: '.${path.separator}lib');
}
