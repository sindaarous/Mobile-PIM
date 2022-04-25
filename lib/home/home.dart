import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workshop_sim4/acceuil.dart';
import 'package:workshop_sim4/addR.dart';
import 'package:workshop_sim4/body.dart';
import 'package:workshop_sim4/home/updateProfile.dart';
import 'product_info.dart';

Future<User> fetchUser() async {
  String _baseUrl = "localhost:9091";
  Map<String, String> headers = {
    "Content-Type": "application/json; charset=UTF-8"
  };
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Map<String, dynamic> userData = {
    "email": prefs.getString("email"),
  };
  final response = await http.post(Uri.http(_baseUrl, '/api/patient/show'),
      headers: headers, body: json.encode(userData));

  if (response.statusCode == 200) {
    Map<String, dynamic> res = json.decode(response.body);
    var userId = res['_id'];
    var usermail = res['email'];
    var userPwd = res['password'];
    var firsrname = res['firstname'];
    var lastname = res['lastname'];
    var adresse = res['adresse'];
    var birthday = res['birthday'];
    var phone = res['phone'];
    var GroupeSanguine = res['GroupeSanguine'];
    var situationF = res['situationF'];
    print("resultat$userId");
    print("resultat$usermail");
    print("resultat$userPwd");
    print("resultat$firsrname");
    print("resultat$lastname");
    print("resultat$adresse");
    print("resultat$phone");
    print("resultat$GroupeSanguine");
    print("resultat$situationF");
    //print(userId);
    prefs.setString("id", userId);
    prefs.setString("email", usermail);
    prefs.setString("password", userPwd);
    prefs.setString("firstname", firsrname);
    prefs.setString("lastname", lastname);
    prefs.setString("adresse", adresse);
    prefs.setString("birthday", birthday);
    prefs.setString("phone", phone);
    prefs.setString("GroupeSanguine", GroupeSanguine);
    prefs.setString("situationF", situationF);
    return User.fromJson(jsonDecode(response.body), prefs);
  } else {
    throw Exception('Failed to load user');
  }
}

class User {
  final String id;
  final String firstname;
  final String lastname;
  final String email;
  final String password;
  final String adresse;
  final String birthday;
  final String phone;
  final String GroupeSanguine;
  final String situationF;
  //final String title;

  const User({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
    required this.adresse,
    required this.birthday,
    required this.phone,
    required this.GroupeSanguine,
    required this.situationF,
    //required this.title,
  });

  factory User.fromJson(Map<String, dynamic> json, prefs) {
    //prefs.setString("nom": json['nom']);
    return User(
      id: json['_id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      password: json['password'],
      adresse: json['adresse'],
      birthday: json['birthday'],
      phone: json['phone'],
      GroupeSanguine: json['GroupeSanguine'],
      situationF: json['situationF'],
      // id: json['id'],
      //title: json['title'],
    );
  }
}

void main() => runApp(const Home());

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentTab = 0;
  final List<Widget> screens = [Body(), Home()];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Body();
  late String? _email;
  late Future<User> futureUser;
  Future<void> insertSharedPrefs(String id) async {
    await SharedPreferences.getInstance().then((prefs) {
      print("here");
      prefs.setString('email', _email!);
      //prefs.setString('id', id);

      // prefs.setString('email', email)
    });
  }

  @override
  void initState() {
    super.initState();
    futureUser = fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(bucket: bucket, child: currentScreen),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = Body();
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home,
                          color: currentTab == 0 ? Colors.green : Colors.grey,
                        ),
                        Text(
                          'Accueil',
                          style: TextStyle(
                              color:
                                  currentTab == 0 ? Colors.green : Colors.grey),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = Accueil();
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.access_alarms_rounded,
                          color: currentTab == 1 ? Colors.green : Colors.grey,
                        ),
                        Text(
                          'Rendez-vous',
                          style: TextStyle(
                              color:
                                  currentTab == 1 ? Colors.green : Colors.grey),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
