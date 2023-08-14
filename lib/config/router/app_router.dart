import 'package:go_router/go_router.dart';

import 'package:cinemapedia/presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/home/0',
  routes:[
    GoRoute(
      path: '/home/:page',
      name: HomeScreen.name,
      builder: (context, state) {
        final pageIndex = int.parse(state.pathParameters['page'] ?? '0');
        return  HomeScreen(pageIndex: pageIndex,);
      },
      //Ponemos estos routes para que cuando hagamos deep-linking
      //podamos saber cual es el padre y poder regresar
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
      path: '/',
      redirect: (_,__) =>  '/home/0',
    )
    
  ]
);