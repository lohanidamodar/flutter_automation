import 'dart:io';
import 'package:yaml/yaml.dart';
import 'package:path/path.dart' as path;

String scriptRoot =
    path.dirname(Platform.script.toFilePath()) + "${path.separator}..";

const String basePath = "./lib";

const String pubspecPath = './pubspec.yaml';
const String stringsPath = "./android/app/src/main/res/values/strings.xml";
const String manifestPath = "./android/app/src/main/AndroidManifest.xml";
const String appBuildPath = "./android/app/build.gradle";
const String projectBuildPath = "./android/build.gradle";

/// Default plugin versions
Map<String, dynamic> defaultConfig = {
  "plugins": {
    "firebase_auth": "^0.14.0+5",
    "google_sign_in": "^4.0.7",
    "provider": "^3.1.0",
    "google_maps": "^0.5.21+2",
    "firestore": "^0.12.9+4"
  },
  "google_services": "4.3.3"
};

/// Loads config either from the flutter_automation.yaml config file or default config
Map<String, dynamic> loadConfig() {
  if (!File("./flutter_automation.yaml").existsSync()) return defaultConfig;
  String configcontent = File("./flutter_automation.yaml").readAsStringSync();
  var configFile = loadYaml(configcontent);
  return Map<String, dynamic>.from(configFile);
}

/// Adds provided dependencies to pubspec.yaml file
void addDependencise(String dependencies) {
  replaceFirstStringInfile(
      pubspecPath, "dev_dependencies:", "$dependencies\ndev_dependencies:");
}

/// replace string in a file at [path] from [from] to [to]
void replaceFirstStringInfile(String path, Pattern from, String to) {
  String contents = getFileAsString(path);
  contents = contents.replaceFirst(from, to);
  writeStringToFile(path, contents);
}

/// Reads a file at [path] as string
String getFileAsString(String path) {
  return File(path).readAsStringSync();
}

/// writes a string [contents] to a file at [path]
void writeStringToFile(String path, String contents) {
  File(path).writeAsStringSync(contents);
}

/// Reads a file at [path] as a list of lines
List<String> getFileAsLines(String path) {
  return File(path).readAsLinesSync();
}

/// Copies files recursively from [from] directory to [to] directory
void copyFilesRecursive(String from, String to, {String renameBaseDir}) {
  Process.run(
    "cp",
    ["-r", from, to],
  ).then((res) {
    stdout.write(res.stdout);
    if (res.stderr.toString().isNotEmpty) {
      stderr.write(res.stderr);
    } else {
      if (renameBaseDir != null) {
        renameStockFiles(renameBaseDir);
      }
      stdout.writeln("copied stock files");
    }
  });
}

/// Renames all stock files in [basedir]
void renameStockFiles(String basedir) {
  Directory dir = Directory(basedir);
  List<FileSystemEntity> files = dir.listSync(recursive: true);
  files.forEach((file) {
    if (file is File) {
      String filename = path.basename(file.path);
      if (filename.substring(filename.length - 5, filename.length) == ".temp") {
        String newFilename = filename.substring(0, filename.length - 5);
        file.renameSync(path.dirname(file.path) + path.separator + newFilename);
      }
    }
  });
  stdout.writeln("renamed stock files");
}
