import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CurrencyConverter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Currency Converter',
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
  String _leftImage = 'https://www.countryflags.com/wp-content/uploads/romania-flag-png-large.png';
  String _rightImage =
      'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b7/Flag_of_Europe.svg/1280px-Flag_of_Europe.svg.png';
  String _leftText = 'RON';
  String _rightText = 'EUR';
  final double _eurToRon = 4.93;
  final double _ronToEur = 0.20;
  String? _reversedVariable;
  bool _ron = true;
  double? _doubleValue;
  String? _valueToConvert;
  RegExp regex = RegExp(r'^[+-]?([0-9]+([.][0-9]*)?|[.][0-9]+)$');
  String _message = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color(0xff000099),
        title: const Text(
          'CURRENCY CONVERTER',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.1,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 80.0, bottom: 20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(_leftImage),
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text(
                        _leftText,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        width: 140,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1.2,
                            color: Colors.black45,
                          ),
                        ),
                        child: TextField(
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: 'Value in ' + _leftText,
                            hintStyle: const TextStyle(
                              color: Colors.black45,
                              fontSize: 18,
                            ),
                          ),
                          controller: _controller,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          onChanged: (String value) {
                            setState(() {
                              if (value.isNotEmpty) {
                                if (regex.hasMatch(_controller.value.text)) {
                                  _message = '';
                                  if (_ron == true) {
                                    _doubleValue = double.parse(_controller.value.text) * _ronToEur;
                                  } else {
                                    _doubleValue = double.parse(_controller.value.text) * _eurToRon;
                                  }
                                  _valueToConvert = _doubleValue!.toStringAsFixed(2);
                                } else {
                                  _message = 'Please enter a valid number';
                                }
                              } else {
                                _valueToConvert = 'Value in ' + _rightText;
                                _message = '';
                              }
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _controller.clear();
                      _reversedVariable = _rightImage;
                      _rightImage = _leftImage;
                      _leftImage = _reversedVariable!;
                      _reversedVariable = _rightText;
                      _rightText = _leftText;
                      _leftText = _reversedVariable!;
                      _ron = !_ron;
                      _valueToConvert = null;
                      _message = '';
                    });
                  },
                  child: Container(
                      width: 50,
                      height: 50,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Image.network('https://www.freeiconspng.com/thumbs/reverse-icon/reverse-icon-5.png'),
                      )),
                ),
                Column(
                  children: <Widget>[
                    Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(_rightImage),
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text(
                        _rightText,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        width: 140,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1.2,
                            color: Colors.black45,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            _valueToConvert ?? 'Value in ' + _rightText,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.black45,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              _message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Column(
              children: <Widget>[
                Text(
                  '1 EUR = $_eurToRon RON',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  '1 RON = $_ronToEur EUR',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
