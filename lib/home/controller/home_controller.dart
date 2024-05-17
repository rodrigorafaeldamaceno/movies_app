import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../../core/database/database.dart';
import '../../core/utils/get_image_url.dart';
import '../models/movie_details.dart';
import '../repository/movie_repository.dart';

class MovieController {
  final MovieRepository _movieRepository;

  final AppDatabase _appDatabase = AppDatabase.instance;

  final cacheManager = DefaultCacheManager();

  MovieController(this._movieRepository);

  Future downloadImage(String url) async {
    final localFile = await cacheManager.getFileFromCache(url);

    if (localFile != null) return;

    await cacheManager.downloadFile(url);
  }

  Future<void> getMoviesFromRemote() async {
    final movies = await _movieRepository.getMovies();

    if (movies == null) return;

    await _appDatabase.moviesDao.removeAll();

    for (var movie in movies) {
      downloadImage(getImageUrl(movie.posterPath ?? ''));
    }

    await _appDatabase.moviesDao.addAll(movies);
  }

  Stream<List<Movie>> getMoviesFromLocal() {
    return _appDatabase.moviesDao.getAll();
  }

  Future<List<Movie>?> getMovies() async {
    return _movieRepository.getMovies();
  }

  Future<List<Movie>?> getSimilarMovies({required int movieId}) async {
    return _movieRepository.getSimilarMovies(movieId: movieId);
  }

  Future<MovieDetails?> getMovieDetails(int id) async {
    return _movieRepository.getMovieDetails(id);
  }
}
