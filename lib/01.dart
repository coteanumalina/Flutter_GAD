import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CurrencyConvertor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Currency Convertor",
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

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
  String _eurToRon = '4.93';
  String _ronToEur = '0.20';
  String? _reversedVariable;
  bool _ron = true;
  double? _doubleValue;
  String? _valueToConvert;
  RegExp regex = new RegExp(r'^[+-]?([0-9]+([.][0-9]*)?|[.][0-9]+)$');
  String _message = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color(0xff000099),
        title: Text(
          'CURRENCY CONVERTOR',
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
                        style: TextStyle(
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
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: 'Value in ' + _leftText,
                            hintStyle: TextStyle(
                              color: Colors.black45,
                              fontSize: 18,
                            ),
                          ),
                          controller: _controller,
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                          onChanged: (String value) {
                            setState(() {
                              if (value.isNotEmpty) {
                                if (regex.hasMatch(_controller.value.text)) {
                                  _message = '';
                                  if (_ron == true) {
                                    _doubleValue = double.parse(_controller.value.text) * double.parse(_eurToRon);
                                  } else {
                                    _doubleValue = double.parse(_controller.value.text) * double.parse(_ronToEur);
                                  }
                                  _valueToConvert = _doubleValue!.toStringAsFixed(2);
                                } else {
                                  _message = 'Please enter a valid number';
                                }
                              } else {
                                _valueToConvert = "Value in " + _rightText;
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
                        style: TextStyle(
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
                            (_valueToConvert == null ? "Value in " + _rightText : _valueToConvert)!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
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
              style: TextStyle(
                color: Colors.red,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Column(
              children: <Widget>[
                Text(
                  "1 EUR = " + _eurToRon + " RON",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  "1 RON = " + _ronToEur + " EUR",
                  textAlign: TextAlign.center,
                  style: TextStyle(
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
