import 'package:cinemapedia/domain/entities/movie.dart';

// 1: crear esto y copiarlo a repositories
abstract class MovieDataSource {

  Future<List<Movie>> getNowPlaying({int page = 1});

}