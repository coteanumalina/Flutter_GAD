import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:fluttercourse/movie_app/models/movie.dart';

class Movies extends StatelessWidget {
  const Movies({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark),
      title: 'Movies',
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Movie> listOfMovies = <Movie>[];

  @override
  void initState() {
    super.initState();
    _getMovies();
  }

  void _getMovies() {
    final Uri url = Uri(
        scheme: 'https',
        host: 'yts.mx',
        pathSegments: <String>['api', 'v2', 'list_movies.json'],
        queryParameters: <String, String>{'limit': '20', 'page': '2'});

    get(url).then((Response response) {
      final Map<String, dynamic> body = jsonDecode(response.body) as Map<String, dynamic>;
      final Map<String, dynamic> data = body['data'] as Map<String, dynamic>;
      final List<dynamic> movies = data['movies'] as List<dynamic>;
      print(movies);
      setState(() {
        for (dynamic m in movies) {
          listOfMovies.add(Movie.fromJson(m));
        }
      });
    });
  }

  void _dialog(String image, String title, int year, double rating, BuiltList<String> genres, String summary,
      String fullDescription, String language) {
    showDialog<void>(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: Text(title),
        content: Column(
          children: <Widget>[
            Row(children: <Widget>[
              SizedBox(
                height: 150,
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Year: $year'),
                  Text('Rating: $rating'),
                  Text('Language: $language'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text('Genres: '),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          for (String item in genres) Text(item),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ]),
            const SizedBox(height: 7),
            Text(fullDescription),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Movies',
          style: TextStyle(
            color: Colors.white,
            fontSize: 35,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.1,
          ),
        ),
        centerTitle: true,
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          childAspectRatio: 0.699,
        ),
        itemCount: listOfMovies.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              _dialog(
                  listOfMovies[index].image,
                  listOfMovies[index].title,
                  listOfMovies[index].year,
                  listOfMovies[index].rating,
                  listOfMovies[index].genres,
                  listOfMovies[index].summary,
                  listOfMovies[index].fullDescription,
                  listOfMovies[index].language);
            },
            child: GridTile(
              child: Image.network(
                listOfMovies[index].image,
                fit: BoxFit.cover,
              ),
              footer: Container(
                height: 80,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  begin: AlignmentDirectional.topCenter,
                  end: AlignmentDirectional.bottomCenter,
                  colors: <Color>[
                    Colors.transparent,
                    Colors.black,
                  ],
                )),
                child: GridTileBar(
                  title: Text(listOfMovies[index].title),
                  subtitle: Text('${listOfMovies[index].year}'),
                  trailing: Stack(
                    alignment: AlignmentDirectional.center,
                    children: <Widget>[
                      Text('${listOfMovies[index].rating}',
                          style: TextStyle(
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 1
                              ..color = Colors.white,
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          )),
                    ],
                  ),
                ),
              ),
              header: Container(
                height: 60,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  begin: AlignmentDirectional.topCenter,
                  end: AlignmentDirectional.bottomCenter,
                  colors: <Color>[
                    Colors.black,
                    Colors.transparent,
                  ],
                )),
                child: GridTileBar(
                  title: Text('${listOfMovies[index].genres}'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
