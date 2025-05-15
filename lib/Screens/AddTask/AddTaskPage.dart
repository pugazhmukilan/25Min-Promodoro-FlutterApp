import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:hive_flutter/hive_flutter.dart";
import "package:promodoro/Bloc/bloc_task/task_bloc.dart";
import "package:promodoro/Constants.dart";
import "package:promodoro/Hive/TaskObject.dart";
import "package:promodoro/Screens/AddTask/AddTaskPageWidget.dart";
import "package:uuid/uuid.dart";
import "../../ColorPallets.dart";
import 'package:numberpicker/numberpicker.dart';

class Addtaskpage extends StatefulWidget {
  const Addtaskpage({super.key});

  @override
  State<Addtaskpage> createState() => _AddtaskpageState();
}

class _AddtaskpageState extends State<Addtaskpage> {
  var sprintcount = 1;
  TextEditingController newtask = TextEditingController();
  List<TodoTask> hivetasklist = [];

  @override
  void initState() {
    super.initState();
    final box = Hive.box<TodoTask>('tasksBox'); // use already opened box
    hivetasklist = box.values.where((task) => !task.isDone).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          // Call the toggle function when tapped`
          child: CircleAvatar(
            backgroundColor: const Color(0x1F939393),
            child: Icon(Icons.arrow_back_ios_new, size: 20),
          ),
        ),

        title: Text(
          "Add Task",
          style: TextStyle(
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w700,
            color: isDarkTheme ? AppColors.blackLight : AppColors.blackDark,
          ),
        ),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 20),
            child: Text(
              "AddTask",
              style: TextStyle(
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: AppColors.blackLight,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: TextField(
              controller: newtask,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(Icons.add, color: AppColors.blackLight),
                  onPressed: () {
                    // Your action goes here

                    final text = newtask.text;
                    if (text.isNotEmpty) {
                      //call bloc event

                      BlocProvider.of<TaskBloc>(
                        context,
                      ).add(AddTaskInHive(title: text, tasklist: hivetasklist));

                      print("Task added: $text");
                      newtask.clear();
                    }
                  },
                ),

                hintText: "Enter New Task",

                hintStyle: TextStyle(
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  color: AppColors.blackLight,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppColors.white2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppColors.blackLight),
                ),
              ),
            ),
          ),

          Container(
            height: 200,
            child: BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) {
                if(state is TaskUpdatedInHive) {
                  if(state.tasks.isEmpty) {
                    return Center(
                      child: Text(
                        "No tasks available",
                        style: TextStyle(
                          color: AppColors.blackLight,
                          fontSize: 16,
                        ),
                      ),
                    );
                  } 
                  hivetasklist = state.tasks;
                
                return TaskListView(hivetasklist: hivetasklist);
                }
                return TaskListView(hivetasklist: hivetasklist);
              },
            ),
          ),
        ],
      ),
    );
  }
}

