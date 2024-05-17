import 'package:dio/dio.dart';
import '../../core/database/database.dart';
import '../models/movie_details.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class MovieRepository {
  final Dio _httpClient = Dio();

  MovieRepository() {
    _httpClient.options.baseUrl = 'https://api.themoviedb.org/3/';
    _httpClient.options.queryParameters = {
      'api_key': const String.fromEnvironment('MOVIE_API_KEY'),
      'language': 'pt-BR',
    };
    _httpClient.interceptors.add(PrettyDioLogger());
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
    return null;
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
    return null;
  }

  Future<MovieDetails?> getMovieDetails(int id) async {
    try {
      final response = await _httpClient.get('movie/$id');

      return MovieDetails.fromJson(response.data);
    } catch (e, s) {
      print(e);
      print(s);
    }
    return null;
  }
}
