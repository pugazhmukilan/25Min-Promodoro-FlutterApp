

import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promodoro/Bloc/bloc_task/task_bloc.dart';
import 'package:promodoro/ColorPallets.dart';
import 'package:promodoro/Hive/TaskObject.dart';
class TaskListView extends StatelessWidget {
  const TaskListView({
    super.key,
    required this.hivetasklist,
  });

  final List<TodoTask> hivetasklist;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: hivetasklist.length,
      itemBuilder: (context, index) {
        final task = hivetasklist[index];
    
        return Container(
          height: 50,
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 5,
          ),
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.grey[850],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  task.title,
                  style: TextStyle(
                    color: AppColors.white1,
                    fontSize: 16,
                  ),
                ),
              ),
              // Custom circular checkbox
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.delete_outline_outlined,
                      color: AppColors.white1,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    onPressed: () {
                      // Handle delete action here
                      // You can remove the task from the list and update the state if needed
                      BlocProvider.of<TaskBloc>(context).add(
                        DeleteTaskInHive(
                          title: hivetasklist[index],
                          tasklist: hivetasklist,
                        ),
                      );
                    },
                  ),
    
                  GestureDetector(
                    onTap: () {
                      // Handle checkbox tap here
                      // You can update the task's completion status if needed
                      BlocProvider.of<TaskBloc>(context).add(MakeTaskDone(donetask: hivetasklist[index]));
                    },
                    child: Container(
                      width: 28, // Adjusted size for better fit
                      height: 28,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            AppColors
                                .blackDark, // Background color of the circle
                        border: Border.all(
                          color: AppColors.white1,
                          width: 3,
                        ), // Border color
                      ),
                      child: Center(
                        child: Icon(
                          Icons.check,
                          color:
                              Colors.greenAccent, // Checkmark color
                          size: 22,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
