import 'package:flutter/material.dart';

class ScheduleCardHisto extends StatelessWidget {
  final String _id;
  final String _date;
  final String _heure;
  final String _result;

  const ScheduleCardHisto(this._id, this._date, this._heure, this._result);

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
                   _date.substring(0,10),
                  
                ),
                Text(
                  _heure + ":00",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          title: Text(
            "Rendez-vous",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xff1E1C61),
            ),
          ),
          subtitle: Text(
            _result,
            style: TextStyle(
              color: Color(0xff1E1C61).withOpacity(0.7),
            ),
          ),
        ),
      ),
    );
  }
}