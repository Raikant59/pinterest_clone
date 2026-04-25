import '../model/search_board_item.dart';

class SearchScreenState {
  final bool isInitialLoading;
  final List<SearchBoardItem> featuredItems;
  final List<SearchBoardItem> boardItems;
  final List<SearchCollageSection> collageSections;
  final String? errorMessage;

  const SearchScreenState({
    this.isInitialLoading = false,
    this.featuredItems = const [],
    this.boardItems = const [],
    this.collageSections = const [],
    this.errorMessage,
  });

  SearchScreenState copyWith({
    bool? isInitialLoading,
    List<SearchBoardItem>? featuredItems,
    List<SearchBoardItem>? boardItems,
    List<SearchCollageSection>? collageSections,
    String? errorMessage,
    bool clearError = false,
  }) {
    return SearchScreenState(
      isInitialLoading: isInitialLoading ?? this.isInitialLoading,
      featuredItems: featuredItems ?? this.featuredItems,
      boardItems: boardItems ?? this.boardItems,
      collageSections: collageSections ?? this.collageSections,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}