class SearchBoardItem {
  final int id;
  final String imageUrl;
  final String title;
  final String subtitle;
  final String meta;

  const SearchBoardItem({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.meta,
  });
}

class SearchCollageSection {
  final String smallTitle;
  final String title;
  final List<String> imageUrls;

  const SearchCollageSection({
    required this.smallTitle,
    required this.title,
    required this.imageUrls,
  });
}