import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promodoro/ColorPallets.dart';
import 'package:promodoro/Screens/CreateSession/CreateSessionPage.dart';
import 'package:promodoro/Screens/Homepage/ThemeIcon.dart';
import "../../Constants.dart";
import '../bloc/timer_bloc.dart';
import "ChartWidget.dart";

class Homepage extends StatefulWidget {
  const Homepage({super.key, required this.toggleTheme});

  final VoidCallback toggleTheme; // Callback to toggle theme

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: Image.asset(isDarkTheme? "assets/logos/Logo_Dark.png":"assets/logos/Logo_Light.png",scale:4),
        actions: [
          
          ThemeIcon(
            onToggle: widget.toggleTheme, // Pass the toggle function to ThemeIcon
          ),
         
        ],
        
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height:100.00,
              decoration: BoxDecoration(
                color: AppColors.violetDark,
                borderRadius: BorderRadius.circular(GlobalBorderRadius),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20),
                child: const CurrentSessionWidget(),
              ),
            ),

            Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(GlobalBorderRadius),
              color:isDarkTheme?AppColors.blackLight: AppColors.white2,
            ),
            height:173,
           
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(GlobalBorderRadius),
                    color: AppColors.orangeDark,
                  ),
                  width: 200,
                  
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      
                      mainAxisAlignment: MainAxisAlignment.center, // Align children to the top
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center, // Align text on baseline
                          
                          children: [
                            Text(
                              "100",
                              style: TextStyle(
                                height:1,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w700,
                                fontSize: 80,
                                color: AppColors.white1,
                              ),
                            ),
                            Text(
                              "%",
                              
                              style: TextStyle(
                                height:1,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w700,
                                fontSize: 30,
                                color: AppColors.white1,
                              ),
                            ),
                          ],
                        ),
                        
                        Text(
                          "Efficency",
                          style: TextStyle(
                            height: 1,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color:AppColors.white1,
                          ),
                          textAlign: TextAlign.center, // Optional: Center the text
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    
                    children: [
                      Text("Out of",softWrap:false,style: TextStyle(height:1,fontFamily:  "Montserrat",fontWeight: FontWeight.w500,color:isDarkTheme? AppColors.white1:AppColors.blackDark,fontSize :15),),
                      
                      Text("32",style: TextStyle(height:1,fontFamily: "Montserrat",fontWeight: FontWeight.w700,color:isDarkTheme? AppColors.white1:AppColors.blackDark,fontSize :60),),
                      Text("Sessions",style: TextStyle(height:1,fontFamily: "Montserrat",fontWeight: FontWeight.w500,color:isDarkTheme? AppColors.white1:AppColors.blackDark,fontSize :15),),
                    ],
                  ),
                ),



                
                
              ],
            ),
          ),


          //GRAPH
          Expanded(
              child: SessionGraph(efficiencies: [80, 65, 70, 90, 30, 85, 60, 55, 95, 88]),
          ),

           Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(GlobalBorderRadius),
              color:isDarkTheme?AppColors.blackLight: AppColors.white2,
            ),
            height:173,
           
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    
                    children: [
                      IconButton(onPressed: (){}, icon: Icon(Icons.add),iconSize: 50,),
                      Text("Add/View\nTask",textAlign: TextAlign.center ,style:TextStyle(fontFamily: "Montserrat",fontWeight: FontWeight.w700,
                                                                                fontSize: 16,color:isDarkTheme? AppColors.white1: AppColors.blackLight)),
                    ],
                  ),
                ),

                GestureDetector(
                  onTap: (){Navigator.push(context,MaterialPageRoute(builder: (context)=>Createsessionpage()));},
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(GlobalBorderRadius),
                      color: AppColors.orangeDark,
                    ),
                    width: 200,
                    
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        
                        mainAxisAlignment: MainAxisAlignment.center, // Align children to the top
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Create",style:TextStyle(fontFamily: "Montserrat",fontWeight: FontWeight.w700,fontSize: 25,color:AppColors.white1)),
                          Text("Session",style:TextStyle(fontFamily: "Montserrat",fontWeight: FontWeight.w700,fontSize: 25,color:AppColors.white1)),
                        ]
                      ),
                    ),
                  ),
                ),



                
                
              ],
            ),
          ),

          

           
         
          ],
        ),
      );
    
  }
}

class CurrentSessionWidget extends StatefulWidget {
  const CurrentSessionWidget({super.key});

  @override
  State<CurrentSessionWidget> createState() => _CurrentSessionWidgetState();
}

class _CurrentSessionWidgetState extends State<CurrentSessionWidget> {
  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return BlocBuilder<TimerBloc, TimerState>(
      builder: (context, state) {
        String timeText = '00:00';
        if (state is TimerRunInProgress) {
          // final minutes = (state.duration ~/ 60).toString().padLeft(2, '0');
          // final seconds = (state.duration % 60).toString().padLeft(2, '0');
          timeText = "Running";
        }

        return Row(
          
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Current\nSession",
              style: TextStyle(
                fontFamily: "Montserrat",
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 30,
              ),
            ),
            Container(
              
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(timeText,style: TextStyle(height:1,fontFamily: "Montserrat",color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold ),),
                  Text("Min Left",style: TextStyle(height:1,fontFamily: "Montserrat",fontSize: 10,color:Colors.white,fontWeight: FontWeight.w700),),
                  Text("sprint 1",style: TextStyle(height:1,fontFamily: "Montserrat",fontWeight: FontWeight.bold,color: AppColors.violetLight,fontSize: 20),)
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}