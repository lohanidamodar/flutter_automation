part of flutter_automation;

void _genFeatureDirectory({String path, String feature}) {
  _genBaseDirs("$path/features/$feature");
}

void _genBaseDirs(String path) {
  Directory("$path/data/models").createSync(recursive: true);
  stdout.writeln("models directory created");
  Directory("$path/data/services").createSync(recursive: true);
  stdout.writeln("services directory created");
  Directory("$path/presentation/pages").createSync(recursive: true);
  stdout.writeln("pages directory created");
  Directory("$path/presentation/widgets").createSync(recursive: true);
  stdout.writeln("widgets directory created");
  Directory("$path/res").createSync(recursive: true);
  stdout.writeln("resource directory created");
}

void _genCore({String path}) {
  final core = "$path/core";
  _genBaseDirs(core);
  final dbConstants = File("$core/res/db_constants.dart");
  if (!dbConstants.existsSync()) {
    dbConstants.writeAsStringSync("""
class DBConstants {
  
}
  """);
    stdout.writeln("db constants file created");
  }

  final appConstants = File("$core/res/app_constants.dart");
  if (!appConstants.existsSync()) {
    appConstants.writeAsStringSync("""
class AppConstants {
  static const String appName = "Flutter Automation App";
}
  """);
    stdout.writeln("app constants file created");
  }

  final assets = File("$core/res/assets.dart");
  if (!assets.existsSync()) {
    assets.writeAsStringSync("""
class AppAssets {
  static const String appIcon = "assets/icon.png";
}
  """);

    stdout.writeln("assets file created");
  }

  final colors = File("$core/res/colors.dart");
  if (!colors.existsSync()) {
    colors.writeAsStringSync("""
import 'package:flutter/material.dart';

class AppColors {
  static final Color primaryColor = Colors.red;
}
  """);
    stdout.writeln("colors file created");
  }

  final routes = File("$core/res/routes.dart");
  if (!routes.existsSync()) {
    routes.writeAsStringSync("""
import 'package:flutter/material.dart';

class AppRoutes {
  static const String home = "home";

  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
      default:
        return _buildRoute(
          settings,
          Scaffold(
            body: Center(
              child: Text("Page for route \${settings.name} is not found"),
            ),
          ),
        );
    }
  }

  static Route _buildRoute(RouteSettings settings, Widget builder,
      [bool fullScreenDialog = false]) {
    return MaterialPageRoute(
      fullscreenDialog: fullScreenDialog,
      settings: settings,
      builder: (_) => builder,
    );
  }
}  
  """);
    stdout.writeln("routes file created");
  }

  final sizes = File("$core/res/sizes.dart");
  if (!sizes.existsSync()) {
    sizes.writeAsStringSync("""
class AppSizes {
  static const double borderRadius=10.0;
}
  """);
    stdout.writeln("sizes file created");
  }

  final themes = File("$core/res/themes.dart");
  if (!themes.existsSync()) {
    themes.writeAsStringSync("""
import 'package:flutter/material.dart';

class AppThemes {
  static final ThemeData defaultTheme = ThemeData(
    primarySwatch: Colors.red,
    appBarTheme: AppBarTheme(),
    buttonTheme: ButtonThemeData(),
  );
}
  """);
    stdout.writeln("themes file created");
  }
}
