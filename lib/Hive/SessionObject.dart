import 'package:hive_flutter/hive_flutter.dart';


part "SessionObject.g.dart";

@HiveType(typeId: 0)
class PomodoroSession extends HiveObject {
  @HiveField(0)
  late String sessionId;

  @HiveField(1)
  late List<String> taskIds; // IDs from tasksBox

  @HiveField(2)
  late int totalSprints;

  @HiveField(3)
  late int completedSprints;

  @HiveField(4)
  late DateTime startTime;

  @HiveField(5)
  late Duration sessionDuration;

  @HiveField(6)
  late bool isCompleted;

  @HiveField(7)
  late int efficiency;

  @HiveField(8)
  late int totalTaskCount;

  @HiveField(9)
  late int completedTaskCount;

  // Constructor for initializing PomodoroSession
  PomodoroSession({
    required this.sessionId,
    required this.taskIds,
    required this.totalSprints,
    required this.completedSprints,
    required this.startTime,
    required this.sessionDuration,
    required this.isCompleted,
    required this.efficiency,
    required this.totalTaskCount,
    required this.completedTaskCount,
  });
}
