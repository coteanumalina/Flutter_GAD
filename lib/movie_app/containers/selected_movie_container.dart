import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttercourse/movie_app/models/app_state.dart';
import 'package:fluttercourse/movie_app/models/movie.dart';
import 'package:redux/redux.dart';

class SelectedMovieContainer extends StatelessWidget {
  const SelectedMovieContainer({Key? key, required this.builder}) : super(key: key);

  final ViewModelBuilder<Movie> builder;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Movie>(
      converter: (Store<AppState> store) => store.state.movies.firstWhere((Movie item) => item.id == store.state.selectedMovie),
      builder: builder,
    );
  }
}
