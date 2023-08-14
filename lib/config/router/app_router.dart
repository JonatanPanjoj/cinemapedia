import 'package:go_router/go_router.dart';

import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:cinemapedia/presentation/views/views.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes:[

    ShellRoute(
      builder: (context, state, child) {
        return HomeScreen(childView: child);
      },
      routes: [
        GoRoute(
          path: '/',
          builder:(context, state) {
            return const HomeView();
          },
          routes: [
            GoRoute(
              // Sin el primer slash, porque lo da el padre
              path: 'movie/:id',
              name: MovieScreen.name,
              builder: (context, state) {
                final movieId = state.pathParameters['id'] ?? 'no-id';
                return MovieScreen(movieId: movieId);
              },
            ),
          ]
        ),
        GoRoute(
          path: '/favorites',
          builder:(context, state) {
            return const FavoritesView();
          },
        ),

      ]
    ),

    //RUTAS PADRE/HIJA
    // GoRoute(
    //   path: '/',
    //   name: HomeScreen.name,
    //   builder: (context, state) => const HomeScreen(childView: FavoritesView(),),
    //   //Ponemos estos routes para que cuando hagamos deep-linking
    //   //podamos saber cual es el padre y poder regresar
    //   routes: [
    //     GoRoute(
    //       // Sin el primer slash, porque lo da el padre
    //       path: 'movie/:id',
    //       name: MovieScreen.name,
    //       builder: (context, state) {
    //         final movieId = state.pathParameters['id'] ?? 'no-id';
    //         return MovieScreen(movieId: movieId);
    //       },
    //     ),
    //   ]
    // ),
    
  ]
);