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
  final response = await http.post(Uri.http(_baseUrl, '/api/patient/show'),
      headers: headers, body: json.encode(userData));

  if (response.statusCode == 200) {
  Map<String, dynamic> res = json.decode(response.body);
     var userId = res['_id'];
    var usermail = res['email'];
    var userPwd = res['password'];
    var firsrname=res['firstname'];
    var lastname=res['lastname'];
    var adresse=res['adresse'];
    var birthday=res['birthday'];
    var phone=res['phone'];
    var GroupeSanguine=res['GroupeSanguine'];
    var situationF=res['situationF'];
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
  final String birthday;
  final String phone;
  final String adresse;
  final String GroupeSanguine;
  final String situationF;
  //final String title;

  const User({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
    required this.birthday,
    required this.phone,
    required this.adresse,
    required this.GroupeSanguine,
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
      
      birthday: json['birthday'],
      phone: json['phone'],
    adresse: json['adresse'],
    GroupeSanguine: json['GroupeSanguine'],
      situationF: json['situationF'],
            // id: json['id'],
      //title: json['title'],
    );
    
  }


}        
void main() => runApp(const showProfileUser());

class showProfileUser extends StatefulWidget {
  const showProfileUser({Key? key}) : super(key: key);
 
  @override
  _showProfileUserState createState() => _showProfileUserState();
}

class _showProfileUserState extends State<showProfileUser> {
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
       resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
       
          elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
             // top:MediaQuery.of(context).size.height*0.45,
              left: 20.0,
              right: 20.0,
              child: Card(
                child: Padding(
                  padding:EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child:Column(
                          children: [
                            Text('Frist Name',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 14.0
                            ),),
                            SizedBox(height: 5.0,),
                            Text("kqsjdksj",
                            style: TextStyle(
                              fontSize: 15.0,
                            ),)
                          ],
                        )
                      ),

                      Container(
                        child: Column(
                        children: [
                          Text('Birthday',
                            style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 14.0
                            ),),
                          SizedBox(height: 5.0,),
                          Text('April 7th',
                            style: TextStyle(
                              fontSize: 15.0,
                            ),)
                        ]),
                      ),

                      Container(
                          child:Column(
                            children: [
                              Text('Age',
                                style: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 14.0
                                ),),
                              SizedBox(height: 5.0,),
                              Text('19 yrs',
                                style: TextStyle(
                                  fontSize: 15.0,
                                ),)
                            ],
                          )
                      ),
                    ],
                  ),
                )
              )
          )
        ],
       
                
              /* snapshot.data!.id,
                snapshot.data!.firstname ,
                snapshot.data!.lastname,
                snapshot.data!.email,
                snapshot.data!.password,
              
                snapshot.data!.phone,
                snapshot.data!.birthday,
                snapshot.data!.adresse,
                snapshot.data!.GroupeSanguine,
                snapshot.data!.situationF,*/
                
              
          
        ),
    );
  }
  
}