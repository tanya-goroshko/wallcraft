import 'package:equatable/equatable.dart';
import 'package:wallcraft/models/images.dart';

class PicSumState extends Equatable {
  final Images images;
  final bool isLoading;
  final int pageCount;

  PicSumState({this.images, this.isLoading, this.pageCount});

  PicSumState copyWith({
    Images images,
    bool isLoading,
    int pageCount,
  }) =>
      PicSumState(
          images: images ?? this.images,
          isLoading: isLoading ?? this.isLoading,
          pageCount: pageCount ?? this.pageCount);

  @override
  List<Object> get props => [images, isLoading, pageCount];
}