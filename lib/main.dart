import 'dart:async';
import 'dart:math';
import './sorting/sortingAlgorithms.dart';
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
  int _sampleSize = 100;
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

  _sort() async {
    final sort = Sort(
        numbers: _numbers,
        sampleSize: _sampleSize,
        streamController: _streamController);
    switch (_sortingMethod) {
      case 'Bubble':
        await sort.bubbleSort();
        break;
      case 'Heap':
        await sort.heapSort();
        break;
      case 'Selection':
        await sort.selectionSort();
        break;
      case 'Insertion':
        await sort.insertionSort();
        break;
      case 'Quick':
        await sort.quickSort(0, _sampleSize.toInt() - 1);
        break;
      case 'Merge':
        await sort.mergeSort(0, _sampleSize.toInt() - 1);
        break;
    }
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
                  value: 'Selection',
                  child: Text("Selection Sort"),
                ),
                PopupMenuItem(
                  value: 'Insertion',
                  child: Text("Insertion Sort"),
                ),
                PopupMenuItem(
                  value: 'Quick',
                  child: Text("Quick Sort"),
                ),
                PopupMenuItem(
                  value: 'Merge',
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
