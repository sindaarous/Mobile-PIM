import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workshop_sim4/acceuil.dart';
import 'package:workshop_sim4/button_widget.dart';
import 'package:workshop_sim4/consts.dart';
import 'package:workshop_sim4/home/home.dart';
import 'package:intl/intl.dart';
import 'package:workshop_sim4/navigations/nav_tab.dart';

import 'calendar/theme.dart';

class AddO extends StatefulWidget {
  const AddO({Key? key, required this.bodyid, required this.bodyname})
      : super(key: key);
  // const AddO({String? bodyname, String? bodyid});
  final String bodyname;
  final String bodyid;

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<AddO> {
  late Future<bool> fetchedReservs;
  final List<HospitalData> _reservs = [];

  // ignore: unused_field
  String _firstname = "";
  String _lastname = "";
  String _date = "";
  String _time = "09:00";
  String _hospital = "";
  String _user = "";
  String _idH = "";
  String _email = "";

  final List<HospitalData> hopital = [];
  //final hopital = [];
  List<String> heure = ["09:00", "10:00", "11:00", "11:00", "12:00", "13:00"];
  late DateTime? date = DateTime.now();
  @override
  void initState() {
    super.initState();
    print(widget.bodyname);
    _loadCounter();
    // getReservs();
  }

  String getText() {
    if (date == null) {
      return 'Select Date';
    } else {
      _date = DateFormat('yyyy-MM-dd').format(date!);
      print("date:$_date");
      return DateFormat('MM/dd/yyyy').format(date!);
      // return '${date.month}/${date.day}/${date.year}';
    }
  }

  late String value;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final String _baseUrl = ConstantUrl.constUrl;

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _idH = prefs.getString('address')!;
    //print(_idH);
    setState(() {
      _firstname = (prefs.getString('firstname') ?? '');
      _lastname = (prefs.getString('lastname') ?? '');
      _email = (prefs.getString('email') ?? '');
      _hospital = widget.bodyid;
      //_idH = (prefs.getString('idHospital') ?? '');
      // print("email$_email");
      _user = (prefs.getString('id') ?? '');
      //print(_hospital);
    });
    // http.Response response =
    //     await http.get(Uri.http(_baseUrl, "api/hospital/all"));
    // List<dynamic> reservsFromServer = json.decode(response.body);
    // for (var item in reservsFromServer) {
    //   if (item['_id'] == widget.bodyid) {
    //     // print(widget.bodyid);
    //     print(item['_id']);
    //     heure.add(item['heureDebut'].toString());
    //     heure.add(item['heureFin'].toString());
    //   }
    // }
  }

  String _res = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Get.isDarkMode ? Color(0xff424242) : Colors.white,
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.shade50,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      'assets/no_history_ilustration.png',
                      width: 200,
                      height: 200,
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
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        ButtonHeaderWidget(
                          title: 'Date',
                          text: getText(),
                          onClicked: () => pickDate(context),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 2,
                            ),
                            Container(
                                margin:
                                    const EdgeInsets.fromLTRB(10, 0, 10, 10),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black12),
                                    borderRadius: BorderRadius.circular(10)),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                      style: subsobHeadingStyle,
                                      value: _time,
                                      items: heure.map(buildMenuItem).toList(),
                                      onChanged: (value) =>
                                          setState(() => _time = value!)),
                                )),
                            SizedBox(
                              width: 50,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 22,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              //String _res2 = "";
                              Map<String, dynamic> params2 = {
                                "dateR": _date,
                                "nameHos": _hospital,
                                "heureR": _time,
                                "idUser": _user
                              };

                              Map<String, String> headers = {
                                "Content-Type":
                                    "application/json; charset=UTF-8"
                              };
                              http
                                  .post(
                                      Uri.http(_baseUrl,
                                          "/api/reservations/searchReser"),
                                      headers: headers,
                                      body: json.encode(params2))
                                  .then((http.Response response) {
                                _res = response.body;
                                setState(() {
                                  _res;
                                });

                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();

                                  switch (_res.toString()) {
                                    case '"found"':
                                      {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return const AlertDialog(
                                                title: Text("Information"),
                                                content: Text(
                                                    "Vous avez déja un rendez-vous !"),
                                              );
                                            });
                                      }
                                      break;
                                    case '"false"':
                                      {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return const AlertDialog(
                                                title: Text("Information"),
                                                content: Text(
                                                    "Choisissez une autre date !"),
                                              );
                                            });
                                      }
                                      break;
                                    case '"true"':
                                      {
                                        Map<String, dynamic> userData = {
                                          "firstname": _firstname,
                                          "lastname": _lastname,
                                          "date": _date,
                                          "heure": _time,
                                          "user": _user,
                                          "adresse": widget.bodyname,
                                          "hospital": widget.bodyid,
                                          "email": _email
                                        };

                                        Map<String, String> headers = {
                                          "Content-Type":
                                              "application/json; charset=UTF-8"
                                        };

                                        http
                                            .post(
                                                Uri.http(_baseUrl,
                                                    "/api/reservations/createReser"),
                                                headers: headers,
                                                body: json.encode(userData))
                                            .then((http.Response response) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      NavigationTab()));

                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return const AlertDialog(
                                                  title: Text("Information"),
                                                  content: Text(
                                                      "Vous avez ajoutez un rendez-vous !"),
                                                );
                                              });
                                        });
                                      }
                                  }
                                }
                                ;
                              });
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
  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: date!,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    // print("_hospital$_hospital");
    // print("hopital$hopital");

    if (newDate == null) return;

    setState(() => date = newDate);
  }
}

class HospitalData {
  final String id;
  final String heureDebut;
  final String heureFin;

  HospitalData(this.id, this.heureDebut, this.heureFin);
}
