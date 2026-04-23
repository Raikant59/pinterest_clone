import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/home_repository.dart';
import '../data/pexel_home_api.dart';
import 'home_feed_state.dart';

final pexelsHomeApiProvider = Provider<PexelsHomeApi>((ref) {
  return PexelsHomeApi();
});

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  return HomeRepository(ref.read(pexelsHomeApiProvider));
});

final homeFeedControllerProvider =
NotifierProvider<HomeFeedController, HomeFeedState>(
  HomeFeedController.new,
);

class HomeFeedController extends Notifier<HomeFeedState> {
  @override
  HomeFeedState build() {
    Future.microtask(loadInitial);
    return const HomeFeedState();
  }

  Future<void> loadInitial() async {
    if (state.isInitialLoading || state.items.isNotEmpty) return;

    state = state.copyWith(
      isInitialLoading: true,
      clearError: true,
    );

    try {
      final items = await ref.read(homeRepositoryProvider).getHomeFeed(page: 1);

      state = state.copyWith(
        items: items,
        isInitialLoading: false,
        page: 1,
        hasMore: items.isNotEmpty,
      );
    } catch (error) {
      state = state.copyWith(
        isInitialLoading: false,
        errorMessage: error.toString(),
      );
    }
  }

  Future<void> refreshFeed() async {
    if (state.isRefreshing) return;

    state = state.copyWith(
      isRefreshing: true,
      clearError: true,
    );

    try {
      final items = await ref.read(homeRepositoryProvider).getHomeFeed(page: 1);

      state = state.copyWith(
        items: items,
        isRefreshing: false,
        page: 1,
        hasMore: items.isNotEmpty,
      );
    } catch (error) {
      state = state.copyWith(
        isRefreshing: false,
        errorMessage: error.toString(),
      );
    }
  }

  Future<void> loadMore() async {
    if (state.isInitialLoading ||
        state.isRefreshing ||
        state.isLoadingMore ||
        !state.hasMore) {
      return;
    }

    state = state.copyWith(isLoadingMore: true);

    try {
      final nextPage = state.page + 1;
      final nextItems = await ref.read(homeRepositoryProvider).getHomeFeed(
        page: nextPage,
      );

      state = state.copyWith(
        items: [...state.items, ...nextItems],
        isLoadingMore: false,
        page: nextPage,
        hasMore: nextItems.isNotEmpty,
      );
    } catch (error) {
      state = state.copyWith(
        isLoadingMore: false,
        errorMessage: error.toString(),
      );
    }
  }
}