import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
part "TaskObject.g.dart";
@HiveType(typeId: 1)
class TodoTask extends HiveObject {
  @HiveField(0)
  late String taskId;

  @HiveField(1)
  late String title;

  @HiveField(2)
  late bool isDone;

  @HiveField(3)
  late String? sessionId; // Optional: link to session if used

  // Constructor for initializing TodoTask
  TodoTask({
    required this.taskId,
    required this.title,
    required this.isDone,
    this.sessionId,
  });
}
