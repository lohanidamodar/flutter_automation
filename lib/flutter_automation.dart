library flutter_automation;

import 'dart:io';

import 'package:args/args.dart';
import './firebase_auth.dart' as firebase_auth;
import './google_maps.dart' as google_maps;

void decipherScript(List<String> arguments) {
  var parser = ArgParser(allowTrailingOptions: true);
  parser.addFlag('help',abbr: 'h', negatable: false, help: "Usage help");
  parser.addFlag('firebase-auth',abbr: 'f', help: "Adds firebase authentication", negatable: false);
  parser.addFlag('google-maps',abbr: 'g', help: "Adds google maps", negatable: false);

  var argResults = parser.parse(arguments);

  if (argResults['help'] || argResults.arguments.length < 1) {
    stdout.write('Automation scripts for flutter');
    stdout.write(parser.usage);
    return;
  }

  if(argResults['firebase-auth']) {
    firebase_auth.firebaseAuth();
  }

  if(argResults['google-maps']) {
    google_maps.googleMaps();
  }
}