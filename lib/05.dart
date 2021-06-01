import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class TicTacToe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Basic Phrases',
      home: HomePage(),
    );
  }
}

List<int> isWin(List<List<bool?>> matrix) {
  List<int> winLine = <int>[];
  for (int i = 0; i < 3; i++) {
    if (matrix[i][0] == matrix[i][1] && matrix[i][1] == matrix[i][2] && matrix[i][0] != null) {
      if (i == 0) {
        winLine = <int>[0, 1, 2];
      } else if (i == 1) {
        winLine = <int>[3, 4, 5];
      } else {
        winLine = <int>[6, 7, 8];
      }
    } else if (matrix[0][i] == matrix[1][i] && matrix[1][i] == matrix[2][i] && matrix[0][i] != null) {
      if (i == 0) {
        winLine = <int>[0, 3, 6];
      } else if (i == 1) {
        winLine = <int>[1, 4, 7];
      } else {
        winLine = <int>[2, 5, 8];
      }
    }
  }
  if (matrix[0][0] == matrix[1][1] && matrix[1][1] == matrix[2][2] && matrix[0][0] != null) {
    winLine = <int>[0, 4, 8];
  } else if (matrix[2][0] == matrix[1][1] && matrix[1][1] == matrix[0][2] && matrix[2][0] != null) {
    winLine = <int>[2, 4, 6];
  }
  return winLine;
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isX = true; // x starts first
  List<bool> isTapped = List<bool>.filled(9, false); // initially all the buttons are white
  List<bool?> xo = List<bool?>.filled(9, null); // x = true, o = false, list used for button's color
  List<List<bool?>> matrix = <List<bool?>>[
    <bool?>[null, null, null],
    <bool?>[null, null, null],
    <bool?>[null, null, null]
  ];
  bool _isTryAgainVisible = false;
  bool _areButtonsDisabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'TIC TAC TOE',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 40,
            foreground: Paint()
              ..shader = ui.Gradient.linear(
                const Offset(0, 50),
                const Offset(400, 0),
                <Color>[
                  Colors.red,
                  Colors.green,
                ],
              ),
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 20),
          Flexible(
            child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                padding: const EdgeInsets.all(10.0),
                itemCount: 9,
                itemBuilder: (BuildContext context, int index) {
                  return FloatingActionButton(
                    backgroundColor: isTapped[index] == false
                        ? Colors.white
                        : xo[index] == true
                            ? Colors.red
                            : Colors.green,
                    onPressed: () {
                      if (_areButtonsDisabled == false) {
                        setState(() {
                          if (isTapped[index] == false) {
                            isTapped[index] = true;
                            if (_isX == true) {
                              xo[index] = true; // x
                            } else {
                              xo[index] = false; // o
                            }
                            switch (index) {
                              case 0:
                                matrix[0][0] = _isX;
                                break;
                              case 1:
                                matrix[0][1] = _isX;
                                break;
                              case 2:
                                matrix[0][2] = _isX;
                                break;
                              case 3:
                                matrix[1][0] = _isX;
                                break;
                              case 4:
                                matrix[1][1] = _isX;
                                break;
                              case 5:
                                matrix[1][2] = _isX;
                                break;
                              case 6:
                                matrix[2][0] = _isX;
                                break;
                              case 7:
                                matrix[2][1] = _isX;
                                break;
                              case 8:
                                matrix[2][2] = _isX;
                                break;
                            }
                            if (isWin(matrix).isNotEmpty) {
                              final List<int> winLine = isWin(matrix);
                              for (int i = 0; i < isTapped.length; i++) {
                                if (!winLine.contains(i)) {
                                  isTapped[i] = false;
                                }
                              }
                              _areButtonsDisabled = true;
                              _isTryAgainVisible = true;
                            }
                            _isX = !_isX;
                          }
                        });
                      }
                    },
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    ),
                  );
                },
              ),
          ),
          Visibility(
            child: Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    isTapped = List<bool>.filled(9, false);
                    xo = List<bool?>.filled(9, null);
                    matrix = <List<bool?>>[
                      <bool?>[null, null, null],
                      <bool?>[null, null, null],
                      <bool?>[null, null, null]
                    ];
                    _isX = true;
                    _isTryAgainVisible = !_isTryAgainVisible;
                    _areButtonsDisabled = false;
                  });
                },
                style: TextButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(2.0)),
                  ),
                ),
                child: const Text(
                  'TRY AGAIN',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            visible: _isTryAgainVisible,
          ),
          const SizedBox(height: 250),
        ],
      ),
    );
  }
}
