import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const FlutterSecureStorage _localStorage = FlutterSecureStorage();

Future<String?> readProfileImage() async {
  return await _localStorage.read(key: "profile_image");
}

writeProfileImage(File data) async {
  return await _localStorage.write(
      key: "profile_image", value: data.toString());
}
