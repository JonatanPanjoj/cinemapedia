import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/presentation/providers/movies/movies_providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {

  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView()
    );
  }
}
//PARA TENER ACCESO AL REF
//----------1-----------ConsumerStatefulWidget
class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();
//_HomeViewState-----------3------------------->
  @override
  _HomeViewState createState() => _HomeViewState();
}
//--------------2------------ConsumerState
class _HomeViewState extends ConsumerState<_HomeView> {

  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();

  }

  @override
  Widget build(BuildContext context) {

    // final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final slideShowMovies = ref.watch(moviesSlideshowProvider);

    return Column(
      children: [

        const CustomAppBar(),
        MoviesSlideshow(movies: slideShowMovies)
      ],
    );
  }
}