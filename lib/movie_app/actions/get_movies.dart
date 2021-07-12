import 'package:fluttercourse/movie_app/models/movie.dart';

class GetMovies {
  const GetMovies(this.page);

  final int page;
}

class GetMoviesSuccessful {
  GetMoviesSuccessful(this.movies);

  final List<Movie> movies;
}

class GetMoviesError {
  GetMoviesError(this.error);

  final Object error;
}
