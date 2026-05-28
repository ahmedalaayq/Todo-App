import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:todo_app/Features/home/models/task.dart';

class FileStorageManager {
  static final _instance = FileStorageManager._();

  FileStorageManager._();

  factory FileStorageManager() => _instance;

  late final Directory appDir;
  late final File filePath;

  Future<void> init() async {
    appDir = await getApplicationDocumentsDirectory();
    filePath = File("${appDir.path}/todo.json");
  }

  Future<void> saveFileContent(List<Task> tasks) async {
    final data = tasks.map((e) => e.toJson()).toList();

    final encode = jsonEncode(data);

    await filePath.writeAsString(encode);
  }

  Future<List<Task>> loadFileContent() async {
    if (!await filePath.exists()) return [];

    final content = await filePath.readAsString();

    final List decoded = jsonDecode(content);

    return decoded.map((e) => Task.fromJson(e)).toList();
  }
}
