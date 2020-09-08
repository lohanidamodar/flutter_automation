part of flutter_automation;

/// Main google maps setup plugin
Future<void> googleMaps() async {
  await addGoogleMap();
  setupApiKey();
  addKeyToManifest();
  stdout.writeln("google maps successfully setup");
}

/// adds google maps dependency to pubspec.yaml file
Future<void> addGoogleMap() async {
  if (_Commons.pluginExists("google_maps_flutter")) return;
  String plugin = await _PubspecAPI().getPackage('google_maps_flutter');
  if (plugin == null)
    plugin =
        "google_maps_flutter: ${_Commons.loadConfig()['plugins']['google_maps']}";
  _Commons.addDependencise("  $plugin");
  stdout.writeln("added google maps plugin to pubspec");
}

/// setups a map api key configuration. Please replace YOUR_API_KEY with your actual api key
void setupApiKey() {
  _Commons.writeStringToFile(
      _Commons.stringsPath, """<?xml version="1.0" encoding="utf-8"?>
<resources>
    <string name="map_api_key">YOUR_API_KEY</string>
</resources>        
""");
  stdout.writeln(
      "created strings.xml with map api key. Open ${_Commons.stringsPath} and replace YOUR_API_KEY with your google maps api key");
}

/// writes api key meta data to app manifest file
void addKeyToManifest() {
  if (_Commons.fileContainsString(
    _Commons.manifestPath,
    "com.google.android.geo.API_KEY",
  )) return;
  String apiKey =
      "<meta-data android:name=\"com.google.android.geo.API_KEY\" android:value=\"@string/map_api_key\"/>";
  _Commons.replaceFirstStringInfile(
      _Commons.manifestPath, "<activity", "$apiKey\n        <activity");
  stdout.writeln("added map api key to manifest file");
}
