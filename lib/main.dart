import 'package:flutter/material.dart';
import 'package:workshop_sim4/home/changePwd.dart';
import 'package:workshop_sim4/home/updateProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home/showProfile.dart';
//import 'navigations/nav_bottom.dart';
import 'navigations/nav_tab.dart';
import 'signin.dart';
import 'signup.dart';
import 'home/home.dart';
import 'splash_screen.dart';
import 'package:flutter/material.dart';  

void main() {
  runApp( MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
       title: 'Interx',
     
    ));
   
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

   


  
  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                   Text("Welcome", style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30
                  ),),
                  SizedBox(height: 20,),
                   Text("Automatic identity verification which enables you to verify your identity", 
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 15
                  ),)
                ],
              ),
               Container(
                height: MediaQuery.of(context).size.height / 3,
            
               decoration: BoxDecoration(
                 
                   
                  /* image: DecorationImage(
                    image: Image.asset('assets/illustration.png')
                 )*/
                ),
              ),
              Column(
                children: <Widget>[
                   MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Signin()));
                    },
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.black
                      ),
                      borderRadius: BorderRadius.circular(50)
                    ),
                    child: Text("Login", style: TextStyle(
                      fontWeight: FontWeight.w600, 
                      fontSize: 18
                    ),),
                  ),
                  SizedBox(height: 20,),
                   Container(
                    padding: EdgeInsets.only(top: 3, left: 3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border(
                        bottom: BorderSide(color: Colors.black),
                        top: BorderSide(color: Colors.black),
                        left: BorderSide(color: Colors.black),
                        right: BorderSide(color: Colors.black),
                      )
                    ),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Signup()));
                      },
                      color: Colors.yellow,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)
                      ),
                      child: Text("Sign up", style: TextStyle(
                        fontWeight: FontWeight.w600, 
                        fontSize: 18
                      ),),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
    
    
    
    
  }
}