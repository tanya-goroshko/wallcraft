import 'package:wallcraft/models/image.dart';

class Images {
  final List<Image> list;

  Images({this.list});

  factory Images.fromJson(List<dynamic> json) {
    List<Image> list = new List();
    json.forEach((el) {
      Image image = Image(
          id: el['id'].toString(),
          author: el['author'].toString(),
          width: el['width'],
          height: el['height'],
          downloadUrl: el['download_url'].toString(),
          isFavorited: false);
      list.add(image);
    });

    return Images(list: list);
  }
}
