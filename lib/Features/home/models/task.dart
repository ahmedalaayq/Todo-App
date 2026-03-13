import 'package:uuid/uuid.dart';

class Task {
  static const uuid = Uuid();

  Task({
    required this.taskName,
    required this.taskDescription,
    this.isDone = false,
    required this.isHighPriority,
    String? id,
  }) : id = id ?? uuid.v4();

  final String taskName;
  final String taskDescription;
  bool isDone;
  final bool isHighPriority;
  final String id;

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      taskName: json["taskName"] as String? ?? "",
      taskDescription: json["taskDescription"] as String? ?? "",
      isDone: json["isDone"] as bool? ?? false,
      isHighPriority: json["isHighPriority"] as bool? ?? false,
      id: json["id"] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "taskName": taskName,
      "taskDescription": taskDescription,
      "isDone": isDone,
      "isHighPriority": isHighPriority,
      "id": id,
    };
  }

  @override
  String toString() {
    return 'Task(taskName: $taskName, taskDescription: $taskDescription, isDone: $isDone, isHighPriority: $isHighPriority, id: $id)';
  }
}
