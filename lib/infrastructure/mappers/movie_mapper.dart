import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/movie_moviedb.dart';

///OBJETIVO DEL MAPPER:
///Es transformar la información de lo que traemos, en este caso movieDB 
///en nuestra entidad, es una capa de protección
///Como lo que hice en dandy sin saberlo xd

class MovieMapper {

  static Movie movieDBToEntity(MovieMovieDB moviedb) => Movie(
    adult: moviedb.adult, 
    backdropPath: (moviedb.backdropPath != '')
    ? 'https://image.tmdb.org/t/p/w500${moviedb.backdropPath}'
    : 'https://t3.ftcdn.net/jpg/04/62/93/66/360_F_462936689_BpEEcxfgMuYPfTaIAOC1tCDurmsno7Sp.jpg', 
    genreIds: moviedb.genreIds.map((e) => e.toString()).toList(), 
    id: moviedb.id, 
    originalLanguage: moviedb.originalLanguage, 
    originalTitle: moviedb.originalTitle, 
    overview: moviedb.overview, 
    popularity: moviedb.popularity, 
    posterPath: (moviedb.backdropPath != '') 
    ? 'https://image.tmdb.org/t/p/w500${moviedb.backdropPath}'
    : 'no-poster', 
    releaseDate: moviedb.releaseDate, 
    title: moviedb.title, 
    video: moviedb.video, 
    voteAverage: moviedb.voteAverage, 
    voteCount: moviedb.voteCount
  );               
}