import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool ohTurn = true; // the first player is O
  List<String> displayExOh = <String>['', '', '', '', '', '', '', '', ''];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Container(
        height: getDimen(context),
        width: getDimen(context),
        child: GridView.builder(
            itemCount: 9,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  _tapped(index);
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[700])),
                  child: Center(
                    child: Text(
                      displayExOh[index],
//                    index.toString(),
                      style: TextStyle(
                          color: displayExOh[index] == 'O'
                              ? Colors.blue
                              : Colors.red,
                          fontSize: 40),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }

  void _tapped(int index) {
    setState(() {
      if (ohTurn && displayExOh[index] == '') {
        displayExOh[index] = 'O';
        ohTurn = !ohTurn;
      } else if (displayExOh[index] == '') {
        displayExOh[index] = 'X';
        ohTurn = !ohTurn;
      }
      _checkWinner();
    });
  }

  void _checkWinner() {
    //row 1
    if (displayExOh[0] == displayExOh[1] &&
        displayExOh[0] == displayExOh[2] &&
        displayExOh[0] != '') {
      _showWinDialog(displayExOh[0]);
    }
    //row 2
    else if (displayExOh[3] == displayExOh[4] &&
        displayExOh[3] == displayExOh[5] &&
        displayExOh[3] != '') {
      _showWinDialog(displayExOh[3]);
    }
    //row 3
    else if (displayExOh[6] == displayExOh[7] &&
        displayExOh[6] == displayExOh[8] &&
        displayExOh[6] != '') {
      _showWinDialog(displayExOh[6]);
    }
    //column 1
    else if (displayExOh[0] == displayExOh[3] &&
        displayExOh[0] == displayExOh[6] &&
        displayExOh[0] != '') {
      _showWinDialog(displayExOh[0]);
    }
    //column 2
    else if (displayExOh[1] == displayExOh[4] &&
        displayExOh[1] == displayExOh[7] &&
        displayExOh[1] != '') {
      _showWinDialog(displayExOh[1]);
    }
    //column 3
    else if (displayExOh[2] == displayExOh[5] &&
        displayExOh[2] == displayExOh[8] &&
        displayExOh[2] != '') {
      _showWinDialog(displayExOh[2]);
    }
    //diagonal 1
    else if (displayExOh[0] == displayExOh[4] &&
        displayExOh[0] == displayExOh[8] &&
        displayExOh[0] != '') {
      _showWinDialog(displayExOh[0]);
    }
    //diagonal 2
    else if (displayExOh[2] == displayExOh[4] &&
        displayExOh[2] == displayExOh[6] &&
        displayExOh[2] != '') {
      _showWinDialog(displayExOh[2]);
    }
    //tie game
    else if (displayExOh[0] != '' &&
        displayExOh[1] != '' &&
        displayExOh[2] != '' &&
        displayExOh[3] != '' &&
        displayExOh[4] != '' &&
        displayExOh[5] != '' &&
        displayExOh[6] != '' &&
        displayExOh[7] != '' &&
        displayExOh[8] != '') {
      _showTieDialog();
    }
  }

  void _showWinDialog(String winner) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title:
                Text('WINNER IS ' + winner + '!', textAlign: TextAlign.center),
            backgroundColor: Colors.deepOrangeAccent,
          );
        });
    clearGrid();
  }

  void _showTieDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("NO ONE WINS!", textAlign: TextAlign.center),
            backgroundColor: Colors.greenAccent,
          );
        });
    clearGrid();
  }

  void clearGrid() {
    for (int i = 0; i < 9; i++) displayExOh[i] = '';
    ohTurn = true;
  }

  Size screenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  double screenHeight(BuildContext context, {double dividedBy = 1}) {
    return screenSize(context).height / dividedBy;
  }

  double screenWidth(BuildContext context, {double dividedBy = 1}) {
    return screenSize(context).width / dividedBy;
  }

  double getDimen(BuildContext context) {
    return min(screenHeight(context), screenWidth(context));
  }
}
