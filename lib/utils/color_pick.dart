import 'package:flutter/material.dart';

class ColorPick {
  ColorPick();

  Color? getColor(int index) {
    switch (index) {
      case 0:
        return Colors.teal[700];
      case 1:
        return Colors.amber[400];
      case 2:
        return Colors.blue[400];
      case 3:
        return Colors.deepPurple[400];
      case 4:
        return Colors.green[400];
      case 5:
        return Colors.red[400];
      case 6:
        return Colors.tealAccent[400];
      case 7:
        return Colors.blueGrey[400];
      case 8:
        return Colors.brown[400];
      case 9:
        return Colors.lime[400];
      case 10:
        return Colors.purpleAccent[500];
      case 11:
        return Colors.teal[400];
      case 12:
        return Colors.indigoAccent[400];
      case 13:
        return Colors.amber[700];
      case 14:
        return Colors.deepOrange[700];
      case 15:
        return Colors.green[800];
      case 16:
        return Colors.red[900];
      case 17:
        return Colors.pink[200];
      case 18:
        return Colors.teal[200];
      case 19:
        return Colors.redAccent[200];
      case 20:
        return Colors.purple[900];

      default:
        return Color(1000000000 * index);
    }
  }
}
