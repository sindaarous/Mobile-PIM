import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:workshop_sim4/home/home.dart';


class NavigationTab extends StatelessWidget {
  const NavigationTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Interx"),
          bottom: const TabBar(
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
              title: const Text("Interx"),
              automaticallyImplyLeading: false,
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
                  Icon(Icons.arrow_forward_ios),
                  
                ],
                
              ),
             onTap: () {
                Navigator.pushNamed(context, "/home/showProfile");
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
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
              onTap: () {
                Navigator.pushNamed(context, "/home/updateProfile");
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
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
              onTap: () {
                Navigator.pushNamed(context, "/home/changePwd");
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
                  Icon(Icons.arrow_forward_ios),
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
                   Icon(Icons.arrow_forward_ios),
                ],
              ),
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove("code");
                final myString =prefs.getString("code");
                  
              print(myString);
                Navigator.pushReplacementNamed(context, "/singin");
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
