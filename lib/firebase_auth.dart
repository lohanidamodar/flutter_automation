import 'dart:convert';
import 'dart:io';

import './commons.dart' as commons;

List<String> plugins = ["firebase_auth", "provider", "google_sign_in"];
Map<String,dynamic> config = commons.loadConfig();
const String gradlePropertiesPath="./android/gradle.properties";

void firebaseAuth(){
  upgradeToAndroidX();
  addDependencise();
  addGoogleService();
  copyStockFiles();
  stdout.write("firebase auth implemented\n");
}

void addDependencise() {
  String pubspec = commons.getFileAsString(commons.pubspecPath);
  plugins = plugins.where((plugin){
    return !pubspec.contains(plugin);
  }).toList();
  plugins = plugins.map((plugin){
    return "  $plugin: ${config['plugins'][plugin]}";
  }).toList();
  String content = plugins.join("\n");
  commons.addDependencise(content);
  stdout.writeln("added dependencies");
}

void addGoogleService() {
  String pbuild = commons.getFileAsString(commons.projectBuildPath);
  if(!pbuild.contains("com.google.gms:google-services")) {
    commons.replaceFirstStringInfile(commons.projectBuildPath, RegExp("dependencies.*{"), "dependencies {\n        classpath 'com.google.gms:google-services:${config['google_services']}'\n");
    stdout.writeln("added google services");
  }
}

void upgradeToAndroidX(){
  String properties = commons.getFileAsString(gradlePropertiesPath);
  if(!properties.contains("android.useAndroidX")) {
    properties = "$properties\n\nandroid.enableJetifier=true\nandroid.useAndroidX=true\n";
    commons.writeStringToFile(gradlePropertiesPath, properties);
  }

  List<String> contents = commons.getFileAsLines(commons.appBuildPath);
  contents = contents.map((line){
    if(line.contains("testInstrumentationRunner"))
      return "        testInstrumentationRunner \"androidx.test.runner.AndroidJUnitRunner\"\n";
    else if(line.contains("androidTestImplementation 'com.android.support.test:runner"))
      return "    androidTestImplementation 'androidx.test:runner:1.1.1'\n";
    else if(line.contains("androidTestImplementation 'com.android.support.test.espresso:espresso-core"))
      return "    androidTestImplementation 'androidx.test.espresso:espresso-core:3.1.1'\n";
    else
      return line;
  }).toList();
  String content = contents.join("\n");
  content = "$content\napply plugin: 'com.google.gms.google-services'\n";
  commons.writeStringToFile(commons.appBuildPath, content);
  stdout.write("upgraded to androidx\n");
}


void copyStockFiles() {
  String stockPath = "${commons.scriptRoot}/example/lib/auth_stock/lib";
  Process.run("cp", ["-r",  stockPath, "./"],stdoutEncoding: Utf8Codec()).then((res){
    stdout.write(res.stdout);
    stderr.write(res.stderr);
  });
  stdout.write("copied stock ui for firebase auth\n");
}