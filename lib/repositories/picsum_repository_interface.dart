import 'package:wallcraft/models/images.dart';

abstract class IPicSumRepository{
  static const baseUrl = 'https://picsum.photos/v2/list';
  static const imagesPerPage = 20;

  Future<Images> getImagesByPage(int page);
}