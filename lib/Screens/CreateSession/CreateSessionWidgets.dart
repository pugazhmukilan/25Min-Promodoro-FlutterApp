import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promodoro/Bloc/bloc_task/task_bloc.dart';
import 'package:promodoro/ColorPallets.dart';

class NewTaskViewTemp extends StatelessWidget {
  const NewTaskViewTemp({
    super.key,
    required this.newtaskslist,
  });

  final List<String> newtaskslist;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: newtaskslist.length,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          margin: EdgeInsets.symmetric(vertical: 4,horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.grey[850],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  newtaskslist[index],
                  style: TextStyle(
                    color: AppColors.white1,
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                
                decoration: BoxDecoration(
                  color: AppColors.violetDark,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
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
                      DeleteTaskEventAdd(title: newtaskslist[index], tasklist: newtaskslist),
                    );
                  },
                ),
              ),
            ],
          ),
        );
    
      },
    );
  }
}
