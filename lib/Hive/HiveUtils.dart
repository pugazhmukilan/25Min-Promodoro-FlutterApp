import "package:promodoro/Hive/SessionObject.dart";



double calculateSessionEfficiency(int completed, int intended) {
  if (intended == 0) return 0;
  return completed / intended;
}

double calculateTotalEfficiency(List<PomodoroSession> sessions) {
  if (sessions.isEmpty) return 0;
  final efficiencies = sessions
      .where((s) => s.efficiency != null)
      .map((s) => s.efficiency)
      .toList();
  return efficiencies.reduce((a, b) => a + b) / efficiencies.length;
}
