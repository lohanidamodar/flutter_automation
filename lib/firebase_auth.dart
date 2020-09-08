part of flutter_automation;

List<String> plugins = ["firebase_auth", "provider", "google_sign_in"];
Map<String, dynamic> config = _Commons.loadConfig();
const String gradlePropertiesPath = "./android/gradle.properties";

/// Main firebase auth script function that setups firebase authentication with the help of other functions
void _firebaseAuth() async {
  _upgradeToAndroidX();
  await _addDependencise();
  _addGoogleService();
  _copyStockFiles();
  stdout.write("firebase auth implemented\n");
}

/// Adds firebase auth related dependencies to the pubspec.yaml file
Future<void> _addDependencise() async {
  plugins = plugins.where((plugin) {
    return !_Commons.pluginExists(plugin);
  }).toList();
  List<String> latest = [];
  for (var i = 0; i < plugins.length; i++) {
    String plugin = plugins[i];
    String plug = await _PubspecAPI().getPackage(plugin);
    latest.add(
        plug != null ? "  $plug" : "  $plugin: ${config['plugins'][plugin]}");
  }
  String content = latest.join("\n");
  _Commons.addDependencise(content);
  stdout.writeln("added dependencies");
}

/// adds google services configuration to build.gradle files
void _addGoogleService() {
  String pbuild = _Commons.getFileAsString(_Commons.projectBuildPath);
  if (!pbuild.contains("com.google.gms:google-services")) {
    _Commons.replaceFirstStringInfile(
        _Commons.projectBuildPath,
        RegExp("dependencies.*{"),
        "dependencies {\n        classpath 'com.google.gms:google-services:${config['google_services']}'\n");
    stdout.writeln("added google services");
  }
}

/// upgrades project to androidx if not already
void _upgradeToAndroidX() {
  String properties = _Commons.getFileAsString(gradlePropertiesPath);
  if (!properties.contains("android.useAndroidX")) {
    properties =
        "$properties\n\nandroid.enableJetifier=true\nandroid.useAndroidX=true\n";
    _Commons.writeStringToFile(gradlePropertiesPath, properties);
  }

  List<String> contents = _Commons.getFileAsLines(_Commons.appBuildPath);
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
  _Commons.writeStringToFile(_Commons.appBuildPath, content);
  stdout.write("upgraded to androidx\n");
}

/// copies stock files related to firebase authentication
void _copyStockFiles() {
  String stockPath =
      "${_Commons.scriptRoot}${path.separator}lib${path.separator}auth_stock${path.separator}lib";
  _Commons.copyFilesRecursive(stockPath, '.${path.separator}',
      renameBaseDir: '.${path.separator}lib');
}
