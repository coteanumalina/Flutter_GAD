import 'package:fluttercourse/movie_app/actions/get_movies.dart';
import 'package:fluttercourse/movie_app/data/movie_api.dart';
import 'package:fluttercourse/movie_app/models/app_state.dart';
import 'package:fluttercourse/movie_app/models/movie.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';


class AppEpics {
  const AppEpics(this._movieApi);

  final MovieApi _movieApi;

  Epic<AppState> get epics {
    return combineEpics(<Epic<AppState>>[
      TypedEpic<AppState, GetMovies>(_getMovies),

    ]);
  }

  Stream<Object> _getMovies(Stream<GetMovies> actions, EpicStore<AppState> store) {
    return actions
        .asyncMap((GetMovies action) => _movieApi.getMovies(store.state.page))
        .map<Object>((List<Movie> movies) => GetMoviesSuccessful(movies))
        .onErrorReturnWith((Object error) => GetMoviesError(error));
  }
}