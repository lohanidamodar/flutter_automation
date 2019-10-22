import 'dart:convert';

import 'package:http/http.dart' as http;

class PubspecAPI {
  final String baseUrl = "https://pub.dev/api/packages/";
  PubspecAPI();
  Future<String> getPackage(String package) async {
    http.Response res = await http.get(baseUrl+package);
    if(res.statusCode == 200) {
      Map<String,dynamic> resJson = json.decode(res.body);
      PubPackage package = PubPackage.fromMap(resJson);
      return "${package.name}: ^${package.latest.version}";

    }else{
      return null;
    }
  }
}

class PubPackage {
  final String name;
  final Version latest;

  PubPackage(this.name, this.latest);

  PubPackage.fromMap(Map<String,dynamic> data):
    name=data["name"],
    latest=Version.fromMap(data["latest"]);
}

class Version {
  final String version;
  final String archiveUrl;

  Version(this.version, this.archiveUrl);

  Version.fromMap(Map<String,dynamic> data):
  version = data["version"],
  archiveUrl=data["archive_url"];
}
