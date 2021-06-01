import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

class GuessNumber extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Guess the number',
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
  int randomNumber = Random().nextInt(100) + 1;
  String? _messageExactLowerHigher;
  String? _messageTriedNumber;
  int? _rightNumber;
  bool _isGuess = true;

  void _showCupertinoDialog() {
    showDialog<void>(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: const Text('You guessed right'),
        content: Text('It was $_rightNumber'),
        actions: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              ElevatedButton(
                child: const Text('Try again'),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    _controller.clear();
                    _messageTriedNumber = null;
                    _messageExactLowerHigher = null;
                    _isGuess = true;
                    randomNumber = Random().nextInt(100) + 1;
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.orangeAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
              const SizedBox(width: 20.0),
              ElevatedButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    _isGuess = false;
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.orangeAccent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                ),
              ),
              const SizedBox(width: 20.0),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'GUESS THE NUMBER',
          style: TextStyle(
            color: Colors.orangeAccent,
            fontSize: 22,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.1,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(top: 80.0, bottom: 40.0),
            child: Text(
              'I\'m thinking of a number between 1 and 100.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const Text(
            'It\'s your turn to guess my number!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 23,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 60.0),
          Text(
            _messageTriedNumber ?? '',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            _messageExactLowerHigher ?? '',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 40,
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Card(
              elevation: 10.0,
              shadowColor: Colors.grey,
              child: Column(
                children: <Widget>[
                  const Text(
                    'Try a number!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.orangeAccent,
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    width: 200,
                    child: TextField(
                      enabled: _isGuess,
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
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (_isGuess) {
                          if (_controller.value.text.isEmpty) {
                            _messageExactLowerHigher = '';
                            _messageTriedNumber = '';
                          } else {
                            if (int.parse(_controller.value.text) == randomNumber) {
                              _messageExactLowerHigher = 'You guessed right';
                              _rightNumber = int.parse(_controller.value.text);
                              _showCupertinoDialog();
                            } else if (int.parse(_controller.value.text) < randomNumber) {
                              _messageExactLowerHigher = 'Try higher';
                            } else {
                              _messageExactLowerHigher = 'Try lower';
                            }
                            _messageTriedNumber = 'Your tried ${_controller.value.text}';
                            _controller.clear();
                          }
                        } else {
                          _controller.clear();
                          _messageTriedNumber = null;
                          _messageExactLowerHigher = null;
                          _isGuess = true;
                          randomNumber = Random().nextInt(100) + 1;
                        }
                      });
                    },
                    child: Text(
                      _isGuess == true ? 'GUESS' : 'RESET',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orangeAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
