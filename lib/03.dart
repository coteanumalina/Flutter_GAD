import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:powers/powers.dart';
import 'package:flutter/services.dart';

class NumberShapes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Number Shapes',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  bool _isSquare = false;
  bool _isCubed = false;
  String? _message;

  void _showCupertinoDialog() {
    showDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: Text(_message!),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          'NUMBER SHAPES',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.1,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(top: 80.0, bottom: 40.0),
            child: Text(
              'Please input a number to see if it is square or triangular',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 60.0),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Card(
              elevation: 10.0,
              shadowColor: Colors.black,
              child: Column(
                children: <Widget>[
                  Container(
                    width: 200,
                    child: TextField(
                      style: const TextStyle(
                        color: Colors.black45,
                        fontSize: 19,
                      ),
                      textAlign: TextAlign.center,
                      keyboardType: const TextInputType.numberWithOptions(),
                      inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                      controller: _controller,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () {
                setState(() {
                  if (_controller.value.text.isNotEmpty) {
                    if ((int.parse(_controller.value.text)).isSquare) {
                      _isSquare = true;
                    }
                    if ((int.parse(_controller.value.text)).isCube) {
                      _isCubed = true;
                    }
                    if (_isSquare == true && _isCubed == true) {
                      _message = 'Number ${_controller.value.text} is both SQUARE and TRIANGULAR';
                    } else if (_isSquare == false && _isCubed == false) {
                      _message = 'Number ${_controller.value.text} is neither SQUARE or TRIANGULAR';
                    } else if (_isSquare == true) {
                      _message = 'Number ${_controller.value.text} is SQUARE';
                    } else {
                      _message = 'Number ${_controller.value.text} is TRIANGULAR';
                    }
                    _showCupertinoDialog();
                    _controller.clear();
                    _isSquare = false;
                    _isCubed = false;
                  } else {
                    _message = 'Please enter a number';
                    _showCupertinoDialog();
                  }
                });
              },
              icon: const Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
              iconSize: 60,
            ),
          ),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
