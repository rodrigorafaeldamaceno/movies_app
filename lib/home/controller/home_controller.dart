import '../../core/database/database.dart';
import '../models/movie_details.dart';
import '../repository/movie_repository.dart';

class MovieController {
  final MovieRepository _movieRepository;

  MovieController(this._movieRepository);

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
