import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:workshop_sim4/category_list.dart';
import 'package:workshop_sim4/schedule_card.dart';



class BodyTous extends StatefulWidget {
  @override
  State<BodyTous> createState() => _BodyTousState();
}

class _BodyTousState extends State<BodyTous> {
  final String _baseUrl = 'localhost:9091';
  String _user="";
  late Future<bool> fetchedReservs;
  final List<ReservationData> _reservs = [];
@override
  void initState() {
    super.initState();
      fetchedReservs = getReservs();
    _loadCounter();
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      
        _user=(prefs.getString('id') ?? '');
       // print("body$_user");
    });
  }
  //Actions
  Future<bool> getReservs() async {
    http.Response response =
        await http.get(Uri.http(_baseUrl, "api/reservations/allReser"));
    List<dynamic> reservsFromServer = json.decode(response.body);
    if (response!="")
    {
    for (var item in reservsFromServer) {
      var dateReservation = item['date'];
        var dateNow = DateTime.now();
        var time = item['heure'];
        //int datemonthR;
        //variable reservation
        var dateyear = int.parse(dateReservation.toString().substring(0, 4));
        var datemonth = int.parse(dateReservation.toString().substring(5, 7));
        var dateday = int.parse(dateReservation.toString().substring(8, 10));
        //variable date now
        var dateyearNow = int.parse(dateNow.toString().substring(0, 4));
        var datemonthNow = int.parse(dateNow.toString().substring(5, 7));
        var datedayNow = int.parse(dateNow.toString().substring(8, 10));
        //variable heure Now
        var dateheureNow = int.parse(dateNow.toString().substring(11, 13));
        var dateminuteNow = int.parse(dateNow.toString().substring(14, 16));
        //variable time
        var heureReservation = int.parse(time.toString().substring(0, 2));
        var minuteReservation = int.parse(time.toString().substring(3, 5));

        print(dateNow);
       print("dateyear$dateyear");
        print("datemonth$datemonth");
        print("dateday$dateday");

        print("dateyearnow$dateyearNow");
        print("datemonthnow$datemonthNow");
        print("datedaynow$datedayNow");

        print("dateheurnow$dateheureNow");
        print("dateminutenow$dateminuteNow");

        print("heurereservation$heureReservation");
        print("minutereservation$minuteReservation");

        if (((dateyear == dateyearNow) || (dateyear < dateyearNow)) &&
            ((datemonth == datemonthNow) || (datemonth < datemonthNow)) &&
            ((dateday == datedayNow) || (dateday < datedayNow)) &&
            ((dateheureNow == heureReservation) ||
                (heureReservation < dateheureNow)) &&
            ((dateminuteNow == minuteReservation) ||
                (minuteReservation < dateminuteNow))) {
                  print("here");
            String _baseUrl = "localhost:9091";
            //Headers
            Map<String, String> headers = {
              "Content-Type": "application/json; charset=UTF-8"
            };
            //Body
            Map<String, dynamic> userData = {
              "_id": item['_id']
              // "password": _password
            };
            http
                .put(Uri.http(_baseUrl, 'api/reservations/updateHistory'),
                    headers: headers, body: json.encode(userData))
                .then((http.Response response) async {
              if (response.statusCode == 200) {
                print("c bon ");
              }
            });
            // print(datte);
          
        }
      if (item['user'] == _user&&item['history']==0) {
        _reservs.add(ReservationData(
            item['_id'], item['date'], item['heure'], item['result']));
        log(item['_id']);
      }
    }
    }
    else {

    }

    return true;
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
            return 
              
               Container(
        margin: EdgeInsets.symmetric(vertical: 20.0 / 2),
        height: 30,
        child: Text("Vous n'avez aucun rendez vous",
            style: TextStyle(color: Color.fromARGB(255, 10, 10, 10)))
               //CircularProgressIndicator(),
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

  ReservationData(this.id, this.date, this.heure,this.result);
  @override
  String toString() {
    return 'GameData{title: $date, image: $heure, description: $result}';
  }
}
