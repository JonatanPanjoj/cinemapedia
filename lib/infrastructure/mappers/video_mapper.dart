import 'package:cinemapedia/infrastructure/models/moviedb/moviedb_videos.dart';
import 'package:cinemapedia/domain/entities/entities.dart';

class VideoMapper {

  static moviedbVideoToEntity( Result moviedbVideo ) => Video(
    id: moviedbVideo.id, 
    name: moviedbVideo.name, 
    youtubeKey: moviedbVideo.key,
    publishedAt: moviedbVideo.publishedAt
  );


}