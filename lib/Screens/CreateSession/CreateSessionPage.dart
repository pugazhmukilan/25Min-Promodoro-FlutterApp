import "package:flutter/material.dart";
import "../../ColorPallets.dart";
class Createsessionpage extends StatefulWidget {
  const Createsessionpage({super.key});

  @override
  State<Createsessionpage> createState() => _CreatesessionpageState();
}

class _CreatesessionpageState extends State<Createsessionpage> {
  
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
      )
    );
  }
}