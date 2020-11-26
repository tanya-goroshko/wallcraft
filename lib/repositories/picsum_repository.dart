import 'package:dio/dio.dart';
import 'package:wallcraft/models/images.dart';
import 'package:wallcraft/repositories/picsum_repository_interface.dart';

class PicSumRepository implements IPicSumRepository {
  final Dio _dio;

  PicSumRepository(this._dio);

  @override
  Future<Images> getImagesByPage(int page) async {
    var response = await _dio.get(IPicSumRepository.baseUrl,
        options: Options(responseType: ResponseType.json),
        queryParameters: {'page': page, 'limit': IPicSumRepository.imagesPerPage});

    if (response.statusCode != 200) {
      throw Exception('ooooppppppssss!!!');
    }
    
    return Images.fromJson(response.data);
  }
}
