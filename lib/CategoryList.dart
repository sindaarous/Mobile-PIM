import 'package:flutter/material.dart';

// We need statefull widget because we are gonna change some state on our category
class CategoryList extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  // by default first item will be selected
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 20.0 / 2),
        height: 30,
        child: Text("Vous avez aucun rendez-vous traité",
            style: TextStyle(color: Color.fromARGB(255, 10, 10, 10))));
  }
}
