import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workshop_sim4/home/changePwd.dart';

import 'package:workshop_sim4/home/home.dart';
import 'package:workshop_sim4/home/showProfile.dart';
import 'package:workshop_sim4/home/updateProfile.dart';
import 'package:workshop_sim4/signin.dart';


class NavigationTab extends StatelessWidget {
  const NavigationTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Interx",style: TextStyle(
    color: Colors.white
  )),
          
          backgroundColor: Colors.greenAccent,
          

          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
             
              Tab(
                
                icon: Icon(Icons.home),
                
                //text: "Mes doses ",
                
              ),
              
            
            ],
          ),
        ),
        drawer: Drawer(
        child: Column(
          children: [
            AppBar(
              title: const Text("Your Menu"),
              automaticallyImplyLeading: false,
              backgroundColor: Color.fromARGB(255, 64, 236, 153),
              
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
                  color: Color.fromARGB(255, 64, 236, 153),
                  ),

                  
                ],
                
              ),
             onTap: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context) => showProfile()));
                   
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
                    color: Color.fromARGB(255, 64, 236, 153),
                  ),
                ],
              ),
              onTap: () {
               Navigator.push(context, MaterialPageRoute(builder: (context) => updateProfile()));
                   
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
                    color: Color.fromARGB(255, 64, 236, 153),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => changePwd()));
                     
              },
            ),
            ListTile(
              title: Row(
                children: const [
                  Icon(Icons.history),
                  SizedBox(
                    width: 20,
                  ),
                  Text("Historique"),
                  SizedBox(
                    width: 139,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Color.fromARGB(255, 64, 236, 153),
                    ),
                ],
              ),
              onTap: () {
               // Navigator.pushNamed(context, "/home/updateUser");
              },
            ),
          
            ListTile(
              title: Row(
                children: const [
                  Icon(Icons.power_settings_new),
                  SizedBox(
                    width: 20,
                  ),
                  Text("Se déconnecter"),
                   SizedBox(
                    width: 105,
                  ),
                   Icon(Icons.arrow_forward_ios,
                   color: Colors.greenAccent),
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
            
            Home()
          ],
        ),
      ),
    );
  }
}
