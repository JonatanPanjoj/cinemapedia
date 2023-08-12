import 'package:cinemapedia/domain/entities/movie.dart';

// 1: crear esto y copiarlo a repositories
abstract class MoviesDataSource {

  Future<List<Movie>> getNowPlaying({int page = 1});

  Future<List<Movie>> getPopular({int page = 1});

  Future<List<Movie>> getUpcoming({int page = 1});

  Future<List<Movie>> getTopRated({int page = 1});

  Future<Movie> getMovieById(String id);

}
