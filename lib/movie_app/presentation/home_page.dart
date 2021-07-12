import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttercourse/movie_app/actions/get_movies.dart';
import 'package:fluttercourse/movie_app/actions/set.dart';
import 'package:fluttercourse/movie_app/containers/is_loading_container.dart';
import 'package:fluttercourse/movie_app/containers/movies_container.dart';
import 'package:fluttercourse/movie_app/models/app_state.dart';
import 'package:fluttercourse/movie_app/models/movie.dart';
import 'package:redux/redux.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
  }

  void _onScroll() {
    final bool isLoading = StoreProvider.of<AppState>(context).state.isLoading;
    final double maximum = _controller.position.maxScrollExtent;
    final double offset = _controller.offset;
    final double difference = maximum - offset;
    final double height = MediaQuery.of(context).size.height;
    final double moment = height * 0.2;
    final int _page = StoreProvider.of<AppState>(context).state.page;

    if (difference < moment && !isLoading) {
      StoreProvider.of<AppState>(context).dispatch(GetMovies(_page));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IsLoadingContainer(builder: (BuildContext context, bool isLoading) {
      return MovieContainer(builder: (BuildContext context, List<Movie> listOfMovies) {
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
          body:GridView.builder(
            controller: _controller,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 0.699,
            ),
            itemCount: listOfMovies.length,
            itemBuilder: (BuildContext context, int index) {
              final Movie movie = listOfMovies[index];
              return GestureDetector(
                onTap: () {
                  StoreProvider.of<AppState>(context).dispatch(SetSelectedMovie(movie.id!));
                  Navigator.pushNamed(context, '/details');
                },
                child: GridTile(
                  child: Image.network(
                    movie.image,
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
                      title: Text(movie.title),
                      subtitle: Text('${movie.year}'),
                      trailing: Stack(
                        alignment: AlignmentDirectional.center,
                        children: <Widget>[
                          Text('${movie.rating}',
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
                      title: Text('${movie.genres}'),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      });
    });
  }
}
