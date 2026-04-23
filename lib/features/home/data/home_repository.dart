import 'pexel_home_api.dart';
import '../model/home_feed_item.dart';

class HomeRepository {
  HomeRepository(this._api);

  final PexelsHomeApi _api;

  Future<List<HomeFeedItem>> getHomeFeed({
    required int page,
    int perPage = 20,
  }) {
    return _api.fetchCuratedPhotos(
      page: page,
      perPage: perPage,
    );
  }
}