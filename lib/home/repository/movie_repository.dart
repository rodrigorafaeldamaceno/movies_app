import 'package:dio/dio.dart';
import 'package:movies_app/home/models/movie.dart';
import 'package:movies_app/home/models/movie_details.dart';

const apiKey = '189a45dd7ce86676042909d64d011285';

class MovieRepository {
  final Dio _httpClient = Dio();

  MovieRepository() {
    _httpClient.options.baseUrl = 'https://api.themoviedb.org/3/';
    _httpClient.options.queryParameters = {
      'api_key': apiKey,
      'language': 'pt-BR',
    };
  }

  Future<List<Movie>?> getMovies() async {
    try {
      final response = await _httpClient.get('movie/popular');

      final movies = <Movie>[];

      for (final json in (response.data['results'] as List)) {
        movies.add(Movie.fromJson(json));
      }

      return movies;
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  Future<List<Movie>?> getSimilarMovies({required int movieId}) async {
    try {
      final response = await _httpClient.get('movie/$movieId/similar');

      final movies = <Movie>[];

      for (final json in (response.data['results'] as List)) {
        movies.add(Movie.fromJson(json));
      }

      return movies;
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  Future<MovieDetails?> getMovieDetails(int id) async {
    try {
      final response = await _httpClient.get('movie/$id');

      return MovieDetails.fromJson(response.data);
    } catch (e, s) {
      print(e);
      print(s);
    }
  }
}
