import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:workshop_sim4/home/showProfile.dart';
import 'package:workshop_sim4/navigations/nav_tab%20user.dart';

import '../navigations/nav_tab.dart';

/*Future<User> fetchUser() async {
  String _baseUrl = "localhost:9091";
  Map<String, String> headers = {
    "Content-Type": "application/json; charset=UTF-8"
  };
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Map<String, dynamic> userData = {
    "email": prefs.getString("email"),
  };
  print("id$userData");
 /* final response = await http.post(Uri.http(_baseUrl, '/api/users/show'),
      headers: headers, body: json.encode(userData));
  if (response.statusCode == 200) {
    Map<String, dynamic> res = json.decode(response.body);
    var userId = res['_id'];
    var usermail = res['email'];
    var userPwd = res['password'];
    var firsrname = res['firstname'];
    var lastname = res['lastname'];
    var age = res['age'];
    var gender = res['gender'];
    var phone = res['phone'];
    var situationF = res['situationF'];
    //print(userId);
    prefs.setString("id", userId);
    prefs.setString("email", usermail);
    prefs.setString("password", userPwd);
    prefs.setString("firstname", firsrname);
    prefs.setString("lastname", lastname);
    prefs.setString("age", age);
    prefs.setString("gender", gender);
    prefs.setString("phone", phone);
    prefs.setString("situationF", situationF);
//  prefs.setString("id",userId);
    //print(prefs.getString("id"));
    return User.fromJson(jsonDecode(response.body), prefs);
  } else {
    throw Exception('Failed to load user');
  }*/
}*/

class updateProfileUser extends StatefulWidget {
  const updateProfileUser({Key? key}) : super(key: key);

  @override
  State<updateProfileUser> createState() => _updateProfileUserState();
}

class _updateProfileUserState extends State<updateProfileUser> {
  late String? id;
  late String? _firstname;
  late String? _lastname;
  late String? _email;
  late String? _password;
  late String? _age;
  late String? _gender;
  late String? _phone;
  late String? _situationF;

  late Future<User> futureUser;
  String _id = '';
  String password = '';
  //final items = ['O-', 'O+', 'A-', 'A+', 'B-', 'B+', 'AB-', 'AB+'];

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _id = (prefs.getString('id') ?? '');
      password = (prefs.getString('passwrod') ?? '');
      _email = (prefs.getString('email'));
      _firstname = (prefs.getString('firstname'));
      _lastname = (prefs.getString('lastname'));
      _age = (prefs.getString('age'));
      _gender = (prefs.getString('gender'));
      _phone = (prefs.getString('phone'));
      _situationF = (prefs.getString('situationF'));
    });
    print("update$_id");
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
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Container(
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 40),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(children: <Widget>[
                        Text(
                          "Update Profile",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                      ])
                    ])),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: TextFormField(
                cursorColor: Colors.black,
                style: TextStyle(color: Colors.black),
                initialValue: _firstname,
                decoration: InputDecoration(
                    border: new OutlineInputBorder(
                      borderSide: new BorderSide(
                        color: Color.fromRGBO(29, 170, 63, 1.0),
                      ),
                    ),
                    prefixIcon: const Icon(
                      Icons.text_fields,
                      color: Colors.black,
                    ),
                    labelStyle: TextStyle(color: Colors.black),
                    // border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromRGBO(29, 170, 63, 1.0))),
                    labelText: "First Name"),
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
                cursorColor: Colors.black,
                style: TextStyle(color: Colors.black),
                initialValue: _lastname,
                decoration: InputDecoration(
                    border: new OutlineInputBorder(
                      borderSide: new BorderSide(
                        color: Color.fromRGBO(29, 170, 63, 1.0),
                      ),
                    ),
                    prefixIcon: const Icon(
                      Icons.text_fields,
                      color: Colors.black,
                    ),
                    labelStyle: TextStyle(color: Colors.black),
                    // border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromRGBO(29, 170, 63, 1.0))),
                    labelText: "Last Name "),
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
                cursorColor: Colors.black,
                style: TextStyle(color: Colors.black),
                initialValue: _email,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    border: new OutlineInputBorder(
                      borderSide: new BorderSide(
                        color: Color.fromRGBO(29, 170, 63, 1.0),
                      ),
                    ),
                    prefixIcon: const Icon(
                      Icons.alternate_email,
                      color: Colors.black,
                    ),
                    labelStyle: TextStyle(color: Colors.black),
                    // border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromRGBO(29, 170, 63, 1.0))),
                    labelText: "Email"),
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
                cursorColor: Colors.black,
                style: TextStyle(color: Colors.black),
                initialValue: _age,
                decoration: InputDecoration(
                    border: new OutlineInputBorder(
                      borderSide: new BorderSide(
                        color: Color.fromRGBO(29, 170, 63, 1.0),
                      ),
                    ),
                    prefixIcon: const Icon(
                      Icons.person_pin_circle,
                      color: Colors.black,
                    ),
                    labelStyle: TextStyle(color: Colors.black),
                    // border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromRGBO(29, 170, 63, 1.0))),
                    labelText: "age"),
                onSaved: (String? value) {
                  _age = value;
                },
                validator: (String? value) {
                  /* if (value!.isEmpty || value.length > 3) {
                    return "Le Username doit avoir au moins 3 caractères !";
                  } else {
                    return null;
                  }*/
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: TextFormField(
                cursorColor: Colors.black,
                style: TextStyle(color: Colors.black),
                initialValue: _gender,
                decoration: InputDecoration(
                    border: new OutlineInputBorder(
                      borderSide: new BorderSide(
                        color: Color.fromRGBO(29, 170, 63, 1.0),
                      ),
                    ),
                    prefixIcon: const Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.black,
                    ),
                    labelStyle: TextStyle(color: Colors.black),
                    // border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromRGBO(29, 170, 63, 1.0))),
                    labelText: "gender"),
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
                cursorColor: Colors.black,
                style: TextStyle(color: Colors.black),
                initialValue: _phone,
                decoration: InputDecoration(
                    border: new OutlineInputBorder(
                      borderSide: new BorderSide(
                        color: Color.fromRGBO(29, 170, 63, 1.0),
                      ),
                    ),
                    prefixIcon: const Icon(
                      Icons.call,
                      color: Colors.black,
                    ),
                    labelStyle: TextStyle(color: Colors.black),
                    // border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromRGBO(29, 170, 63, 1.0))),
                    labelText: "Phone Number"),
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
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextFormField(
                cursorColor: Colors.black,
                style: TextStyle(color: Colors.black),
                initialValue: _situationF,
                decoration: InputDecoration(
                    border: new OutlineInputBorder(
                      borderSide: new BorderSide(
                        color: Color.fromRGBO(29, 170, 63, 1.0),
                      ),
                    ),
                    prefixIcon: const Icon(
                      Icons.group,
                      color: Colors.black,
                    ),
                    labelStyle: TextStyle(color: Colors.black),
                    // border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromRGBO(29, 170, 63, 1.0))),
                    labelText: "Situation Familiale"),
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
            Container(
              margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  color: Color.fromRGBO(29, 170, 63, 1.0),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  child: const Text(
                    "Change Profile",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      print("form$_id");
                      //URL
                      String _baseUrl = "localhost:9091";
                      //Headers
                      Map<String, String> headers = {
                        "Content-Type": "application/json; charset=UTF-8"
                      };
                      //Body
                      // SharedPreferences prefs =  SharedPreferences.getInstance() as SharedPreferences;
                      //print(prefs.getString(id!));
                      Map<String, dynamic> userData = {
                        "_id": _id,
                        "firstname": _firstname,
                        "lastname": _lastname,
                        "email": _email,
                        "age": _age,
                        "gender": _gender,
                        "phone": _phone,
                        "situationF": _situationF
                      };
                      //Exec
                      http
                          .put(Uri.http(_baseUrl, '/api/users/update'),
                              headers: headers, body: json.encode(userData))
                          .then((http.Response response) async {
                        if (response.statusCode == 200) {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setString("email", userData["email"]);
                          prefs.setString("password", password);
                          prefs.setString("firstname", userData["firstname"]);
                          prefs.setString("lastname", userData["lastname"]);
                          prefs.setString("age", userData["age"]);
                          prefs.setString("gender", userData["gender"]);
                          prefs.setString("phone", userData["phone"]);
                         
                          prefs.setString("situationF", userData["situationF"]);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NavigationTabUser()));
                        } else if (response.statusCode == 401) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Row(
                                    children: [
                                      Icon(Icons.info),
                                      Text('Erreur'),
                                    ],
                                  ),
                                  content: Text(
                                      'Le code d inscription est invalide '),
                                );
                              });
                        }
                      });
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
