part of 'active_session_bloc.dart';

@immutable
sealed class ActiveSessionEvent {}


class checkSessionStatus extends ActiveSessionEvent{}

class StartSessionEvent extends ActiveSessionEvent {
  

}