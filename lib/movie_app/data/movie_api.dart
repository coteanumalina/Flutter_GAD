import 'dart:convert';

import 'package:fluttercourse/movie_app/models/movie.dart';
import 'package:http/http.dart';

class MovieApi {
  const MovieApi({required String apiUrl, required Client client})
      : _apiUrl = apiUrl,
        _client = client;
  final String _apiUrl;
  final Client _client;

  Future<List<Movie>> getMovies(int page) async {
    final Uri uri = Uri.parse('$_apiUrl/list_movies.json?page=$page');
    final Response response = await _client.get(uri);

    if (response.statusCode >= 300) {
      throw StateError(response.body);
    }

    final Map<String, dynamic> body = jsonDecode(response.body) as Map<String, dynamic>;
    final Map<String, dynamic> data = body['data'] as Map<String, dynamic>;
    final List<dynamic> movies = data['movies'] as List<dynamic>;

    final List<Movie> result = movies //
    .map((dynamic json) => Movie.fromJson(json))
    .toList();

    return result;
  }
}
