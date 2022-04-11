import 'package:flutter/material.dart';
import 'package:workshop_sim4/GooleMappps.dart';
import 'package:workshop_sim4/body.dart';

class AccueilUser extends StatefulWidget {
  @override
  _AccueilUserState createState() => _AccueilUserState();
}

class _AccueilUserState extends State<AccueilUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    
      body: SafeArea(
        child: Container(
           child: Column(
             children: <Widget>[

                Text(
                    "Welcome User ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
             ]
     
           )
      )
      )
      
    );
  }
}
