import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

SpeedDial speedDial(_randomize, _sort, _sortingMethod) {
  return SpeedDial(
    marginBottom: 20,
    animatedIcon: AnimatedIcons.menu_close,
    visible: true,
    closeManually: false,
    curve: Curves.bounceIn,
    overlayColor: Colors.black,
    overlayOpacity: 0.5,
    elevation: 8.0,
    children: [
      SpeedDialChild(
        child: Icon(Icons.shuffle),
        backgroundColor: Colors.red,
        label: 'Randomize Array',
        labelStyle: TextStyle(fontSize: 18.0),
        onTap: () => _randomize(),
      ),
      SpeedDialChild(
        child: Icon(Icons.sort),
        backgroundColor: Colors.blue,
        label: 'Visualize $_sortingMethod Sort',
        labelStyle: TextStyle(fontSize: 18.0),
        onTap: () => _sort(),
      ),
    ],
  );
}
