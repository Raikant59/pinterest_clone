// import 'package:dio/dio.dart';
//
// import '../../../config/pexels_config.dart';
// import '../model/search_board_item.dart';
//
// class SearchRepository {
//   SearchRepository()
//       : _dio = Dio(
//     BaseOptions(
//       baseUrl: PexelsConfig.baseUrl,
//       headers: const {
//         'Authorization': PexelsConfig.apiKey,
//       },
//       connectTimeout: const Duration(seconds: 15),
//       receiveTimeout: const Duration(seconds: 15),
//     ),
//   );
//
//   final Dio _dio;
//
//   Future<List<SearchBoardItem>> fetchSearchFeed() async {
//     final response = await _dio.get(
//       '/search',
//       queryParameters: {
//         'query': 'aesthetic food room art fashion wallpaper ideas',
//         'per_page': 18,
//         'page': 1,
//       },
//     );
//
//     final data = response.data as Map<String, dynamic>;
//     final photos = (data['photos'] as List<dynamic>? ?? []);
//
//     final titles = [
//       'Matching aesthetic for couples and besties',
//       'Golden hour aesthetic',
//       'Vegetarian recipes to make on repeat',
//       'Cozy workspace ideas',
//       'Warm room inspiration',
//       'Neutral desk setup ideas',
//       'Fashion mood board',
//       'Minimal photography ideas',
//       'Comfort food ideas',
//       'Soft girl aesthetic',
//       'Laptop setup aesthetic',
//       'Cute illustration ideas',
//     ];
//
//     return List.generate(photos.length, (index) {
//       final photo = photos[index] as Map<String, dynamic>;
//       final src = photo['src'] as Map<String, dynamic>? ?? {};
//
//       return SearchBoardItem(
//         id: photo['id'] as int,
//         imageUrl: (src['large2x'] ?? src['large'] ?? src['medium'] ?? '') as String,
//         title: titles[index % titles.length],
//         subtitle: index % 2 == 0 ? 'Aesthetics' : 'Ideas',
//         meta: '${35 + index} Pins · ${index + 1}y',
//       );
//     });
//   }
// }
import 'package:dio/dio.dart';

import '../../../config/pexels_config.dart';
import '../model/search_board_item.dart';

class SearchRepository {
  SearchRepository()
      : _dio = Dio(
    BaseOptions(
      baseUrl: PexelsConfig.baseUrl,
      headers: const {
        'Authorization': PexelsConfig.apiKey,
      },
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    ),
  );

  final Dio _dio;

  Future<List<SearchBoardItem>> fetchSearchFeed() async {
    final response = await _dio.get(
      '/search',
      queryParameters: {
        'query': 'aesthetic food room art fashion wallpaper ideas',
        'per_page': 18,
        'page': 1,
      },
    );

    final data = response.data as Map<String, dynamic>;
    final photos = (data['photos'] as List<dynamic>? ?? []);

    final titles = [
      'Matching aesthetic for couples and besties',
      'Golden hour aesthetic',
      'Vegetarian recipes to make on repeat',
      'Cozy workspace ideas',
      'Warm room inspiration',
      'Neutral desk setup ideas',
      'Fashion mood board',
      'Minimal photography ideas',
      'Comfort food ideas',
      'Soft girl aesthetic',
      'Laptop setup aesthetic',
      'Cute illustration ideas',
    ];

    return List.generate(photos.length, (index) {
      final photo = photos[index] as Map<String, dynamic>;
      final src = photo['src'] as Map<String, dynamic>? ?? {};

      return SearchBoardItem(
        id: photo['id'] as int,
        imageUrl: (src['large2x'] ?? src['large'] ?? src['medium'] ?? '') as String,
        title: titles[index % titles.length],
        subtitle: index % 2 == 0 ? 'Aesthetics' : 'Ideas',
        meta: '${35 + index} Pins · ${index + 1}y',
      );
    });
  }

  Future<List<SearchCollageSection>> fetchCollageSections() async {
    final queries = [
      ('car wallpapers', 'cars wallpaper sports car porsche bmw'),
      ('god photos', 'hindu god temple devotional spiritual'),
      ('easy drawings', 'easy drawing sketch cute doodle'),
      ('anime wallpapers', 'anime wallpaper illustration'),
      ('nature aesthetic', 'nature aesthetic sunset sky forest'),
    ];

    final List<SearchCollageSection> sections = [];

    for (final entry in queries) {
      final response = await _dio.get(
        '/search',
        queryParameters: {
          'query': entry.$2,
          'per_page': 4,
          'page': 1,
        },
      );

      final data = response.data as Map<String, dynamic>;
      final photos = (data['photos'] as List<dynamic>? ?? []);

      final imageUrls = photos.map((photo) {
        final item = photo as Map<String, dynamic>;
        final src = item['src'] as Map<String, dynamic>? ?? {};
        return (src['large'] ?? src['medium'] ?? src['small'] ?? '') as String;
      }).toList();

      sections.add(
        SearchCollageSection(
          smallTitle: sections.isEmpty ? 'Ideas for you' : 'Popular on Pinterest',
          title: entry.$1,
          imageUrls: imageUrls,
        ),
      );
    }

    return sections;
  }
}