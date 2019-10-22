import 'dart:io';

import 'package:flutter_automation/pubspec_api.dart';

import 'commons.dart' as commons;
import 'package:path/path.dart' as path;

/// main firestore CRUD setup function to setup firestore CRUD boilerplate
void firestoreCrud() async {
  await addFirestorePlugin();
  enableMultidex();
  copyStockFiles();
}

/// adds cloud_firestore plugin to pubspec.yaml file
Future<void> addFirestorePlugin() async {
  String pubspec = commons.getFileAsString(commons.pubspecPath);
  String plugin = await PubspecAPI().getPackage("cloud_firestore");
  if(plugin == null)
  plugin =
      "cloud_firestore: ${commons.loadConfig()['plugins']['firestore']}";
  commons.addDependencise("  $plugin");
  if (!pubspec.contains("provider")) {
    plugin = null;
    plugin = await PubspecAPI().getPackage("provider");
    if(plugin==null)
    plugin =
        "$plugin\n  provider: ${commons.loadConfig()['plugins']['provider']}";
    commons.addDependencise("  $plugin");
  }
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
