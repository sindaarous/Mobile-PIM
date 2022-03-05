import 'dart:convert';
import 'dart:html';
import 'dart:developer';
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
      appBar: AppBar(
        title: const Text("S'authentifier"),
      ),
      body: Form(
        key: _keyForm,
        child: ListView(
          children: [
            Container(
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
               // child: Image.asset("assets/images/logo.png", width: 460, height: 215)
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 50, 10, 10),
              child: TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Email"),
                onSaved: (String? value) {
                  _email = value;
                },
                validator: (String? value) {
                  if(value == null || value.isEmpty) {
                    return "ce champ est required ";
                  }
                  else if(value.length == 2) {
                    return "Le code doit etre 3 caractères";
                  }
                  else {
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
                  if(value == null || value.isEmpty) {
                    return "Le mot de passe ne doit pas etre vide";
                  }
                  else if(value.length < 5) {
                    return "Le mot de passe doit avoir au moins 5 caractères";
                  }
                  else {
                    return null;
                  }
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: ElevatedButton(
                child: const Text("Register"),
                onPressed: () {
                  
                        Navigator.pushReplacementNamed(context, "/signup");
                },
              )
            ),
            Container(
               
                margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey),
                  ),
                  child: const Text("Login"),
                  onPressed: () {
                   if(_keyForm.currentState!.validate()) {
                    _keyForm.currentState!.save();                    
                    //URL
                    String _baseUrl = "localhost:9091";
                      //Headers
                    Map<String, String> headers = {
                      "Content-Type":"application/json; charset=UTF-8"
                    };
                    //Body
                    Map<String, dynamic> userData = {
                      "email" : _email,
                      "password":_password
                     // "password": _password
                    };
                    //Exec
                    http.post(Uri.http(_baseUrl, '/api/users/login'), headers: headers, body: json.encode(userData))
                    .then((http.Response response)async{

                      if (response.statusCode == 200) {
                           SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setString("email", userData["email"]);
                        final myString =prefs.getString("email");
                  
                         print("signin c bon");
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
                        },);

                      }else {

                        

                      }

                    });
                  
                  }
                  },
                )
            ),
           
          ],
        ),
      ),
    );
  }
}
/**/