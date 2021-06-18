library flutter_automation;

import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:yaml/yaml.dart';

part './google_maps.dart';
part './android_signing.dart';
part './pubspec_api.dart';
part './commons.dart';
part './gen/helper.dart';

/// Deciphers which scripts to run based on the arguments provided by the user
/// Use `flutter pub pub run flutter_automation -h` to get help
void decipherScript(List<String> arguments) async {
  var parser = ArgParser(allowTrailingOptions: true);
  parser.addFlag('help', abbr: 'h', negatable: false, help: "Usage help");
  
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
  genParser.addFlag(
    "core",
    abbr: "c",
    help: "Generates core directory instead of feature directory",
    negatable: false,
  );

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
    stdout.writeln("\n");
    stdout.writeln(
        "[Command: gen] - flutter pub run flutter_automation gen <options>");
    stdout.writeln("Options:");
    stdout.writeln(genParser.usage);
    return;
  }

  if (argResults['google-maps']) {
    await googleMaps();
  }

  if (argResults['android-sign']) {
    _androidSign();
  }
}
