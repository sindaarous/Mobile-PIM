import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workshop_sim4/home/showProfile.dart';
import 'package:http/http.dart' as http;
Future<User> fetchUser() async {
  String _baseUrl = "localhost:9091";
  Map<String, String> headers = {
    "Content-Type": "application/json; charset=UTF-8"
  };
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Map<String, dynamic> userData = {
   "": prefs.getString("code"),
  };
 
  final response = await http.post(Uri.http(_baseUrl, '/api/users/show'),
      headers: headers, body: json.encode(userData));

  if (response.statusCode == 200) {
  Map<String, dynamic> res = json.decode(response.body);
    var userId = res['_id'];
   
  prefs.setString("id",userId);
   //print(prefs.getString("id"));
    return User.fromJson(jsonDecode(response.body),prefs);
  } else {
    throw Exception('Failed to load user');
  }
}
class changePwd extends StatefulWidget {
  const changePwd({ Key? key }) : super(key: key);

  @override
  _changePwdState createState() => _changePwdState();
}

class _changePwdState extends State<changePwd> {
  late String? id;
  late String? _nom;
  late String? _prenom;
  late String? _email;
  late String? _password;
   late String? _passwordnew;
    late String? _code;
   late Future<User> futureuser;
       String oldPwd = '';

  

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      oldPwd = (prefs.getString('password') ?? '');
    });
    print("change$oldPwd");
  }
   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
   // futureUser = fetchUser();
     _loadCounter();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Password"),
        // print(_id);
      ),
       body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Email"),
                onSaved: (String? value) {
                  _email = value;
                },
                validator: (String? value) {
                  RegExp regex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                  if(value!.isEmpty || !regex.hasMatch(value)) {
                    return "L'adresse email n'est pas valide !";
                  }
                  else {
                    return null;
                  }
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
              child: TextFormField(
               // maxLines: 4,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Old Password "),
                onSaved: (String? value) {
                  _password = value;
                },
                validator: (String? value) {
                  if(value!.isEmpty ) {
                    return "Code";
                  }
                  else {
                    return null;
                  }
                  },
              ),
            ),
             Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
              child: TextFormField(
               // maxLines: 4,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "New Password "),
                onSaved: (String? value) {
                  _passwordnew = value;
                },
                validator: (String? value) {
                  if(value!.isEmpty ) {
                    return "New Passwprd ";
                  }
                  else {
                    return null;
                  }
                  },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: const Text("Update"),
                  onPressed: () {
                    if(_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();      
                     print("change$oldPwd");              
                    //URL
                    String _baseUrl = "localhost:9091";
                      //Headers
                    Map<String, String> headers = {
                      "Content-Type":"application/json; charset=UTF-8"
                    };
                    //Body
                  // SharedPreferences prefs =  SharedPreferences.getInstance() as SharedPreferences;
                    //print(prefs.getString(id!));
                    Map<String, dynamic> userData = {
                      
                      "email":_email,
                      "oldPwd" : _password,
                      "newpassword":_passwordnew,
                      
                     // "password":_password,
                      //"nom":_nom,
                     // "prenom":_prenom,
                     // "email":_email
                     // "password": _password
                    };
                    //Exec
                    http.post(Uri.http(_baseUrl, '/api/users/changePwd'), headers: headers, body: json.encode(userData))
                    .then((http.Response response)async{

                      if (response.statusCode == 200) {
                           SharedPreferences prefs = await SharedPreferences.getInstance();
                           //prefs.setString("code", userData["code"]);
                            prefs.setString("password", userData["newpassword"]);
                           // prefs.setString("nom", userData["nom"]);
                           // prefs.setString("prenom", userData["prenom"]);
                           // prefs.setString("email", userData["email"]);
                           // print(prefs.getString("password"));
                           /* print(prefs.getString("password"));
                            print(prefs.getString("nom"));
                            print(prefs.getString("prenom"));
                            print(prefs.getString("email"));*/
                        //final myString =prefs.getString("code");
                        
                       
                        Navigator.pushReplacementNamed(context, "/home/navTab");

                      } else if(response.statusCode == 401) {

                        showDialog(context: context, builder: (context) {
                          return AlertDialog(
                            title: Row(
                              children: [
                                Icon(Icons.info),
                                Text('Erreur'),
                              ],
                            ),
                            content: Text('Le code d inscription est invalide '),
                          );
                        });

                      }

                    });
                  
                  }
                }
                ),
                 
          ],

              ),
              ],
            ),
    ),
     
      
    );
  }
}