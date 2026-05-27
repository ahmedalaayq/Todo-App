import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileStorageManager {
  static final _instance = FileStorageManager._();

  FileStorageManager._();

  factory FileStorageManager()=>_instance;

  late final Directory appDir;
  late final File path;

  Future<void> init() async {
    appDir = await getApplicationDocumentsDirectory();
    path = File("${appDir.path}/todo.json");
  }
}
