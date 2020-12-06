import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallcraft/bloc/picsum_state.dart';
import 'package:wallcraft/models/images.dart';
import 'package:wallcraft/repositories/http_exception.dart';

import '../controllers/home_controller.dart';

class PicSumCubit extends Cubit<PicSumState> {
  ScrollController scrollController;

  PicSumCubit()
      : super(PicSumState(
            images: Images(list: []), isLoading: true, pageCount: 1)) {
    scrollController = ScrollController(initialScrollOffset: 5.0)
      ..addListener(_scrollListener);
    getImages();
  }

  void getImages() {
    final HomeController _homeController = HomeController();
    _homeController.fetchImagesByPage(state.pageCount).then((images) {
      emit(state.copyWith(
          images: Images(list: [...state.images.list, ...images.list]),
          isLoading: false,
          pageCount: state.pageCount + 1));
    }).catchError((error) {
      if(error is HTTPException) {
        emit(PicSumState(errorCode: error.code));
      } else {
        emit(PicSumState(errorCode: 500));
      }
    });
  }

  void changeFavorites(int index) {
    var newImage = state.images.list[index].copyWith(
        id: state.images.list[index].id,
        author: state.images.list[index].author,
        height: state.images.list[index].height,
        width: state.images.list[index].width,
        downloadUrl: state.images.list[index].downloadUrl,
        isFavorited: !state.images.list[index].isFavorited);
    state.images.list.replaceRange(index, index + 1, [newImage]);
    emit(state.copyWith(images: Images(list: state.images.list)));
  }

  _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      getImages();
    }
  }
}
