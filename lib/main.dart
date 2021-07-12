import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttercourse/movie_app/actions/get_movies.dart';
import 'package:fluttercourse/movie_app/middleware/middleware.dart';
import 'package:fluttercourse/movie_app/models/app_state.dart';
import 'package:fluttercourse/movie_app/presentation/home_page.dart';
import 'package:http/http.dart';
import 'package:redux/redux.dart';

import 'movie_app/data/movie_api.dart';
import 'movie_app/presentation/movie_details.dart';
import 'movie_app/reducer/reducer.dart';

void main() {
  const String apiUrl = 'https://yts.mx/api/v2';
  final Client client = Client();
  final MovieApi moviesApi = MovieApi(apiUrl: apiUrl, client: client);
  final AppMiddleware appMiddleware = AppMiddleware(movieApi: moviesApi);
  final Store<AppState> store = Store<AppState>(
    reducer,
    initialState: AppState(),
    middleware: appMiddleware.middleware,
  );
  store.dispatch(GetMovies(store.state.page));
  runApp(YtsApp(store: store));

}

class YtsApp extends StatelessWidget{
  const YtsApp({Key? key, required this.store}) : super(key:key);
  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        theme: ThemeData(brightness: Brightness.dark),
        home: const HomePage(),
        routes: <String, WidgetBuilder>{
          '/details': (BuildContext context){
            return const MovieDetails();
          }
        },
      ),
    );
  }
}
