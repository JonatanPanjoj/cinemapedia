import 'package:flutter/material.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories Tab'),
      ),
      body: Center(
        child: Text('Categories Screen'),
      ),
    );
  }
}