import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sorting_algorithm_visualizer/painter/barPainter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
  int _sampleSize = 200;
  String _sortingMethod = 'Bubble';

  StreamController<List<int>> _streamController;
  Stream<List<int>> _stream;

  _randomize() {
    _numbers = [];
    for (int i = 0; i < _sampleSize; ++i) {
      _numbers.add(Random().nextInt(500));
    }
    _streamController.add(_numbers);
  }

  _bubbleSort() async {
    for (int i = 0; i < _sampleSize; ++i) {
      for (int j = 0; j < _numbers.length - i - 1; ++j) {
        if (_numbers[j] > _numbers[j + 1]) {
          int temp = _numbers[j];
          _numbers[j] = _numbers[j + 1];
          _numbers[j + 1] = temp;
        }
        await Future.delayed(Duration(microseconds: 500));
        _streamController.add(_numbers);
      }
    }
  }

  heapify(List<int> arr, int n, int i) {
    int largest = i;
    int l = 2 * i + 1;
    int r = 2 * i + 2;

    if (l < n && arr[l] > arr[largest]) largest = l;

    if (r < n && arr[r] > arr[largest]) largest = r;

    if (largest != i) {
      int temp = _numbers[i];
      _numbers[i] = _numbers[largest];
      _numbers[largest] = temp;
      heapify(arr, n, largest);
    }
  }

  _heapSort() async {
    for (int i = _numbers.length ~/ 2; i >= 0; i--) {
      await heapify(_numbers, _numbers.length, i);
      _streamController.add(_numbers);
    }
    for (int i = _numbers.length - 1; i >= 0; i--) {
      int temp = _numbers[0];
      _numbers[0] = _numbers[i];
      _numbers[i] = temp;
      await Future.delayed(Duration(microseconds: 500));
      await heapify(_numbers, i, 0);
      _streamController.add(_numbers);
    }
  }

  _sort() async {
    if (_sortingMethod == 'Bubble')
      _bubbleSort();
    else if (_sortingMethod == 'Heap') _heapSort();
  }

  @override
  void initState() {
    super.initState();
    _streamController = StreamController<List<int>>();
    _stream = _streamController.stream;
    _randomize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0E4D64),
        title: Text('Sorting visualizer'),
        actions: <Widget>[
          PopupMenuButton<String>(
            // initialValue: _currentSortAlgo,
            itemBuilder: (ctx) {
              return [
                PopupMenuItem(
                  value: 'Bubble',
                  child: Text("Bubble Sort"),
                ),
                PopupMenuItem(
                  value: 'Heap',
                  child: Text("Heap Sort"),
                ),
                PopupMenuItem(
                  value: 'selection',
                  child: Text("Selection Sort"),
                ),
                PopupMenuItem(
                  value: 'insertion',
                  child: Text("Insertion Sort"),
                ),
                PopupMenuItem(
                  value: 'quick',
                  child: Text("Quick Sort"),
                ),
                PopupMenuItem(
                  value: 'merge',
                  child: Text("Merge Sort"),
                ),
              ];
            },
            onSelected: (String value) {
              setState(() {
                _sortingMethod = value;
              });
              print(value);
            },
          ),
        ],
      ),
      body: Container(
        child: StreamBuilder<Object>(
            stream: _stream,
            builder: (context, snapshot) {
              int _counter = 0;
              return Row(
                  children: _numbers.map((int number) {
                _counter++;
                return CustomPaint(
                  painter: BarPainter(
                      width:
                          MediaQuery.of(context).size.width ~/ _sampleSize + 1,
                      value: number,
                      index: _counter),
                );
              }).toList());
            }),
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
              child: Text('$_sortingMethod Sort'),
              onPressed: _sort,
            ),
          )
        ],
      ),
    );
  }
}
