import "package:flutter/material.dart";
import "package:promodoro/Constants.dart";
import "../../ColorPallets.dart";
import 'package:numberpicker/numberpicker.dart';
class Createsessionpage extends StatefulWidget {
  const Createsessionpage({super.key});

  @override
  State<Createsessionpage> createState() => _CreatesessionpageState();
}

class _CreatesessionpageState extends State<Createsessionpage> {
  var sprintcount = 1;
  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80,
        leading:GestureDetector(
      onTap: (){Navigator.pop(context);}, // Call the toggle function when tapped`
      child: CircleAvatar(
        
        backgroundColor: const Color(0x1F939393),
        child: Icon(Icons.arrow_back_ios_new,size: 20,)
      ),
    ),

    title: Text("Create Session",style:TextStyle(fontFamily: "Montserrat",fontWeight: FontWeight.w700,color:isDarkTheme? AppColors.blackLight:AppColors.blackDark)),
      ),
    

      body:Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          SizedBox(height: 15,),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
            width: double.infinity,
            height: 150,
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
                    itemHeight: 100,
                    
                    selectedTextStyle: TextStyle(
                      fontFamily: "Montserrat",
                      color: AppColors.white1,
                      fontSize: 80
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
          )
          
       
        ],
      )   
     );
  }
}