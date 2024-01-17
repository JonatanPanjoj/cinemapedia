import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView>  with AutomaticKeepAliveClientMixin {

  bool isLastPage = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadNextPage();
  }

  void loadNextPage() async {
    if (isLoading || isLastPage) return;
    isLoading = true;

    final movies = await ref.read(favoriteMoviesProvider.notifier).loadNextPage();
    isLoading = false;

    if(movies.isEmpty){
      isLastPage = true;
    }

  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final favoriteMovies = ref.watch(favoriteMoviesProvider).values.toList();

    if(favoriteMovies.isEmpty){
      final colors = Theme.of(context).colorScheme;
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.favorite_outline_sharp, size: 60, color: colors.primary,),
            Text('Ohh no!!!', style: TextStyle( fontSize: 30, color: colors.primary),),
            const Text('No tienes peliculas Favoritas', style: TextStyle(fontSize: 20,),)
          ],
        ),
      );
    }

    return Scaffold(
      body: MovieMasonry(
        movies: favoriteMovies,
        loadNextPage: loadNextPage,
      )
    );
  }
  
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}