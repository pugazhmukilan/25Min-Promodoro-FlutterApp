import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:hive_flutter/hive_flutter.dart";
import "package:promodoro/Bloc/bloc_task/task_bloc.dart";
import "package:promodoro/Constants.dart";
import "package:promodoro/Hive/TaskObject.dart";
import "package:promodoro/Screens/CreateSession/CreateSessionWidgets.dart";
import "package:uuid/uuid.dart";
import "../../ColorPallets.dart";
import 'package:numberpicker/numberpicker.dart';
class Createsessionpage extends StatefulWidget {
  const Createsessionpage({super.key});

  @override
  State<Createsessionpage> createState() => _CreatesessionpageState();
}

class _CreatesessionpageState extends State<Createsessionpage> {
  var sprintcount = 1;
  TextEditingController newtask = TextEditingController();
  List<TodoTask> hivetasklist = [];
  List<String> newtaskslist = [];
  List<TodoTask> finalselectedtask = [];
  List<bool> isCheckedList = [];

  @override
  void initState() {

    super.initState();
    final box = Hive.box<TodoTask>('tasksBox'); // use already opened box
    hivetasklist = box.values.where((task) => !task.isDone).toList();
    isCheckedList = List<bool>.filled(hivetasklist.length, false);
    
  }

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80,
        leading:GestureDetector(
      onTap: (){Navigator.pop(context);},
       // Call the toggle function when tapped`
      child: CircleAvatar(
        
        backgroundColor: const Color(0x1F939393),
        child: Icon(Icons.arrow_back_ios_new,size: 20,)
      ),
    ),

    title: Text("Create Session",style:TextStyle(fontFamily: "Montserrat",fontWeight: FontWeight.w700,color:isDarkTheme? AppColors.blackLight:AppColors.blackDark)),
      ),


    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    floatingActionButton: Padding(
      padding: const EdgeInsets.only(bottom: 20.0), // bottom margin
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        decoration: BoxDecoration(
          color: AppColors.greenDark,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          "Start",
          style: TextStyle(
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w700,
            color: AppColors.blackDark,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ),
    

     
    

      body:SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
        
          children: [
            SizedBox(height: 15,),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(color:AppColors.orangeDark,
                                    borderRadius: BorderRadius.circular(GlobalBorderRadius)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  
                  Text("Sprint Count",style: TextStyle(fontFamily: "Montserrat",fontWeight: FontWeight.w700,fontSize: 15)),
                  NumberPicker(
                      value: sprintcount,
                      minValue: 1,
                      maxValue: 9,
                      axis: Axis.horizontal,
                      itemHeight: 70,
                      
                      selectedTextStyle: TextStyle(
                        fontFamily: "Montserrat",
                        color: AppColors.white1,
                        fontSize: 60
                        ,
                        fontWeight: FontWeight.bold,
                      ),
                      textStyle: TextStyle(
                        fontFamily: "Montserrat",
                        color: AppColors.orangeLight,
                        fontWeight: FontWeight.w700,
                        fontSize: 50,
                      ),
                      onChanged: (value) => setState(() => sprintcount = value),
                    ),
        
                    
                ],
              ),
            ),
        
            Padding(
              padding: const EdgeInsets.only(left: 10,top:20),
              child: Text("AddTask",style: TextStyle(fontFamily: "Montserrat",fontWeight: FontWeight.w500,fontSize: 20,color: AppColors.blackLight)),
            ),
            
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal:10),
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
        
                          BlocProvider.of<TaskBloc>(context).add(TaskEventAdd(title: text,tasklist: newtaskslist));
                          
                          print("Task added: $text");
                          newtask.clear();
                        }
                      },
                    ),
                  
                  hintText: "Enter New Task",
                  
                  hintStyle: TextStyle(fontFamily: "Montserrat",fontWeight: FontWeight.w400,fontSize: 15,color: AppColors.blackLight),
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
        
            //createa  list view builder listening to the bloc state and displaying the tasks
            
            BlocBuilder<TaskBloc, TaskState>(
              
              builder: (context, state) {
                if (state is TaskUpdated) {
                  newtaskslist = state.tasks.toList();
                  if(newtaskslist.isNotEmpty){
                    return Container(
                      height:180,
                      child: NewTaskViewTemp(newtaskslist: newtaskslist),
                    );
                  }
                  
                }
                return Container(
                  child: Center(
                    child: Text("No tasks added yet",style: TextStyle(fontFamily: "Montserrat",fontWeight: FontWeight.w700,fontSize: 15,color: AppColors.white2),),
                  ),
                ); // Return an empty container if no tasks are present
              },
            ),
        
        
            //LISTING  UNFINSHED TASKS FROM HIVE
          Padding(
              padding: const EdgeInsets.only(left: 10,top:20),
              child: Text("Select from TaskList",style: TextStyle(fontFamily: "Montserrat",fontWeight: FontWeight.w500,fontSize: 20,color: AppColors.blackLight)),
          ),
            


       


        Container(
        height: 200,
        child: ListView.builder(
          itemCount: hivetasklist.length,
          itemBuilder: (context, index) {
            final task = hivetasklist[index];
            final isChecked = isCheckedList[index];

            return Container(
              height:50,
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
                      task.title,
                      style: TextStyle(
                        color: AppColors.white1,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  // Custom circular checkbox
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isCheckedList[index] = !isCheckedList[index];
                        if (isCheckedList[index]) {
                          finalselectedtask.add(hivetasklist[index]);
                          for( TodoTask task in finalselectedtask){
                            print(task.title);
                          }
                        } else {
                          finalselectedtask.remove(hivetasklist[index]);
                           for( TodoTask task in finalselectedtask){
                            print(task.title);
                          }
                        }
                      });
                    },
                    child: Container(
                      width: 28, // Adjusted size for better fit
                      height: 28,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.blackDark, // Background color of the circle
                        border: Border.all(color: isChecked? AppColors.greenDark: AppColors.white1, width: 3), // Border color
                      ),
                      child: Center(
                        child: isChecked
                            ? Icon(
                                Icons.check,
                                color: Colors.greenAccent, // Checkmark color
                                size: 22,
                                
                              )
                            : Container(
                                width: 14,
                                height: 14,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: AppColors.blackDark, width: 2), // Unchecked circle
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),

        
        
        
         
          ],
        ),
      )   
     );
  }
}
