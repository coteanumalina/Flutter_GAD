import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart';

List<String> textRomanian = <String>['Salut!', 'Buna dimineata!', 'Noapte buna!', 'Ce faci?', 'Cum te numesti?', 'Cati ani ai?', 'Cat este ceasul?', 'Multumesc!'];
List<String> textEnglish = <String>['Hello!', 'Good morning!', 'Good night!', 'What are you doing?', 'What\'s your name?', 'How old are you?', 'What time is it?', 'Thank you!'];
String _languageRomanian = 'ro-RO-PREMIUM-A_FEMALE';
String _languageEnglish = 'en-US-PREMIUM-C_FEMALE';

class BasicPhrases extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Basic Phrases',
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.lime,
        title: const Text(
          'BASIC PHRASES',
          style: TextStyle(
            color: Colors.pink,
            fontSize: 35,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.1,
          ),
        ),
        centerTitle: true,
      ),
      body: GridView.builder(
          scrollDirection: Axis.vertical,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 30.0 ,
            mainAxisSpacing: 30.0,
          ),
          padding: const EdgeInsets.all(30.0),
          itemCount: 16,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: MediaQuery.of(context).size.width * 0.1,
              decoration: const BoxDecoration(
                color: Colors.lime,
                shape: BoxShape.circle,
              ),
              child: TextButton(
                onPressed: () {
                  playSound(index % 2 == 0 ? _languageRomanian : _languageEnglish, index % 2 == 0 ? textRomanian[(index~/2).toInt()] : textEnglish[((index-1)~/2).toInt()]);
                },
                child: Align(
                    child: Text(
                      index % 2 == 0 ? textRomanian[(index~/2).toInt()] : textEnglish[((index-1)~/2).toInt()],
                      style: const TextStyle(
                        color: Colors.pink,
                        fontSize: 15,
                      ),
                    ),
                    alignment: Alignment.center,
                ),
              ),
            );
          }
      ),
    );
  }
}

Future<void> playSound(String language, String text) async{
  final Uri url = Uri.parse('https://www.de-vis-software.ro/tts.aspx');
  final Map<String, dynamic> bodyJson = <String, dynamic>{
    'inputtext': text,
    'ssml':'Text',
    'voicename': language,
    'voicetype':'HeadPhones',
    'encoding':'Mp3',
    'speed':1,
    'pitch':0,
    'volume':7,
    'saveFileLocally':'Yes'
  };
  final String newBodyJson = jsonEncode(bodyJson);
  const String username = 'malina coteanu';
  const String password = '123@Malina@321';
  final String basicAuth =
      'Basic ' + base64Encode(utf8.encode('$username:$password'));
  final Map<String,String> headers = <String, String>{
    'Authorization': basicAuth,
    'Content-type' : 'application/json',
    'Accept': 'application/json',
  };

  final Response response = await post(url, body: newBodyJson, headers: headers);
  print(jsonDecode(response.body)['audioFileURL']);
  final AudioPlayer audioPlayer = AudioPlayer();
  final int result = await audioPlayer.play(jsonDecode(response.body)['audioFileURL']);
  if (result == 1) {
    print('success');
  }
}