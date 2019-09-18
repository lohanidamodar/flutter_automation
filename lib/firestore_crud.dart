import 'dart:io';

import 'commons.dart' as commons;
import 'package:path/path.dart' as path;

/// main firestore CRUD setup function to setup firestore CRUD boilerplate
void firestoreCrud() {
  addFirestorePlugin();
  enableMultidex();
  copyStockFiles();
}

/// adds cloud_firestore plugin to pubspec.yaml file
void addFirestorePlugin() {
  String pubspec = commons.getFileAsString(commons.pubspecPath);
  String plugin =
      "  cloud_firestore: ${commons.loadConfig()['plugins']['firestore']}";
  if (!pubspec.contains("provider")) {
    plugin =
        "$plugin\n  provider: ${commons.loadConfig()['plugins']['provider']}";
  }
  commons.addDependencise(
      "  cloud_firestore: ${commons.loadConfig()['plugins']['firestore']}");
  stdout.writeln("cloud firestore dependencies added");
}

/// enables multidex if not already enabled
void enableMultidex() {
  String buildfile = commons.getFileAsString(commons.appBuildPath);
  if (!buildfile.contains("multiDexEnabled")) {
    buildfile = buildfile.replaceFirst(RegExp("defaultConfig.*{"),
        "defaultConfig {\n        multiDexEnabled true\n");
    buildfile = buildfile.replaceFirst(RegExp("dependencies.*{"),
        "dependencies {\n    implementation 'androidx.multidex:multidex:2.0.1'");
    commons.writeStringToFile(commons.appBuildPath, buildfile);
  }
}

/// copies stock files related to firestore CRUD
void copyStockFiles() {
  commons.copyFilesRecursive(
      '${commons.scriptRoot}${path.separator}lib${path.separator}firestore_crud_stock${path.separator}lib', '.${path.separator}',
      renameBaseDir: '.${path.separator}lib');
}
