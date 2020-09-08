part of flutter_automation;

/// main firestore CRUD setup function to setup firestore CRUD boilerplate
Future<void> _firestoreCrud() async {
  await _addFirestorePlugin();
  _enableMultidex();
  _copyFirestoreStock();
  _upgradeToAndroidX();
  _addGoogleService();
}

/// adds cloud_firestore plugin to pubspec.yaml file
Future<void> _addFirestorePlugin() async {
  if (!_Commons.pluginExists("cloud_firestore")) {
    String plugin = await _PubspecAPI().getPackage("cloud_firestore");
    if (plugin == null)
      plugin =
          "cloud_firestore: ${_Commons.loadConfig()['plugins']['firestore']}";
    _Commons.addDependencise("  $plugin");
  }
  if (!_Commons.pluginExists("provider")) {
    String plugin = await _PubspecAPI().getPackage("provider");
    if (plugin == null)
      plugin =
          "$plugin\n  provider: ${_Commons.loadConfig()['plugins']['provider']}";
    _Commons.addDependencise("  $plugin");
  }
  stdout.writeln("cloud firestore dependencies added");
}

/// enables multidex if not already enabled
void _enableMultidex() {
  String buildfile = _Commons.getFileAsString(_Commons.appBuildPath);
  if (!buildfile.contains("multiDexEnabled")) {
    buildfile = buildfile.replaceFirst(RegExp("defaultConfig.*{"),
        "defaultConfig {\n        multiDexEnabled true\n");
    buildfile = buildfile.replaceFirst(RegExp("dependencies.*{"),
        "dependencies {\n    implementation 'androidx.multidex:multidex:2.0.1'");
    _Commons.writeStringToFile(_Commons.appBuildPath, buildfile);
  }
}

/// copies stock files related to firestore CRUD
void _copyFirestoreStock() {
  _Commons.copyFilesRecursive(
      '${_Commons.scriptRoot}${path.separator}lib${path.separator}firestore_crud_stock${path.separator}lib',
      '.${path.separator}',
      renameBaseDir: '.${path.separator}lib');
}
