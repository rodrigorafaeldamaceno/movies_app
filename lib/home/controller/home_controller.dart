import '../../core/database/database.dart';
import '../models/movie_details.dart';
import '../repository/movie_repository.dart';

class MovieController {
  final MovieRepository _movieRepository;

  final AppDatabase _appDatabase = AppDatabase.instance;

  MovieController(this._movieRepository);

  Future<void> getMoviesFromRemote() async {
    final movies = await _movieRepository.getMovies();

    if (movies == null) return;

    await _appDatabase.moviesDao.removeAll();

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
