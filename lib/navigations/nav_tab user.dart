import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workshop_sim4/home/changePwd.dart';
import 'package:workshop_sim4/home/changePwduser.dart';
import 'package:workshop_sim4/home/history.dart';

import 'package:workshop_sim4/home/home.dart';
import 'package:workshop_sim4/home/homeuser.dart';
import 'package:workshop_sim4/home/showProfile.dart';
import 'package:workshop_sim4/home/showProfileuser.dart';
import 'package:workshop_sim4/home/updateProfile.dart';
import 'package:workshop_sim4/home/updateProfileuser.dart';
import 'package:workshop_sim4/signin.dart';


class NavigationTabUser extends StatelessWidget {
  const NavigationTabUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Interx",style: TextStyle(
    color: Colors.white
  )),
          
          backgroundColor: Color.fromRGBO(29, 170, 63, 1.0),
          

          
        ),
        drawer: Drawer(
        child: Column(
          children: [
            AppBar(
              title: const Text("Your user Menu"),
              automaticallyImplyLeading: false,
              backgroundColor: Color.fromRGBO(29, 170, 63, 1.0),
              
            ),
            ListTile(
              title: Row(
                children: const [
                  Icon(Icons.portrait_sharp),
                  SizedBox(
                    width: 20,
                  ),
                  Text("Show Profile"),
                 SizedBox(
                    width: 125,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                  color: Color.fromRGBO(29, 170, 63, 1.0),
                  ),

                  
                ],
                
              ),
             onTap: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context) => showProfileUser()));
                   
              },
            ),
            ListTile(
              title: Row(
                children: const [
                  Icon(Icons.person_outlined),
                  SizedBox(
                    width: 20,
                  ),
                  Text("Update Profile"),
                   SizedBox(
                    width: 114,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Color.fromRGBO(29, 170, 63, 1.0),
                  ),
                ],
              ),
              onTap: () {
               Navigator.push(context, MaterialPageRoute(builder: (context) => updateProfileUser()));
                   
              },
            ),
            ListTile(
              title: Row(
                children: const [
                  Icon(Icons.password_rounded),
                  SizedBox(
                    width: 20,
                  ),
                  Text("Change Password"),
                 SizedBox(
                    width: 90,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Color.fromRGBO(29, 170, 63, 1.0),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => changePwdUser()));
                     
              },
            ),
            ListTile(
              title: Row(
                children: const [
                  Icon(Icons.power_settings_new),
                  SizedBox(
                    width: 20,
                  ),
                  Text("Se d??connecter"),
                   SizedBox(
                    width: 105,
                  ),
                   Icon(Icons.arrow_forward_ios,
                   color: Color.fromRGBO(29, 170, 63, 1.0)),
                ],
              ),
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.clear();
                
                  
              
                Navigator.push(context, MaterialPageRoute(builder: (context) => Signin()));
                     
              },
            )

          ],
        ),
      ),
        body: const TabBarView(
          
          children: [
            
            HomeUser()
          ],
        ),
      ),
    );
  }
}
