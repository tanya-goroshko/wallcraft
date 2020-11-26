import 'package:equatable/equatable.dart';

class Image extends Equatable {
  final String id;
  final String author;
  final num width;
  final num height;
  final String downloadUrl;
  final bool isFavorited;

  Image(
      {this.id,
      this.author,
      this.width,
      this.height,
      this.downloadUrl,
      this.isFavorited});

  @override
  List<Object> get props =>
      [id, author, width, height, downloadUrl, isFavorited];

  Image copyWith(
          {String id,
          String author,
          num width,
          num height,
          String downloadUrl,
          bool isFavorited}) =>
      Image(
          id: id ?? this.id,
          author: author ?? this.author,
          width: width ?? this.width,
          height: height ?? this.height,
          downloadUrl: downloadUrl ?? this.downloadUrl,
          isFavorited: isFavorited ?? this.isFavorited);
}
