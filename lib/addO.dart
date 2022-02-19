import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'otp.dart';

class AddO extends StatefulWidget {
  const AddO({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<AddO> {
  // ignore: unused_field
  String _firstname = "";
  String _lastname = "";
  String _phone = "";
  String _date = "";
  String _time = "";
  String _hospital = "";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final String _baseUrl = "localhost:9091";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xfff7f6fb),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.arrow_back,
                        size: 32,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.shade50,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      'assets/images/no_history_ilustration.png',
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Text(
                    'Appointment',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          onSaved: (String value) {
                            _firstname = value;
                          },
                          // ignore: missing_return
                          validator: (String value) {
                            if (value == null || value.isEmpty) {
                              return "Le first name ne doit pas etre vide";
                            }
                          },
                          decoration: InputDecoration(
                            labelText: "First Name",
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black12),
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black12),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        SizedBox(
                          height: 22,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),

                          onSaved: (String value) {
                            _lastname = value;
                          },
                          // ignore: missing_return
                          validator: (String value) {
                            if (value == null || value.isEmpty) {
                              return "Le last name ne doit pas etre vide";
                            }
                          },
                          decoration: InputDecoration(
                            labelText: "Last Name",
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black12),
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black12),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        SizedBox(
                          height: 22,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.datetime,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          onSaved: (String value) {
                            _date = value;
                          },
                          // ignore: missing_return
                          validator: (String value) {
                            if (value == null || value.isEmpty) {
                              return "Le date ne doit pas etre vide";
                            }
                          },
                          decoration: InputDecoration(
                            labelText: "Date",
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black12),
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black12),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        SizedBox(
                          height: 22,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          onSaved: (String value) {
                            _time = value;
                          },
                          // ignore: missing_return
                          validator: (String value) {
                            if (value == null || value.isEmpty) {
                              return "Le time ne doit pas etre vide";
                            }
                          },
                          decoration: InputDecoration(
                            labelText: "Time",
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black12),
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black12),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        SizedBox(
                          height: 22,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          onSaved: (String value) {
                            _hospital = value;
                          },
                          // ignore: missing_return
                          validator: (String value) {
                            if (value == null || value.isEmpty) {
                              return "Le hospital ne doit pas etre vide";
                            }
                          },
                          decoration: InputDecoration(
                            labelText: "Hospital",
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black12),
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black12),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        SizedBox(
                          height: 22,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();

                                Map<String, dynamic> userData = {
                                  "firstname": _firstname,
                                  "lastname": _lastname,
                                  "phone": _phone,
                                  "date": _date,
                                  "heure": _time,
                                  "hospital": _hospital
                                };

                                Map<String, String> headers = {
                                  "Content-Type":
                                      "application/json; charset=UTF-8"
                                };

                                http
                                    .post(
                                        Uri.http(_baseUrl,
                                            "api/reservations/createReser"),
                                        headers: headers,
                                        body: json.encode(userData))
                                    .then((http.Response response) {
                                  Navigator.pushReplacementNamed(context, "/");

                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const AlertDialog(
                                          title: Text("Information"),
                                          content: Text(
                                              "Your appoinment has been successfully !"),
                                        );
                                      });
                                });
                              }
                            },
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.green),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(14.0),
                              child: Text(
                                'Add',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
