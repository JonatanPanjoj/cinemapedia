import 'dart:async';
import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';

import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?>{

  final SearchMoviesCallback searchMovies;
  List<Movie> initialMovies;
  StreamController<List<Movie>> debouncedMovies = StreamController.broadcast();
  StreamController<bool> isLoadingStream = StreamController.broadcast();
  Timer? _debounceTimer;

  SearchMovieDelegate({
    required this.searchMovies,
    required this.initialMovies
  });

  void _onQueryChange(String query) {
    isLoadingStream.add(true);
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    
    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      final movies = await searchMovies( query );

      initialMovies = movies;
      debouncedMovies.add(movies);
      isLoadingStream.add(false);

    });
  }

  void clearStreams(){
    debouncedMovies.close();
    isLoadingStream.close();
  }

    Widget _buildResultsAndSuggestions() {
      return StreamBuilder(
      initialData: initialMovies,
      stream: debouncedMovies.stream,
      builder:(context, snapshot) {
        final movies = snapshot.data ?? [];
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder:(context, index) => _MovieItem(
            movie: movies[index],
            onMovieSelected:(context,movie){
              clearStreams();
              close(context,movie);
            } ,
          )
        );
      },
    );
  }

  @override
  String get searchFieldLabel => 'Buscar Pelicula';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [

      StreamBuilder(
        initialData: false,
        stream: isLoadingStream.stream,
        builder:(context, snapshot) {
          if(snapshot.data ?? false){
            return SpinPerfect(
              duration: const Duration(seconds: 20),
              spins: 10,
              infinite: true,
              child: IconButton(
              onPressed: ()=> query = '',
              icon: const Icon(Icons.timelapse_rounded)),
            );
          }
          return FadeIn(
            animate: query.isNotEmpty,
            duration: const Duration(milliseconds: 200),
            child: IconButton(
            onPressed: ()=> query = '',
            icon: const Icon(Icons.clear_rounded)),
          );
          },
      )

      
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
    onPressed:() {
      clearStreams();
      return close(context, null);
    }, 
    icon: const Icon(Icons.arrow_back_ios_new));
    
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildResultsAndSuggestions();

  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChange(query);
    return _buildResultsAndSuggestions();
  }

  

}

class _MovieItem extends StatelessWidget {

  final Movie movie;
  final Function onMovieSelected;

  const _MovieItem({
    required this.movie, 
    required this.onMovieSelected
  });

  @override
  Widget build(BuildContext context) {

    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: (){
        onMovieSelected(context,movie);
      } ,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            SizedBox(
              width: size.width * 0.20,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FadeInImage(
                  height: 130,
                  fit: BoxFit.cover,
                  image: NetworkImage(movie.posterPath),
                  placeholder: const AssetImage('assets/loaders/bottle-loader.gif'),
                ),
              ),
            ),
    
            const SizedBox(width: 10,),
    
            SizedBox(
              width: size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title, style: textStyles.titleMedium,),
                  ( movie.overview.length > 100)
                    ? Text('${movie.overview.substring(0,100)}...')
                    : Text(movie.overview),
    
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow.shade800,),
                      const SizedBox(width: 5,),
                      Text(
                        HumanFormats.number(movie.voteAverage, 1),
                        style: textStyles.bodyMedium!.copyWith(color: Colors.yellow.shade900),
                      )
                    ],
                  )
    
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}