import 'dart:async';
import 'dart:developer';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
//import 'package:geocode/geocode.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:latlong2/latlong.dart' as ll;
//import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
//import 'package:location/location.dart' as loc;
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:workshop_sim4/addR.dart';
import 'package:workshop_sim4/map_marker.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

//pk.eyJ1IjoiamloZW5nYWJzaSIsImEiOiJjbDI5MzM5YmcwZGJtM2pvOHFiZGhubWJjIn0.VEJsw19L374uSHC2wX80jg
class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  //late GoogleMapController mapController;

  Future<LatLng?> acquireCurrentLocation() async {
    // Initializes the plugin and starts listening for potential platform events
    /*  Location location = new Location();

    bool serviceEnabled;

    final locationData = await location.getLocation();
    return LatLng(
        locationData.latitude as double, locationData.longitude as double);
        */
  }

  final String _baseUrl = 'localhost:9091';
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
      _hospitals.add(HospitalData(item['_id'], item['nomHospital'],
          item['addresseHospital'], item['phoneHospital']));
    }
    return true;
  }

  List<Marker> _buildMarkers() {
    final _markerList = <Marker>[];

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
                /*
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString("address", mapItem.title);
                prefs.setString("idHospital", mapItem.id);
                */
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
        'pk.eyJ1IjoiamloZW5nYWJzaSIsImEiOiJjbDI5MzB1eW8wMDh3M2RvNDlvNjBicTNoIn0.C2U9FyDJ0zTlbVe9tQ8Jmw';
    // GeoCode geoCode = GeoCode();
    final _markers = _buildMarkers();
    //final result = acquireCurrentLocation() as ll.LatLng;
    const String style = 'mapbox/streets-v11';
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
                      additionalOptions: {'accessToken': Config, 'id': style},
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
    final _style = TextStyle(
        color: Colors.grey[800], fontSize: 18, fontWeight: FontWeight.bold);
    final _styleAdress = TextStyle(color: Colors.grey[800], fontSize: 14);
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Card(
        margin: EdgeInsets.zero,
        color: Colors.white,
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
                  MaterialPageRoute(builder: (context) => const AddO(name: "")),
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

  HospitalData(
      this.id, this.nomHospital, this.addresseHospital, this.phoneHospital);
  @override
  String toString() {
    return 'HopitalData{nomHospital: $nomHospital, addresseHospital: $addresseHospital, phoneHospital: $phoneHospital}';
  }
}
