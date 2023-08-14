import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';

//PARA TENER ACCESO AL REF
//----------1-----------ConsumerStatefulWidget
class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});
//HomeViewState-----------3------------------->
  @override
  HomeViewState createState() => HomeViewState();
}
//--------------2------------ConsumerState
class HomeViewState extends ConsumerState<HomeView> {

  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();

  }

  @override
  Widget build(BuildContext context) {

    final initialLoading = ref.watch(initialLoadinProvider);
    if (initialLoading) return const FullScreenLoader();
    final slideShowMovies  = ref.watch(moviesSlideshowProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies    = ref.watch(popularMoviesProvider);
    final topRatedMovies   = ref.watch(topRatedMoviesProvider);
    final upcomingMovies   = ref.watch(upcomingMoviesProvider);

    return Visibility(
      visible: !initialLoading,
      child: CustomScrollView(
        slivers: [
          const SliverAppBar(
            centerTitle: false,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.symmetric(horizontal: 10),
              centerTitle: false,
              title: CustomAppBar(),
            ),
          ),
    
          SliverList(
            delegate: SliverChildBuilderDelegate((context,index){
              return Column(
                children: [
                  // const CustomAppBar(),
                  MoviesSlideshow(movies: slideShowMovies),
                  MovieHorizontalListview(
                    movies: nowPlayingMovies,
                    title: 'En Cines',
                    subTitle: 'Lunes 20',
                    loadNextPage: () {
                      ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
                    },
                  ),
                  MovieHorizontalListview(
                    movies: upcomingMovies,
                    title: 'Proximamente',
                    subTitle: 'Este mes',
                    loadNextPage: () => ref.read(upcomingMoviesProvider.notifier).loadNextPage()
                  ),
                  MovieHorizontalListview(
                    movies: popularMovies,
                    title: 'Populares',
                    // subTitle: '',
                    loadNextPage: () => ref.read(popularMoviesProvider.notifier).loadNextPage()
                  ),
                  MovieHorizontalListview(
                    movies: topRatedMovies,
                    title: 'Mejor Calificadas',
                    subTitle: 'Siempre',
                    loadNextPage: () => ref.read(topRatedMoviesProvider.notifier).loadNextPage()
                  ),
                ],
              );
            },
            childCount: 1
            ),
            
          )
        ]
      ),
    );
  }
}