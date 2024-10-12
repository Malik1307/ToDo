import 'package:flutter/material.dart';
import 'package:to_do/color.dart';

class About_App extends StatelessWidget {
  const About_App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: c,),
      
body: Container(
  height: double.infinity,
  width: double.infinity,
  color: b,

  child: SingleChildScrollView(
    child: Column(children: [
      SizedBox(height: 30,),
    
    Text("Fininshed at 7/19/2024",style: TextStyle(fontSize: 30,color: Colors.teal),)
    ,SizedBox(height:10),
    Text("By Malik",style: TextStyle(fontSize: 35,fontWeight: FontWeight.w500),) 
    ,SizedBox(height: 50,)
    ,Text(": الحالة",style: TextStyle(fontSize: 50),),
    Container(height: 400,width: double.infinity,child: Image.asset("assets/IMG20240626212554.jpg",fit: BoxFit.cover,))
    
    
    
    ],),
  ),
),

    );
  }
}
