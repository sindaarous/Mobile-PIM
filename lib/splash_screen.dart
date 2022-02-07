import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workshop_sim4/signin.dart';

//import 'navigations/nav_bottom.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late String route;
  late Future<bool> fetchedUser;

  Future<bool> fetchUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if(prefs.containsKey("userId")) {
      route = "home";
    }
    else {
      route = "signin";
    }

    return true;
  }

  @override
  void initState() {
    fetchedUser = fetchUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchedUser,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if(snapshot.hasData) {
        
            return const Signin();
          
        }
        else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
