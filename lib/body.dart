import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_otp_verification_ui/category_list.dart';
import 'package:flutter_otp_verification_ui/schedule_card.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final String _baseUrl = 'localhost:9091';
  Future<bool> fetchedReservs;
  final List<ReservationData> _reservs = [];

  //Actions
  Future<bool> getReservs() async {
    http.Response response =
        await http.get(Uri.http(_baseUrl, "api/reservations/allReser"));
    List<dynamic> reservsFromServer = json.decode(response.body);
    for (var item in reservsFromServer) {
      if (item['_id'] == "62006817392a56475c9541ed") {
        _reservs.add(ReservationData(
            item['_id'], item['date'], item['heure'], item['result']));
        log(item['_id']);
      }
    }

    return true;
  }

  @override
  void initState() {
    super.initState();
    fetchedReservs = getReservs();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchedReservs,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SafeArea(
              bottom: false,
              child: Column(
                children: <Widget>[
                  CategoryList(),
                  SizedBox(height: 20.0 / 2),
                  Expanded(
                    child: Stack(
                      children: <Widget>[
                        // Our background

                        ListView.builder(
                          itemCount: _reservs.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 2.0),
                              child: ScheduleCard(
                                  _reservs[index].id,
                                  _reservs[index].date,
                                  _reservs[index].heure,
                                  _reservs[index].result),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

class ReservationData {
  final String id;
  final String date;
  final String heure;
  final String result;

  ReservationData(this.id, this.date, this.heure, this.result);
  @override
  String toString() {
    return 'GameData{title: $date, image: $heure, description: $result}';
  }
}
