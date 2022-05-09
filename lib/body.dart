import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:latlong2/latlong.dart' as ll;
//import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
//import 'package:location/location.dart' as loc;
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:workshop_sim4/addR.dart';
import 'package:workshop_sim4/consts.dart';
import '../services/theme_services.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  Future<LatLng?> acquireCurrentLocation() async {}

  final String _baseUrl = ConstantUrl.constUrl;
  late Future<bool> fetchedHospitals;
  final List<HospitalData> _hospitals = [];
  final _markerList = <Marker>[];
  final _pageController = PageController();
  int _selectedIndex = 0;
  late final AnimationController _animationController;
  String _hospital = "";
  String _idH = "";
  Future<bool> getHospitals() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("address", _hospital);
    // prefs.setString("idHospital", mapItem.id);

    var _user = prefs.getString('id');
    // print("body$_user");
    http.Response response =
        await http.get(Uri.http(_baseUrl, "api/hospital/all"));
    List<dynamic> hospitalsFromServer = json.decode(response.body);
    for (var item in hospitalsFromServer) {
      _hospitals.add(HospitalData(
          item['_id'],
          item['nomHospital'],
          item['addresseHospital'],
          item['phoneHospital'],
          item['latitude'],
          item['longitude']));
    }

    return true;
  }

  List<Marker> _buildMarkers() {
    final _markerList = <Marker>[];
    for (var item in _hospitals) {
      var coords =
          ll.LatLng(double.parse(item.latitude), double.parse(item.longitude));
      mapMarkers.add(
          MapMarker(item.id, item.nomHospital, item.addresseHospital, coords));
    }
    for (int i = 0; i < mapMarkers.length; i++) {
      final mapItem = mapMarkers[i];
      _markerList.add(Marker(
        height: 40,
        width: 40,
        point: mapItem.coords,
        builder: (_) {
          return GestureDetector(
            onTap: () {
              _selectedIndex = i;
              setState(() {
                _pageController.animateToPage(i,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.bounceInOut);
                print('Selected: ${mapItem.title}');
                setState(() {
                  _hospital = mapItem.title;
                });
              });
            },
            child: _LocationMarker(
              selected: _selectedIndex == i,
            ),
          ); // GestureDetector
        },
      ));
    }
    return _markerList;
  }

  @override
  void initState() {
    super.initState();
    fetchedHospitals = getHospitals();
    _buildMarkers();
  }

  @override
  void dispose() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    super.dispose();
  }

  late MapboxMapController mapController;
  @override
  Widget build(BuildContext context) {
    const String Config =
        'sk.eyJ1IjoiamloZW5nYWJzaSIsImEiOiJjbDJ4YnJ0dWgwdTB6M2NvenNqbGg4Nmh3In0.Abn5no--UJfN6EIGN1q6tw';
    // GeoCode geoCode = GeoCode();
    final _markers = _buildMarkers();
    //final result = acquireCurrentLocation() as ll.LatLng;
    const String style1 = 'mapbox/streets-v11';
    const String style2 = 'mapbox/dark-v10';

    final _mylocation = ll.LatLng(36.89822056809473, 10.189862108073912);
    const MARKER_COLOR = Colors.green;

    return FutureBuilder(
        future: fetchedHospitals,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
                body: Stack(
              children: [
                FlutterMap(
                  options: MapOptions(
                    pinchZoomThreshold: 0.5,
                    minZoom: 5,
                    zoom: 10,
                    center: _mylocation,
                  ),
                  nonRotatedLayers: [
                    TileLayerOptions(
                      urlTemplate:
                          'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
                      additionalOptions: {
                        'accessToken': Config,
                        'id': Get.isDarkMode ? style2 : style1
                      },
                    ),
                    MarkerLayerOptions(markers: _markers),
                    MarkerLayerOptions(markers: [
                      Marker(
                          height: 10,
                          width: 10,
                          point: _mylocation,
                          builder: (_) {
                            return Container(
                              height: 5,
                              width: 5,
                              decoration: const BoxDecoration(
                                color: MARKER_COLOR,
                                shape: BoxShape.circle,
                              ),
                            );
                          }),
                    ])
                  ],
                ),
                Positioned(
                    left: 0,
                    right: 0,
                    bottom: 20,
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: PageView.builder(
                        controller: _pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: mapMarkers.length,
                        itemBuilder: (context, index) {
                          final item = mapMarkers[index];
                          return _MapItemDetails(
                            mapMarker: item,
                          );
                        }))
              ],
            ));
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}

class _LocationMarker extends StatelessWidget {
  const _LocationMarker({Key? key, this.selected = false}) : super(key: key);

  final bool selected;
  @override
  Widget build(BuildContext context) {
    final size = selected ? 50.0 : 30.0;
    return Center(
      child: AnimatedContainer(
        height: size,
        width: size,
        duration: const Duration(milliseconds: 400),
        child: Image.asset("assets/map.png"),
      ),
    );
  }
}

class _MapItemDetails extends StatelessWidget {
  const _MapItemDetails({
    Key? key,
    required this.mapMarker,
  }) : super(key: key);
  final MapMarker mapMarker;

  @override
  Widget build(BuildContext context) {
    String addM = mapMarker.address;
    final idM = mapMarker.id;
    final _style = TextStyle(
        color: Get.isDarkMode ? Colors.white : Color(0xff424242),
        fontSize: 18,
        fontWeight: FontWeight.bold);
    final _styleAdress = TextStyle(
        color: Get.isDarkMode ? Colors.white : Color(0xff424242), fontSize: 14);
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Card(
        margin: EdgeInsets.zero,
        color: Get.isDarkMode
            ? Color.fromARGB(255, 81, 79, 79)
            : Color.fromARGB(255, 235, 230, 230),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Row(children: [
                Expanded(child: Image.asset("assets/hospital.png")),
                Expanded(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(mapMarker.title, style: _style),
                    const SizedBox(height: 10),
                    Text(mapMarker.address, style: _styleAdress),
                  ],
                ))
              ]),
            ),
            MaterialButton(
              padding: EdgeInsets.zero,
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddO(
                          bodyname: mapMarker.address, bodyid: mapMarker.id)),
                )
              },
              color: Colors.green,
              elevation: 6,
              child: Text('Ajouter une réservation'),
            )
          ],
        ),
      ),
    );
  }
}

class HospitalData {
  final String id;
  final String nomHospital;
  final String addresseHospital;
  final String phoneHospital;
  final String latitude;
  final String longitude;
  HospitalData(this.id, this.nomHospital, this.addresseHospital,
      this.phoneHospital, this.latitude, this.longitude);
  @override
  String toString() {
    return 'HopitalData{nomHospital: $nomHospital, addresseHospital: $addresseHospital, phoneHospital: $phoneHospital}';
  }
}

final mapMarkers = [
  MapMarker('626553e0955589ea4ac8a3fb', 'Hôpital Habib Thameur',
      'Montfleury, Tunis', ll.LatLng(36.78683658491015, 10.176596979029252)),
];

class MapMarker {
  final String id;
  final String title;
  final String address;
  final ll.LatLng coords;

  MapMarker(this.id, this.title, this.address, this.coords);
  @override
  String toString() {
    return 'HopitalData{nomHospital: $title, addresseHospital: $address, phoneHospital: $coords}';
  }
}
