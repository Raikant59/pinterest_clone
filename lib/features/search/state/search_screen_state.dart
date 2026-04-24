import '../model/search_board_item.dart';

class SearchScreenState {
  final bool isInitialLoading;
  final List<SearchBoardItem> featuredItems;
  final List<SearchBoardItem> boardItems;
  final String? errorMessage;

  const SearchScreenState({
    this.isInitialLoading = false,
    this.featuredItems = const [],
    this.boardItems = const [],
    this.errorMessage,
  });

  SearchScreenState copyWith({
    bool? isInitialLoading,
    List<SearchBoardItem>? featuredItems,
    List<SearchBoardItem>? boardItems,
    String? errorMessage,
    bool clearError = false,
  }) {
    return SearchScreenState(
      isInitialLoading: isInitialLoading ?? this.isInitialLoading,
      featuredItems: featuredItems ?? this.featuredItems,
      boardItems: boardItems ?? this.boardItems,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}