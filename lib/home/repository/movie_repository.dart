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

  Future<List<Movie>?> getMovies() async {}

  Future<List<Movie>?> getSimilarMovies({required int movieId}) async {}

  Future<MovieDetails?> getMovieDetails(int id) async {}
}
