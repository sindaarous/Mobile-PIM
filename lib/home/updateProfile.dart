import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:workshop_sim4/home/showProfile.dart';
Future<User> fetchUser() async {
  String _baseUrl = "localhost:9091";
  Map<String, String> headers = {
    "Content-Type": "application/json; charset=UTF-8"
  };
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Map<String, dynamic> userData = {
     "email": prefs.getString("email"),
     
  };
 print("id$userData");
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
//  prefs.setString("id",userId);
   //print(prefs.getString("id"));
    return User.fromJson(jsonDecode(response.body),prefs);
  } else {
    throw Exception('Failed to load user');
  }
}

class updateProfile extends StatefulWidget {
  const updateProfile({Key? key}) : super(key: key);

  @override
  State<updateProfile> createState() => _updateProfileState();
}

class _updateProfileState extends State<updateProfile> {
  late String? id;
  late String? _firstname;
  late String? _lastname;
  late String? _email;
  late String? _password;
  late String? _age;
  late String? _birthday;
  late String? _phone;
  late String? _gender;
  late String? _situationF;


       late Future<User> futureUser;
       String _id = '';
String password = '';
  

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _id = (prefs.getString('id') ?? '');
      password=(prefs.getString('passwrod')??'');

    });
    print("update$_id");
  }
  
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    futureUser = fetchUser();
     _loadCounter();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Profile"),
      ),
       body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "First Name"),
                onSaved: (String? value) {
                  _firstname = value;
                },
                validator: (String? value) {
                  if (value!.isEmpty || value.length < 3) {
                    return "Le Username doit avoir au moins 3 caractères !";
                  } else {
                    return null;
                  }
                },
              ),
            ),
             Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Last Name"),
                onSaved: (String? value) {
                  _lastname = value;
                },
                validator: (String? value) {
                  if (value!.isEmpty || value.length < 3) {
                    return "Le Username doit avoir au moins 3 caractères !";
                  } else {
                    return null;
                  }
                },
              ),
            ),
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
                  RegExp regex = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                  if (value!.isEmpty || !regex.hasMatch(value)) {
                    return "L'adresse email n'est pas valide !";
                  } else {
                    return null;
                  }
                },
              ),
            ),
             Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Age "),
                onSaved: (String? value) {
                  _age = value;
                },
                validator: (String? value) {
                  if (value!.isEmpty || value.length > 3) {
                    return "Le Username doit avoir au moins 3 caractères !";
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Birthday "),
                onSaved: (String? value) {
                  _birthday = value;
                },
                validator: (String? value) {
                  if (value!.isEmpty || value.length < 3) {
                    return "Le Username doit avoir au moins 3 caractères !";
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "phone "),
                onSaved: (String? value) {
                  _phone = value;
                },
                validator: (String? value) {
                  if (value!.isEmpty || value.length < 3) {
                    return "Le Username doit avoir au moins 3 caractères !";
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "gender "),
                onSaved: (String? value) {
                  _gender = value;
                },
                validator: (String? value) {
                  if (value!.isEmpty || value.length < 3) {
                    return "Le Username doit avoir au moins 3 caractères !";
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "situation  "),
                onSaved: (String? value) {
                  _situationF = value;
                },
                validator: (String? value) {
                  if (value!.isEmpty || value.length < 3) {
                    return "Le Username doit avoir au moins 3 caractères !";
                  } else {
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
                     print("form$_id");              
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
                          "_id":_id,
                          "firstname": _firstname,
                          "lastname": _lastname,
                          "email": _email,
                          "age": _age,
                          "birthday": _birthday,
                          "phone": _phone,
                          "gender": _gender,
                          "situationF": _situationF
                    };
                    //Exec
                    http.post(Uri.http(_baseUrl, '/api/users/update'), headers: headers, body: json.encode(userData))
                    .then((http.Response response)async{

                      if (response.statusCode == 200) {
                           SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setString("email", userData["email"]);
                            prefs.setString("password", password);
                            prefs.setString("firstname", userData["firstname"]);
                            prefs.setString("lastname", userData["lastname"]);
                            prefs.setString("age", userData["age"]);
                            prefs.setString("birthday", userData["birthday"]);
                            prefs.setString("phone", userData["phone"]);
                            prefs.setString("gender", userData["gender"]);
                            prefs.setString(
                                "situationF", userData["situationF"]);
                        
                       
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