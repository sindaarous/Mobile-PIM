import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:workshop_sim4/body.dart';
import 'package:workshop_sim4/consts.dart';
import 'package:workshop_sim4/home/home.dart';
import 'package:workshop_sim4/navigations/nav_tab.dart';

import 'calendar/theme.dart';

class ScheduleCard extends StatefulWidget {
  final String _id;
  final String _date;
  final String _hospital;
  final String _heure;
  final String _result;

  const ScheduleCard(
      this._id, this._date, this._hospital, this._heure, this._result);
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<ScheduleCard> {
  @override
  void initState() {
    super.initState();
  }

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
              horizontal: 16,
            ),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  DateTime.parse(widget._date).day.toString() +
                      "/" +
                      DateTime.parse(widget._date).month.toString() +
                      "/" +
                      DateTime.parse(widget._date).year.toString(),
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget._heure,
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          title: Text(widget._hospital, style: subsubHeadingStyle),
          subtitle: Text(widget._result, style: subsubHeadingStyle),
          trailing: IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.green,
                size: 24.0,
                semanticLabel: 'Text to announce in accessibility modes',
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Information"),
                        content: Text("Etes vous sure?"),
                        actions: [
                          ElevatedButton(
                              child: Text("Oui"),
                              onPressed: () {
                                final String _baseUrl = ConstantUrl.constUrl;
                                Map<String, dynamic> userData = {
                                  "_id": widget._id
                                };

                                Map<String, String> headers = {
                                  "Content-Type":
                                      "application/json; charset=UTF-8"
                                };
                                http
                                    .put(
                                        Uri.http(_baseUrl,
                                            "/api/reservations/deleteReser"),
                                        headers: headers,
                                        body: json.encode(userData))
                                    .then((http.Response response) {
                                  Navigator.of(context).pop("Great!");

                                  // Return value
                                });

                                // Return value
                              }),
                          ElevatedButton(
                              child: Text("Annuler"),
                              onPressed: () {
                                Navigator.of(context)
                                    .pop("Great!"); // Return value
                              }),
                        ],
                      );
                    });
              }),
        ),
      ),
    );
  }
}
