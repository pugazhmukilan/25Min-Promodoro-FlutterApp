part of 'task_bloc.dart';

@immutable
sealed class TaskState {}

final class TaskInitial extends TaskState {}
final class TaskUpdated extends TaskState {
  List<String> tasks;
  TaskUpdated({required this.tasks});

  
}
final class GotHiveTask extends TaskState {
  List<String> tasks;
  GotHiveTask({required this.tasks});

  
}


final class TaskDeletedSuccessfully extends TaskState {
  List<TodoTask> tasks;
  TaskDeletedSuccessfully({required this.tasks});

  
}

final class TaskDoneSuccessfully extends TaskState {
  List<TodoTask> tasks;
  TaskDoneSuccessfully({required this.tasks});

  
}

final class TaskUpdatedInHive extends TaskState {
  List<TodoTask> tasks;
  TaskUpdatedInHive({required this.tasks});

  
}