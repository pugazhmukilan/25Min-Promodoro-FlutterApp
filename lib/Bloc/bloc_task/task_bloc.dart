import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:promodoro/Hive/AppState.dart';
import 'package:promodoro/Hive/TaskObject.dart';
import 'package:uuid/uuid.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {

  
  TaskBloc() : super(TaskInitial()) {
    on<TaskEventAdd>((event, emit) async{
      // final uuid = Uuid();

      // final newTask = TodoTask(
      //   taskId: uuid.v4(), // unique ID
      //   title: event.title,
      //   isDone: false,
      // );

      // final box = Hive.box<TodoTask>('tasksBox'); // use already opened box

      // await box.put(newTask.taskId, newTask); // store using ID as key
      // print("Task added: ${newTask.title}");


      /*here i am appending the new task to the list of task 
      NOTE: it is not sstored in the hive yet*/
      //add the newtask in the front of the list
      event.tasklist.insert(0, event.title);
      
      emit(TaskUpdated(tasks: event.tasklist));

    });




    on<DeleteTaskEventAdd>((event,emit){
      event.tasklist.remove(event.title);
      emit(TaskUpdated(tasks: event.tasklist));
    });


    on<GetHiveTaskList>((event,emit){
      final box = Hive.box<TodoTask>('tasksBox'); // use already opened box
      List<TodoTask> hivetasks = box.values.toList();
      print(hivetasks);
      
      
      emit(GotHiveTask(tasks: hivetasks.map((task) => task.title).toList()));
    });



    on<DeleteTaskInHive>((event,emit)async{
      final box = Hive.box<TodoTask>('tasksBox'); // use already opened box
      await box.delete(event.title.taskId);
      event.tasklist.remove(event.title);
      emit(TaskDeletedSuccessfully(tasks: event.tasklist));
    });



    on<MakeTaskDone>((event,emit)async{
      //STEP 1: open the tasksbox
      final box = Hive.box<TodoTask>('tasksBox'); // use already opened box
      //STEP 2 : Open the mainapp state box
      final appbox = Hive.box('mainAppStateBox'); // use already opened box
      //STEP 3:If the mainapp state  have  a key totalCompletedTask then increament it by 1
      if(appbox.get("totalCompletedTask") != null){
        appbox.put("totalCompletedTask", appbox.get("totalCompletedTask")+1);
        print(" total complted task already there ${appbox.get("totalCompletedTask")}");
      }else{
      //STEP 4:If the mainapp state dont  have  a key totalCompletedTask then create a totalcompletedtask key assign value 1  
        appbox.put("totalCompletedTask", 1);
        print(" total complted task not there ${appbox.get("totalCompletedTask")}");
      }

      //STEP 5: update the task in the hive as done
      event.donetask.isDone = true;
      await box.put(event.donetask.taskId, event.donetask);
      //STEP 6: get the updated task from the hive and emit it choose only if it not done
       List<TodoTask> updatedhivetasks= [];
      for(TodoTask task in box.values){
        if(task.isDone == false){
          updatedhivetasks.add(task);
        }
      }
      print("length of updatedhivetasks ${updatedhivetasks.length}");
      
      
      emit(TaskUpdatedInHive(tasks:updatedhivetasks));
    });


    on<AddTaskInHive>((event,emit)async{
      //STEP 1: open the tasksbox
      final box = Hive.box<TodoTask>('tasksBox'); // use already opened box
      //STEP 2 : Open the mainapp state box
      final appbox = Hive.box('mainAppStateBox'); // use already opened box
      //STEP 3:If the mainapp state  have  a key totalTask then increament it by 1
      if(appbox.get("totalTask") != null){
        appbox.put("totalTask", appbox.get("totalTask")+1);
        print(" total task already there ${appbox.get("totalTask")}");
      }else{
      //STEP 4:If the mainapp state dont  have  a key totalTask then create a totalTask key assign value 1  
        appbox.put("totalTask", 1);
        print(" total task not there ${appbox.get("totalTask")}");
      }
      Uuid uuid = Uuid();
      TodoTask newTask = TodoTask(
        taskId: uuid.v4(), // unique ID
        title: event.title,
        isDone: false,
      );


      //STEP 5: add the new task in the hive
      await box.put(newTask.taskId, newTask);
      //STEP 6: get the updated task from the hive and emit it
      event.tasklist.insert(0, newTask);
       List<TodoTask> updatedhivetasks= [];
      for(TodoTask task in box.values){
        if(task.isDone == false){
          updatedhivetasks.add(task);
        }
      }
      emit(TaskUpdatedInHive(tasks:updatedhivetasks));
    });
  }
}
