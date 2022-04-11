import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:workshop_sim4/navigations/nav_tab.dart';

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
  late String? _adresse;
  late String? _birthday;
  late String? _phone;
  late String? _GroupeSanguine;
  late String? _situationF;
   late String? dropdownvalue = _GroupeSanguine;
   late String? dropdownvalues = _situationF;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inscription"),
        backgroundColor: Color.fromRGBO(29, 170, 63, 1.0)
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
                cursorColor: Colors.black,
                keyboardType: TextInputType.text,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    border: new OutlineInputBorder(
                      borderSide: new BorderSide(
                        color:Color.fromRGBO(29, 170, 63, 1.0),
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
                    labelText: "Nom"),
                onSaved: (String? value) {
                  _firstname = value;
                },
                validator: (String? value) {
                  if (value!.isEmpty || value.length < 3) {
                    return "Le nom doit avoir au moins 3 caractères !";
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
                keyboardType: TextInputType.text,
                style: TextStyle(color: Colors.black),
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
                    labelText: "Prénom"),
                onSaved: (String? value) {
                  _lastname = value;
                },
                validator: (String? value) {
                  if (value!.isEmpty || value.length < 3) {
                    return "Le prénom doit avoir au moins 3 caractères !";
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
                        borderSide: BorderSide(color: Color.fromRGBO(29, 170, 63, 1.0))),
                    labelText: "Adresse email"),
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
                obscureText:true,
                 cursorColor: Colors.black,
               // maxLines: 4,
                style: TextStyle(color: Colors.black),
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
                        borderSide: BorderSide(color: Color.fromRGBO(29, 170, 63, 1.0))),
                     labelText: "Mot de passe"),
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
            Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: TextFormField(
                cursorColor: Colors.black,
                keyboardType: TextInputType.text,
                style: TextStyle(color: Colors.black),
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
                    labelText: "Adresse"),
                onSaved: (String? value) {
                  _adresse = value;
                },
                validator: (String? value) {
                  if (value!.isEmpty || value.length < 3) {
                    return "L'adresse doit avoir au moins 3 caractères !";
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
                keyboardType: TextInputType.text,
                style: TextStyle(color: Colors.black),
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
                    labelText: "Birthday"),
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
                cursorColor: Colors.black,
                keyboardType: TextInputType.text,
                style: TextStyle(color: Colors.black),
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
                    labelText: "Numéro téléphone"),
                onSaved: (String? value) {
                  _phone = value;
                },
                validator: (String? value) {
                  if (value!.isEmpty || value.length == 7) {
                    return "Le numéro doit avoir 8 caractères !";
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
               child: Column(
                   
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      
                      DropdownButtonFormField<String>(
                        itemHeight: 50.0,
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(29, 170, 63, 1.0)),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(29, 170, 63, 1.0)),
                          ),
                          prefixIcon: Icon(
                            Icons.bloodtype,
                            color: Colors.black,
                          ),
                        ),
                        hint: Text('Please choose blood type'),
                        items: <String>[
                          'O-',
                          'O+',
                          'A-',
                          'A+',
                          'B-',
                          'B+',
                          'AB-',
                          'AB+'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            
                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _GroupeSanguine = newValue!;
                            print(dropdownvalue);
                            
                          });
                        },
                      ),
                    ])),
            
            Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
             child: Column(
                   
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      
                      DropdownButtonFormField<String>(
                        itemHeight: 50.0,
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(29, 170, 63, 1.0)),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(29, 170, 63, 1.0)),
                          ),
                          prefixIcon: Icon(
                            Icons.group,
                            color: Colors.black,
                          ),
                        ),
                       hint: Text('Please choose your situation'),
                        items: <String>[
                          'Célibataire',
                          'Marié(e)',
                          'Divorcé(e)',
                          'Veuf(Veuve)',
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            
                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _situationF = newValue!;
                            print(dropdownvalues);
                            
                          });
                        },
                      ),
                    ])),
            
            
            Row(
              
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                ElevatedButton(
                  
                    child: const Text("S'inscrire"),
                     style: ElevatedButton.styleFrom(
                       
                primary: Color.fromRGBO(29, 170, 63, 1.0),
                  ),
                  
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
                          "adresse": _adresse,
                          "birthday": _birthday,
                          "phone": _phone,
                          "GroupeSanguine": _GroupeSanguine,
                          "situationF": _situationF
                        };
                       
                        //Exec
                        http
                            .post(Uri.http(_baseUrl, '/api/patient/register'),
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
                            prefs.setString("adresse", userData["adresse"]);
                            prefs.setString("birthday", userData["birthday"]);
                            prefs.setString("phone", userData["phone"]);
                            prefs.setString("GroupeSanguine", userData["GroupeSanguine"]);
                            prefs.setString(
                                "situationF", userData["situationF"]);
                            print("cbon signup ");
                             Navigator.push(context, MaterialPageRoute(builder: (context) => NavigationTab()));
                     

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
                  style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(29, 170, 63, 1.0),
                  )
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
