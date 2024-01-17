import 'package:flutter/material.dart';

import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:cinemapedia/presentation/views/views.dart';

class HomeScreen extends StatefulWidget {

  static const name = 'home-screen';
  final int pageIndex;

  const HomeScreen({
    super.key, 
    required this.pageIndex
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {
  
  final viewRoutes = const <Widget>[
    HomeView(),
    PopularView(),
    FavoritesView()
  ];
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(
      keepPage: true
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if(pageController.hasClients){
      pageController.animateToPage(
        widget.pageIndex, 
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 250), 
      );
    }



    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: viewRoutes
      ),
      bottomNavigationBar: CustomBottomNavigation(currentIndex:widget.pageIndex),
    );
  }
  
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
