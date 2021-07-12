import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Weather extends StatelessWidget {
  const Weather({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Weather',
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
  String? city;
  String? imageUrl;
  num? temperature;
  num? feelsLike;
  int? pressure;
  int? humidity;
  int? visibility;

  @override
  void initState() {
    super.initState();
    _weather();
  }

  void _weather() {
    final Uri url = Uri(scheme: 'https', host: 'api.ipify.org', queryParameters: <String, String>{'format': 'json'});
    get(url).then((Response response) {
      final Map<String, dynamic> body = jsonDecode(response.body) as Map<String, dynamic>;
      return body['ip'] as String;
    }).then((String ip) {
      final Uri url = Uri(scheme: 'http', host: 'ip-api.com', pathSegments: <String>['json', ip]);
      get(url).then((Response response) {
        final Map<String, dynamic> body = jsonDecode(response.body) as Map<String, dynamic>;
        return <num>[body['lat'], body['lon']];
      }).then((List<num> coordinates) {
        final Uri url = Uri(scheme: 'https', host: 'api.openweathermap.org', pathSegments: <String>[
          'data',
          '2.5',
          'onecall'
        ], queryParameters: <String, String>{
          'appid': '0090e3c81f07b47c0ce63beeb2bbfe94',
          'lat': '${coordinates[0]}',
          'lon': '${coordinates[1]}'
        });

        get(url).then((Response response) {
          final Map<String, dynamic> body = jsonDecode(response.body) as Map<String, dynamic>;
          final Map<String, dynamic> current = body['current'];
          setState(() {
            city = body['timezone'].split('/')[1];
            imageUrl = current['weather'][0]['icon'];
            temperature = current['temp'] - 272;
            feelsLike = current['feels_like'] - 272;
            pressure = current['pressure'];
            humidity = current['humidity'];
            visibility = current['visibility'];
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'WEATHER',
          style: TextStyle(
            color: Colors.black,
            fontSize: 35,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.1,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Builder(
          builder: (BuildContext context) {
            if (imageUrl == 'null' || imageUrl == null) {
              return const CircularProgressIndicator(backgroundColor: Colors.white);
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 50.0),
                Text(
                  '$city',
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${temperature!.round()} °C',
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Image.network(
                  imageUrl != 'null'
                      ? 'http://openweathermap.org/img/wn/$imageUrl@2x.png'
                      : 'https://cdn.iconscout.com/icon/premium/png-512-thumb/loading-420-892992.png',
                  height: MediaQuery.of(context).size.height * 0.3,
                ),
                Text(
                  'Feels like: ${feelsLike!.round()} °C',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Pressure: $pressure hPa',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Humidity: $humidity %',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Visibility: $visibility m',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
