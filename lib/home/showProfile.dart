import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:workshop_sim4/home/product_info.dart';

Future<User> fetchUser() async {
  String _baseUrl = "localhost:9091";
  Map<String, String> headers = {
    "Content-Type": "application/json; charset=UTF-8"
  };
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Map<String, dynamic> userData = {
    "email": prefs.getString("email"),
  };
  final response = await http.post(Uri.http(_baseUrl, '/api/users/show'),
      headers: headers, body: json.encode(userData));

  if (response.statusCode == 200) {
  Map<String, dynamic> res = json.decode(response.body);
     var userId = res['_id'];
    var usermail = res['email'];
    var userPwd = res['password'];
    var firsrname=res['firstname'];
    var lastname=res['lastname'];
    var age=res['age'];
    var birthday=res['birthday'];
    var phone=res['phone'];
    var gender=res['gender'];
    var situationF=res['situationF'];
    //print(userId);
    prefs.setString("id", userId);
    prefs.setString("email", usermail);
    prefs.setString("password", userPwd);
    prefs.setString("firstname", firsrname);
    prefs.setString("lastname", lastname);
    prefs.setString("age", age);
    prefs.setString("birthday", birthday);
    prefs.setString("phone", phone);
    prefs.setString("gender", gender);
    prefs.setString("situationF", situationF);
   
    print(userId);
  // prefs.setString("id",userId);
    return User.fromJson(jsonDecode(response.body),prefs);
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
  final String age;
  final String birthday;
  final String phone;
  final String gender;
  final String situationF;
  //final String title;

  const User({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
    required this.age,
    required this.birthday,
    required this.phone,
    required this.gender,
    required this.situationF,
    //required this.title,
  });

factory User.fromJson(Map<String, dynamic> json,prefs) {
    //prefs.setString("nom": json['nom']);
    return User(
      id: json['_id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      password: json['password'],
      age: json['age'],
      birthday: json['birthday'],
      phone: json['phone'],
      gender: json['gender'],
      situationF: json['situationF'],
            // id: json['id'],
      //title: json['title'],
    );
    
  }
}        
void main() => runApp(const showProfile());

class showProfile extends StatefulWidget {
  const showProfile({Key? key}) : super(key: key);
 
  @override
  _showProfileState createState() => _showProfileState();
}

class _showProfileState extends State<showProfile> {
   late String? nom;
   String userid = '';
  late Future<User> futureUser;
  

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userid = (prefs.getString('id') ?? '');
    });
  }

//prefs.setString("id",userId);
  @override
  void initState() {
    super.initState();
    futureUser = fetchUser();
     _loadCounter();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Show Profile"),
      ),
      body: Center(
        child: FutureBuilder<User>(
          future: futureUser,
          builder: (context, snapshot) {
            print(userid);
            if (snapshot.hasData) {
              return ProductInfo(
               snapshot.data!.id,
                snapshot.data!.firstname ,
                snapshot.data!.lastname,
                snapshot.data!.email,
                snapshot.data!.password,
                snapshot.data!.age,
                snapshot.data!.phone,
                snapshot.data!.birthday,
                snapshot.data!.gender,
                snapshot.data!.situationF,
                
              );
             
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

              // By default, show a loading spinner.
            return const CircularProgressIndicator();
            },
          ),
        ),
    );
  }
  
}