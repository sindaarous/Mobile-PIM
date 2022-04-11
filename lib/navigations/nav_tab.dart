import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workshop_sim4/home/changePwd.dart';
import 'package:workshop_sim4/home/history.dart';

import 'package:workshop_sim4/home/home.dart';
import 'package:workshop_sim4/home/showProfile.dart';
import 'package:workshop_sim4/home/updateProfile.dart';
import 'package:workshop_sim4/services/notification_servics.dart';
import 'package:workshop_sim4/signin.dart';

import '../services/theme_services.dart';

class NavigationTab extends StatelessWidget {
  const NavigationTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var notifyHelper = NotifyHelper();
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          actions: [
            GestureDetector(
              onTap: () {
                ThemeService().switchTheme();

                notifyHelper.scheduledNotification();
              },
              child: Icon(
                  Get.isDarkMode
                      ? Icons.wb_sunny_outlined
                      : Icons.nightlight_round,
                  size: 20,
                  color: Get.isDarkMode ? Colors.white : Colors.black),
            ),
          ],
          title: const Text(
            "Interx",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Color.fromRGBO(29, 170, 63, 1.0),
        ),
        drawer: Drawer(
          child: Column(
            children: [
              AppBar(
                title: const Text("Your Menu"),
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => showProfile()));
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => updateProfile()));
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => changePwd()));
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
                      color: Color.fromRGBO(29, 170, 63, 1.0),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => History()));
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
                        color: Color.fromRGBO(29, 170, 63, 1.0)),
                  ],
                ),
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.clear();

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Signin()));
                },
              )
            ],
          ),
        ),
        body: const TabBarView(
          children: [Home()],
        ),
      ),
    );
  }
}
