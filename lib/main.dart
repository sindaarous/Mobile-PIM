import 'package:flutter/material.dart';
import 'package:workshop_sim4/home/changePwd.dart';
import 'package:workshop_sim4/home/updateProfile.dart';
import 'home/showProfile.dart';
//import 'navigations/nav_bottom.dart';
import 'navigations/nav_tab.dart';
import 'signin.dart';
import 'signup.dart';
import 'home/home.dart';
import 'splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Interx',
      routes: {
        "/": (BuildContext context) {
          return const SplashScreen();
        },
        "/singin": (BuildContext context) {
          return const Signin();
        },
        "/signup": (BuildContext context) {
          return const Signup();
        },
        "/home/navTab": (BuildContext context) {
          return const NavigationTab();
        },
        "/home/showProfile": (BuildContext context) {
          return const showProfile();
        },
        "/home/updateProfile": (BuildContext context) {
          return const updateProfile();
        },
        "/home/changePwd": (BuildContext context) {
          return const changePwd();
        },
       /* "/home/biblio": (BuildContext context) {
          return const MyGames();
        },
        "/home/basket": (BuildContext context) {
          return const Basket();
        },
        "/home/updateUser": (BuildContext context) {
          return const UpdateUser();
        }*/
      },
    );
  }
}