class HomeFeedItem {
  final int id;
  final String imageUrl;
  final String mediumImageUrl;
  final String thumbnailUrl;
  final int width;
  final int height;
  final String photographer;
  final String photographerUrl;
  final String alt;

  const HomeFeedItem({
    required this.id,
    required this.imageUrl,
    required this.mediumImageUrl,
    required this.thumbnailUrl,
    required this.width,
    required this.height,
    required this.photographer,
    required this.photographerUrl,
    required this.alt,
  });

  factory HomeFeedItem.fromJson(Map<String, dynamic> json) {
    final src = json['src'] as Map<String, dynamic>? ?? {};

    return HomeFeedItem(
      id: json['id'] as int,
      imageUrl: (src['large2x'] ?? src['large'] ?? src['original'] ?? '') as String,
      mediumImageUrl: (src['medium'] ?? src['large'] ?? '') as String,
      thumbnailUrl: (src['tiny'] ?? src['small'] ?? '') as String,
      width: (json['width'] ?? 1) as int,
      height: (json['height'] ?? 1) as int,
      photographer: (json['photographer'] ?? '') as String,
      photographerUrl: (json['photographer_url'] ?? '') as String,
      alt: (json['alt'] ?? '') as String,
    );
  }

  double get aspectRatio {
    if (width == 0 || height == 0) return 1;
    return width / height;
  }

  double get displayHeightFactor {
    final ratio = aspectRatio;
    if (ratio > 1.3) return 0.72;
    if (ratio > 1.0) return 0.88;
    if (ratio > 0.8) return 1.0;
    if (ratio > 0.65) return 1.18;
    return 1.32;
  }
}