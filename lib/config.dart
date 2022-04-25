import 'dart:convert';

import 'package:flutter/services.dart';

const String _Config =
    'pk.eyJ1IjoiamloZW5nYWJzaSIsImEiOiJjbDI5MzB1eW8wMDh3M2RvNDlvNjBicTNoIn0.C2U9FyDJ0zTlbVe9tQ8Jmw';

Future<Map<String, dynamic>> loadConfigFile() async {
  String json = await rootBundle.loadString(_Config);
  return jsonDecode(json) as Map<String, dynamic>;
}
