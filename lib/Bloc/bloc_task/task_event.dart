part of 'task_bloc.dart';

@immutable
sealed class TaskEvent {}
final class TaskEventAdd extends TaskEvent {
  
  final String title;
  List<String> tasklist;

  TaskEventAdd({ 
    required this.title,   
   required this.tasklist
  });
}
final class DeleteTaskEventAdd extends TaskEvent {
  final String title;
  List<String> tasklist;
  DeleteTaskEventAdd({ 
    required this.title,   
    required this.tasklist
   
  });
}

final class GetHiveTaskList extends TaskEvent {
  GetHiveTaskList();
}


final class DeleteTaskInHive extends TaskEvent {
  final TodoTask title;
  List<TodoTask> tasklist;
  DeleteTaskInHive({ 
    required this.title, 
    required this.tasklist  
  });
}

final class MakeTaskDone extends TaskEvent {
  final TodoTask donetask;
  
  MakeTaskDone({ 
    required this.donetask, 
    
  });
}

final class AddTaskInHive extends TaskEvent {
  final String title;
  List<TodoTask> tasklist;
  AddTaskInHive({ 
    required this.title, 
    required this.tasklist  
  });
}