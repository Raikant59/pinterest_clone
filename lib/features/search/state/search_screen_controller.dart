import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/search_repository.dart';
import 'search_screen_state.dart';

final searchRepositoryProvider = Provider<SearchRepository>((ref) {
  return SearchRepository();
});

final searchScreenControllerProvider =
NotifierProvider<SearchScreenController, SearchScreenState>(
  SearchScreenController.new,
);

class SearchScreenController extends Notifier<SearchScreenState> {
  @override
  SearchScreenState build() {
    Future.microtask(loadData);
    return const SearchScreenState();
  }

  Future<void> loadData() async {
    if (state.isInitialLoading || state.boardItems.isNotEmpty) return;

    state = state.copyWith(
      isInitialLoading: true,
      clearError: true,
    );

    try {
      final items = await ref.read(searchRepositoryProvider).fetchSearchFeed();

      final featured = items.take(7).toList();
      final boards = items.skip(7).toList();

      state = state.copyWith(
        isInitialLoading: false,
        featuredItems: featured,
        boardItems: boards,
      );
    } catch (error) {
      state = state.copyWith(
        isInitialLoading: false,
        errorMessage: error.toString(),
      );
    }
  }
}