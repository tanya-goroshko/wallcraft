import 'package:flutter/material.dart';
import 'package:wallcraft/models/images.dart';

class FavoritesPage extends StatelessWidget {
  FavoritesPage({this.images});

  final Images images;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: GridView.count(
          crossAxisCount: 3,
          children: List.generate(images.list.length, (index) {
            return Center(child: Image.network(images.list[index].downloadUrl));
          })),
    );
  }
}
