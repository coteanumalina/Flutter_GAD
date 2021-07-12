import 'package:fluttercourse/movie_app/actions/get_movies.dart';
import 'package:fluttercourse/movie_app/data/movie_api.dart';
import 'package:fluttercourse/movie_app/models/app_state.dart';
import 'package:fluttercourse/movie_app/models/movie.dart';
import 'package:redux/redux.dart';

class AppMiddleware {
  const AppMiddleware({required MovieApi movieApi}) : _movieApi = movieApi;

  final MovieApi _movieApi;

  List<Middleware<AppState>> get middleware {
    return <Middleware<AppState>>[
      TypedMiddleware<AppState, GetMovies>(_getMovies),
    ];
  }

  Future<void> _getMovies(Store<AppState> store, GetMovies action, NextDispatcher next) async {
    next(action);
    try {
      final List<Movie> movies = await _movieApi.getMovies(action.page);
      store.dispatch(GetMoviesSuccessful(movies));
    } catch (e) {
      store.dispatch(GetMoviesError(e));
    }
  }
}
