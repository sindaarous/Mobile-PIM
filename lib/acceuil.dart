import 'package:flutter/material.dart';
import 'package:workshop_sim4/GooleMappps.dart';
import 'package:workshop_sim4/body.dart';

class Accueil extends StatefulWidget {
  @override
  _AccueilState createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: GooleMappps(),
      
    );
  }
}
