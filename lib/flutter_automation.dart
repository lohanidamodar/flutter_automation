library flutter_automation;

import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:yaml/yaml.dart';

part './firebase_auth.dart';
part './google_maps.dart';
part './android_signing.dart';
part './firestore_crud.dart';
part './pubspec_api.dart';
part './commons.dart';
part './gen/helper.dart';

/// Deciphers which scripts to run based on the arguments provided by the user
/// Use `flutter pub pub run flutter_automation -h` to get help
void decipherScript(List<String> arguments) async {
  var parser = ArgParser(allowTrailingOptions: true);
  parser.addFlag('help', abbr: 'h', negatable: false, help: "Usage help");
  parser.addFlag('firebase-auth',
      abbr: 'f', help: "Adds firebase authentication", negatable: false);
  parser.addFlag('firestore-crud',
      abbr: 'c', help: "Adds firestore CRUD boilerplate", negatable: false);
  parser.addFlag('google-maps',
      abbr: 'g', help: "Adds google maps", negatable: false);

  parser.addFlag("android-sign",
      abbr: 's', help: "Setups android signing config", negatable: false);

  var genParser = ArgParser(allowTrailingOptions: true);
  parser.addCommand("gen", genParser);
  genParser.addOption("path",
      abbr: "p",
      help: "Base path, defaults to ${_Commons.basePath}",
      defaultsTo: _Commons.basePath);
  genParser.addFlag("core",
      abbr: "c", help: "Generates core directory instead of feature directory");

  var argResults = parser.parse(arguments);
  if (argResults.command?.name == "gen") {
    final genArgResults = genParser.parse(argResults.command.arguments);
    if (genArgResults["core"]) {
      _genCore(path: genArgResults["path"]);
    } else {
      _genFeatureDirectory(
          path: genArgResults["path"],
          feature: argResults.command.arguments.first);
    }
    return;
  }
  if (argResults['help'] || argResults.arguments.length < 1) {
    stdout.write('Automation scripts for flutter');
    stdout.write(parser.usage);
    return;
  }

  if (argResults['firebase-auth']) {
    await _firebaseAuth();
  }

  if (argResults['google-maps']) {
    await googleMaps();
  }

  if (argResults['firestore-crud']) {
    await _firestoreCrud();
  }

  if (argResults['android-sign']) {
    _androidSign();
  }
}
