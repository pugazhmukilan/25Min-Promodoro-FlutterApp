import 'package:hive_flutter/hive_flutter.dart';

part "AppState.g.dart";
@HiveType(typeId: 2)
class AppState extends HiveObject {
  @HiveField(0)
  late double totalEfficiency;

  @HiveField(1)
  late int totalSessions;

  @HiveField(2)
  late bool isSessionActive;

  @HiveField(3)
  late String? activeSessionId; // If active, load this session

  // Constructor for initializing AppState
  AppState({
    required this.totalEfficiency,
    required this.totalSessions,
    required this.isSessionActive,
    this.activeSessionId,
  });
}
