part of 'timer_bloc.dart';

@immutable
sealed class TimerState {}

final class TimerInitial extends TimerState {}

final class TimerRunInProgress extends TimerState{
  
}