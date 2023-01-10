import 'package:movies_app/home/models/movie.dart';
import 'package:movies_app/home/models/movie_details.dart';
import 'package:movies_app/home/repository/movie_repository.dart';

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

  String getImageUrl({required String imagePath}) {
    return 'https://image.tmdb.org/t/p/original$imagePath';
  }
}
