import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  late String? _firstname;
  late String? _lastname;
  late String? _email;
  late String? _password;
  late String? _age;
  late String? _birthday;
  late String? _phone;
  late String? _gender;
  late String? _situationF;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inscription"),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
              // child: Image.asset("assets/images/minecraft.jpg", width: 460, height: 215)
            ),
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
            Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Mot de passe"),
                onSaved: (String? value) {
                  _password = value;
                },
                validator: (String? value) {
                  if (value!.isEmpty || value.length < 5) {
                    return "Le mot de passe doit avoir au moins 5 caractères !";
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
                    child: const Text("S'inscrire"),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        //URL
                        String _baseUrl = "localhost:9091";
                        //Headers
                        Map<String, String> headers = {
                          "Content-Type": "application/json; charset=UTF-8"
                        };
                        //Body
                        Map<String, dynamic> userData = {
                          "firstname": _firstname,
                          "lastname": _lastname,
                          "email": _email,
                          "password": _password,
                          "age": _age,
                          "birthday": _birthday,
                          "phone": _phone,
                          "gender": _gender,
                          "situationF": _situationF
                        };
                       
                        //Exec
                        http
                            .post(Uri.http(_baseUrl, '/api/users/createUsers'),
                                headers: headers, body: json.encode(userData))
                            .then((http.Response response) async {

                          if (response.statusCode == 200) {
                             print(userData);
                           SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setString("email", userData["email"]);
                            prefs.setString("password", userData["password"]);
                            prefs.setString("firstname", userData["firstname"]);
                            prefs.setString("lastname", userData["lastname"]);
                            prefs.setString("age", userData["age"]);
                            prefs.setString("birthday", userData["birthday"]);
                            prefs.setString("phone", userData["phone"]);
                            prefs.setString("gender", userData["gender"]);
                            prefs.setString(
                                "situationF", userData["situationF"]);
                            print("cbon signup ");
                             Navigator.pushReplacementNamed(context, "/home/navTab");

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
                                      'L email est invalide '),
                                );
                              },
                            );
                          } else {}
                        });
                      }
                      /* String message = "Nom : " + _nom!
                      + "\n" + "Email : " + _email!
                      + "\n" + "Mot de passe : " + _password!
                      + "\n" + "Prenom: " + _prenom!
                      + "\n" + "code : " + _code!;

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Informations"),
                            content: Text(message),
                          );
                        },
                      );*/
                    }),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  child: const Text("Annuler"),
                  onPressed: () {
                    _formKey.currentState!.reset();
                    Navigator.pushReplacementNamed(context, "/");
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
