import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallcraft/bloc/picsum_cubit.dart';
import 'package:wallcraft/bloc/picsum_state.dart';

import 'package:wallcraft/models/images.dart';
import 'package:wallcraft/widgets/favorites.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PicSumCubit cubit = PicSumCubit();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PicSumCubit, PicSumState>(
        cubit: cubit,
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                title: Text(widget.title),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.favorite),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        var list = state.images.list
                            .where((element) => element.isFavorited == true)
                            .toList();
                        return FavoritesPage(images: Images(list: list));
                      }));
                    },
                  )
                ],
              ),
              body: state.errorCode != null
                  ? Center(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.error_outline,
                          color: Colors.redAccent,
                          size: 24,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "There was an error fetching data",
                          style: TextStyle(color: Colors.redAccent),
                        )
                      ],
                    ))
                  : state.isLoading == true
                      ? Center(child: CircularProgressIndicator())
                      : GridView.count(
                          controller: cubit.scrollController,
                          crossAxisCount: 3,
                          children:
                              List.generate(state.images.list.length, (index) {
                            return Center(
                                child: Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Column(
                                      children: [
                                        Stack(
                                          children: <Widget>[
                                            FittedBox(
                                              child: Image.network(
                                                state.images.list[index]
                                                    .downloadUrl,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.4,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.4,
                                              ),
                                              fit: BoxFit.fill,
                                            ),
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: IconButton(
                                                icon: Icon(state.images
                                                        .list[index].isFavorited
                                                    ? Icons.favorite
                                                    : Icons.favorite_border),
                                                color: state.images.list[index]
                                                        .isFavorited
                                                    ? Colors.red
                                                    : null,
                                                onPressed: () => cubit
                                                    .changeFavorites(index),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    )));
                          }),
                        ));
        });
  }

  @override
  void dispose() {
    cubit.scrollController.dispose();
    super.dispose();
  }
}
