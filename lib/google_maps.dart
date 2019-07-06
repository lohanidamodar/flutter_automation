
import 'dart:io';
import './commons.dart' as commons;

void googleMaps(){
  addGoogleMap();
  setupApiKey();
  addKeyToManifest();
  stdout.writeln("google maps successfully setup");

}

void addGoogleMap() {
  String googleMapsPlugin = "google_maps_flutter: ${commons.loadConfig()['google_maps']}";
  commons.addDependencise(googleMapsPlugin);
  stdout.writeln("added google maps plugin to pubspec");
}

void setupApiKey() {
  commons.writeStringToFile(commons.stringsPath, """<?xml version="1.0" encoding="utf-8"?>
<resources>
    <string name="map_api_key">YOUR_API_KEY</string>
</resources>        
""");
  stdout.writeln("created strings.xml with map api key. Open ${commons.stringsPath} and replace YOUR_API_KEY with your google maps api key");
}

void addKeyToManifest() {
  String apiKey = "<meta-data android:name=\"com.google.android.geo.API_KEY\" android:value=\"@string/map_api_key\"/>";
  commons.replaceFirstStringInfile(commons.manifestPath,"<activity", "$apiKey\n        <activity");
  stdout.writeln("added map api key to manifest file");
}