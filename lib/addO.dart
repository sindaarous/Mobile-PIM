import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

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
  String _jour = "lundi";
  String _mois = "Janvier";
  String _time = "9:00";
  String _hospital = "Publique";
  final hopital = ['Publique', 'Privé'];
  final heure = ['9:00', '9:30', '10:00', '10:30', '11:00', '11:30', '12:00'];
  final jour = [
    'lundi',
    'mardi',
    'mercredi',
    'jeudi',
    'vendredi',
  ];
  final mois = [
    'Janvier',
    'Février',
    'Mars',
    'Avril',
    'Mai',
    'Juin',
    'Juillet',
    'Août',
    'Septembre',
    'Octobre',
    'Novembre',
    'Décembre'
  ];
  String value;
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
                    'Rendez-vous',
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
                              return "Le Prénom ne doit pas etre vide";
                            }
                          },
                          decoration: InputDecoration(
                            labelText: "Prénom",
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
                              return "Le Nom ne doit pas etre vide";
                            }
                          },
                          decoration: InputDecoration(
                            labelText: "Nom",
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
                        SfDateRangePicker(
                          selectionColor: Colors.green,
                          todayHighlightColor: Colors.green,
                          rangeSelectionColor: Colors.green,
                          showNavigationArrow: true,
                          minDate: DateTime.now().add(const Duration(days: -7)),
                          maxDate: DateTime.now().add(const Duration(days: 7)),
                          selectionMode: DateRangePickerSelectionMode.single,
                          initialSelectedRange: PickerDateRange(
                              DateTime.now().subtract(const Duration(days: 4)),
                              DateTime.now().add(const Duration(days: 3))),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 2,
                            ),
                            Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black12),
                                    borderRadius: BorderRadius.circular(10)),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                      value: _time,
                                      items: heure.map(buildMenuItem).toList(),
                                      onChanged: (value) =>
                                          setState(() => this._time = value)),
                                )),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black12),
                                    borderRadius: BorderRadius.circular(10)),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                      value: _hospital,
                                      items:
                                          hopital.map(buildMenuItem).toList(),
                                      onChanged: (value) => setState(
                                          () => this._hospital = value)),
                                )),
                          ],
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
                                  "date": _jour,
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
                                'Ajouter',
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

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(item,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
      );
}
