import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
import 'TaskObject.dart'; // Import the Task class


@HiveType(typeId: 1)
class Session extends HiveObject {
  @HiveField(0)
  late String sessionId; // Will be initialized in constructor

  @HiveField(1)
  String sessionName;

  @HiveField(2)
  int sprints;

  @HiveField(3)
  int completedTaskCount;

  @HiveField(4)
  int totalTaskCount;

  @HiveField(5)
  double efficiency;

  @HiveField(6)
  DateTime date;

  @HiveField(7)
  List<Task> taskList;

  Session({
    this.sessionName = "New Session",
    this.sprints = 0,
    this.completedTaskCount = 0,
    this.totalTaskCount = 0,
    this.efficiency = 0,
    DateTime? date,
    this.taskList = const [],
  })  : sessionId = const Uuid().v1(),
        date = date ?? DateTime.now() {
    // Constructor body (optional additional logic can go here)
  }

  getid(){
    return sessionId;
  }

  calculateefficency(){
    efficiency = completedTaskCount/totalTaskCount;
  }
}