import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workshop_sim4/acceuil.dart';
import 'package:workshop_sim4/body.dart';
import 'package:workshop_sim4/home/home.dart';
import 'package:workshop_sim4/navigations/nav_tab.dart';

import 'calendar/theme.dart';

class ScheduleCard extends StatelessWidget {
  final String _id;
  final String _date;
  final String _heure;
  final String _result;

  const ScheduleCard(this._id, this._date, this._heure, this._result);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: ListTile(
            leading: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    _date.substring(0, 10),
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    _heure,
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            title: Text("Rendez-vous", style: subHeadingStyle),
            subtitle: Text(_result, style: subHeadingStyle),
            trailing: Container(
                child: Column(children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  //URL
                  String _baseUrl = "localhost:9091";
                  //Headers
                  Map<String, String> headers = {
                    "Content-Type": "application/json; charset=UTF-8"
                  };
                  //Body
                  Map<String, dynamic> userData = {
                    "_id": _id,
                  };
                  //Exec
                  http
                      .put(Uri.http(_baseUrl, '/api/reservations/deleteReser'),
                          headers: headers, body: json.encode(userData))
                      .then((http.Response response) async {
                    if (response.statusCode == 200) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NavigationTab()));

                      print("delete c bon");
                    } else {}
                  });
                },
                child: Icon(
                  Icons.delete_forever_sharp,
                  color: Colors.black26,
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    shape: CircleBorder(),
                    // padding: EdgeInsets.all(14),
                    minimumSize: Size(100, 40)),
              ),
            ]))),
      ),
    );
  }
}
