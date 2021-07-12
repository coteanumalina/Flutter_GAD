import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttercourse/movie_app/containers/selected_movie_container.dart';
import 'package:fluttercourse/movie_app/models/movie.dart';

class MovieDetails extends StatelessWidget {
  const MovieDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SelectedMovieContainer(
        builder: (BuildContext context, Movie movie){
          return Scaffold(
            appBar: AppBar(
              title: Text(movie.title),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox(
                        height: 350,
                        child: Image.network(
                          movie.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Year: ${movie.year}'),
                          Text('Rating: ${movie.rating}'),
                          Text('Language: ${movie.language}'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text('Genres: '),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  for (String item in movie.genres) Text(item),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ]
                  ),
                  const SizedBox(height: 40),
                  Text(movie.fullDescription),
                ],
              ),
            ),
          );
        }
    );
  }
}
