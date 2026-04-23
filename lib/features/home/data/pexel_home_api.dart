import 'package:dio/dio.dart';
import '../../../config/pexels_config.dart';
import '../model/home_feed_item.dart';

class PexelsHomeApi {
  PexelsHomeApi()
      : _dio = Dio(
    BaseOptions(
      baseUrl: PexelsConfig.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: const {
        'Authorization': PexelsConfig.apiKey,
      },
    ),
  );

  final Dio _dio;

  Future<List<HomeFeedItem>> fetchCuratedPhotos({
    required int page,
    int perPage = 20,
  }) async {
    final response = await _dio.get(
      '/curated',
      queryParameters: {
        'page': page,
        'per_page': perPage,
      },
    );

    final data = response.data as Map<String, dynamic>;
    final photos = (data['photos'] as List<dynamic>? ?? []);

    return photos
        .map((item) => HomeFeedItem.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}