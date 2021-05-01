import 'dart:async';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sorting_algorithm_visualizer/widgets.dart/speedDial.dart';
import './sorting/sortingAlgorithms.dart';
import 'package:flutter/material.dart';
import 'package:sorting_algorithm_visualizer/painter/barPainter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryIconTheme: IconThemeData(color: Colors.blue),
      ),
      debugShowCheckedModeBanner: false,
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
  int delayTime = 1000;
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
        streamController: _streamController,
        delayTime: delayTime);
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

  _showMaterialDialog() {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              actions: <Widget>[
                Form(
                  child: Column(
                    children: [],
                  ),
                ),
                FlatButton(
                  child: Text('Close me!'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFFFFF),
        title: Text(
          'Sorting visualizer',
          style: GoogleFonts.questrial(
            color: Colors.blue,
            fontWeight: FontWeight.w900,
          ),
        ),
        elevation: 0,
        actions: [
          Container(
            child: PopupMenuButton<String>(
              initialValue: _sortingMethod,
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
              },
            ),
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
      floatingActionButton:
          speedDial(_randomize, _sort, _showMaterialDialog, _sortingMethod),
    );
  }
}
