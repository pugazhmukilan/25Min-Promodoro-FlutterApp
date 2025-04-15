part of 'active_session_bloc.dart';

@immutable
sealed class ActiveSessionState {}

final class ActiveSessionInitial extends ActiveSessionState {}

class SessionActive extends ActiveSessionState{
  final PomodoroSession ActiveSession;
  SessionActive({required this.ActiveSession});
}

class SessionInactive extends ActiveSessionState {}