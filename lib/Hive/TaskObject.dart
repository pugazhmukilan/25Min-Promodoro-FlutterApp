import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';


@HiveType(typeId: 2) // Unique typeId (e.g., 2, different from Session's 1)
class Task extends HiveObject {
  @HiveField(0)
  late String taskId; // Will be initialized in constructor

  @HiveField(1)
  String taskName; // Name of the task

  @HiveField(2)
  bool status; // Task completion status (true for done, false for pending)

  // Constructor with UUID generation
  Task({
    this.taskName = '', // Default empty name
    this.status = false, // Default to pending
  }) {
    taskId = const Uuid().v1(); // Generate UUID in constructor
  }

  getid(){
    return taskId;
  }

  markasdone(){
    status = true;
  }
  masrkasundone(){
    status = false;
  }
}