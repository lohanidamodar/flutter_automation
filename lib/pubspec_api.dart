part of flutter_automation;

class _PubspecAPI {
  final String baseUrl = "https://pub.dev/api/packages/";
  _PubspecAPI();
  Future<String?> getPackage(String package) async {
    http.Response res = await http.get(Uri.parse(baseUrl + package));
    if (res.statusCode == 200) {
      Map<String, dynamic> resJson = json.decode(res.body);
      _PubPackage package = _PubPackage.fromMap(resJson);
      return "${package.name}: ^${package.latest.version}";
    } else {
      return null;
    }
  }
}

class _PubPackage {
  final String? name;
  final _Version latest;

  _PubPackage(this.name, this.latest);

  _PubPackage.fromMap(Map<String, dynamic> data)
      : name = data["name"],
        latest = _Version.fromMap(data["latest"]);
}

class _Version {
  final String? version;
  final String? archiveUrl;

  _Version(this.version, this.archiveUrl);

  _Version.fromMap(Map<String, dynamic> data)
      : version = data["version"],
        archiveUrl = data["archive_url"];
}
