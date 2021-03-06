import 'dart:convert';
import 'dart:html';
import 'dart:developer';

import 'navigations/nav_tab user.dart';
import 'navigations/nav_tab.dart';
import 'signup.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  late String? _email;
  late String? _password;

  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();

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
        key: _keyForm,
        child: ListView(
          children: [
            Column(children: <Widget>[
              Text(
                "Login",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Text(
                "Login to your account",
                style: TextStyle(fontSize: 15, color: Colors.grey[700]),
              )
            ]),
            Container(
              width: double.infinity,
              //margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              // child: Image.asset("assets/images/logo.png", width: 460, height: 215)
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 50, 10, 20),
              child: TextFormField(
                cursorColor: Colors.black,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    border: new OutlineInputBorder(
                      borderSide: new BorderSide(
                        color: Color.fromRGBO(29, 170, 63, 1.0),
                      ),
                    ),
                    prefixIcon: const Icon(
                      Icons.email,
                      color: Colors.black,
                    ),
                    labelStyle: TextStyle(color: Colors.black),
                    // border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(29, 170, 63, 1.0))),
                    labelText: "Email"),
                onSaved: (String? value) {
                  _email = value;
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "ce champ est required ";
                  } else if (value.length == 2) {
                    return "Le code doit etre 3 caract??res";
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 40),
              child: TextFormField(
                cursorColor: Colors.black,
                obscureText: true,
                decoration: InputDecoration(
                    border: new OutlineInputBorder(
                      borderSide: new BorderSide(
                        color: Color.fromRGBO(29, 170, 63, 1.0),
                      ),
                    ),
                    prefixIcon: const Icon(
                      Icons.password,
                      color: Colors.black,
                    ),
                    labelStyle: TextStyle(color: Colors.black),
                    // border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color.fromRGBO(29, 170, 63, 1.0),
                    )),
                    labelText: "Mot de passe "),
                onSaved: (String? value) {
                  _password = value;
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Le mot de passe ne doit pas etre vide";
                  } else if (value.length < 5) {
                    return "Le mot de passe doit avoir au moins 5 caract??res";
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                padding: EdgeInsets.only(top: 3, left: 3),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border(
                      bottom: BorderSide(color: Colors.black),
                      top: BorderSide(color: Colors.black),
                      left: BorderSide(color: Colors.black),
                      right: BorderSide(color: Colors.black),
                    )),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  color: Color.fromRGBO(29, 170, 63, 1.0),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  child: const Text(
                    "Login",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                  onPressed: () {
                    if (_keyForm.currentState!.validate()) {
                      _keyForm.currentState!.save();
                      //URL
                      String _baseUrl = "localhost:9091";
                      //Headers
                      Map<String, String> headers = {
                        "Content-Type": "application/json; charset=UTF-8"
                      };
                      //Body
                      Map<String, dynamic> userData = {
                        "email": _email,
                        "password": _password
                        // "password": _password
                      };
                      //Exec
                      http
                          .post(Uri.http(_baseUrl, '/api/patient/login'),
                              headers: headers, body: json.encode(userData))
                          .then((http.Response response) async {
                        if (response.statusCode == 200) {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setString("email", userData["email"]);
                          // prefs.setString("password", userData["password"]);
                          Map<String, dynamic> res = json.decode(response.body);
                          if (res['role'] == "user") {
                            var userId = res['_id'];
                            var usermail = res['email'];
                            var userPwd = res['password'];
                            var firsrname = res['firstname'];
                            var lastname = res['lastname'];
                            var age = res['age'];
                            var gender = res['gender'];
                            var phone = res['phone'];
                            var situationF = res['situationF'];
                            final myString = prefs.getString("email");
                            prefs.setString("id", userId);
                            prefs.setString("email", usermail);
                            prefs.setString("password", userPwd);
                            prefs.setString("firstname", firsrname);
                            prefs.setString("lastname", lastname);
                            prefs.setString("age", age);
                            prefs.setString("gender", gender);
                            prefs.setString("phone", phone);
                            prefs.setString("situationF", situationF);
                             Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NavigationTabUser()));
                          } else {
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
                            final myString = prefs.getString("email");
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


                             Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NavigationTab()));
                          }

                          print("signin c bon");

                         
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
                                content:
                                    Text('Le code d inscription est invalide '),
                              );
                            },
                          );
                        } else {}
                      });
                    }
                  },
                )),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Don't have an account?"),
                  ],
                ),
              ],
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border(
                      bottom: BorderSide(color: Colors.black),
                      top: BorderSide(color: Colors.black),
                      left: BorderSide(color: Colors.black),
                      right: BorderSide(color: Colors.black),
                    )),
                child: SizedBox(
                    height: 50,
                    width: 60,
                    child: MaterialButton(
                      minWidth: double.infinity,
                      color: Colors.white,
                      child: const Text(
                        "Register",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(50)),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Signup()));
                      },
                    ))),
            Container(
              height: MediaQuery.of(context).size.height / 3,
              /* decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/background.png'),
                          fit: BoxFit.cover)),*/
            )
          ],
        ),
      ),
    );
  }
}
/**/