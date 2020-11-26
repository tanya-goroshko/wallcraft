import 'package:dio/dio.dart';
import 'package:wallcraft/repositories/picsum_repository.dart';
import 'package:wallcraft/repositories/picsum_repository_interface.dart';

import '../models/images.dart';

class HomeController {
  final IPicSumRepository _picSumRepository = PicSumRepository(Dio());

  Future<Images> fetchImagesByPage(int page) async {
    return await _picSumRepository.getImagesByPage(page);
  }
}
