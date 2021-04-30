import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sorting_algorithm_visualizer/barPainter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<int> _numbers = [];
  int _sampleSize = 500;

  _randomize() {
    _numbers = [];
    for (int i = 0; i < _sampleSize; ++i) {
      _numbers.add(Random().nextInt(_sampleSize));
    }
    setState(() {});
  }

  _sort() async {
    for (int i = 0; i < _sampleSize; ++i) {
      for (int j = 0; j < _numbers.length - i - 1; ++j) {
        if (_numbers[j] > _numbers[j + 1]) {
          int temp = _numbers[j];
          _numbers[j] = _numbers[j + 1];
          _numbers[j + 1] = temp;
        }
        await Future.delayed(Duration(microseconds: 500));
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    _randomize();
  }

  @override
  Widget build(BuildContext context) {
    int _counter = 0;
    return Scaffold(
      appBar: AppBar(
        title: Text('Sorting visualizer'),
      ),
      body: Container(
        child: Row(
            children: _numbers.map((int number) {
          _counter++;
          return CustomPaint(
            painter: BarPainter(width: 2, value: number, index: _counter),
          );
        }).toList()),
      ),
      bottomNavigationBar: Row(
        children: [
          Expanded(
            child: FlatButton(
              child: Text('Randomize'),
              onPressed: _randomize,
            ),
          ),
          Expanded(
            child: FlatButton(
              child: Text('Sort'),
              onPressed: _sort,
            ),
          )
        ],
      ),
    );
  }
}
