import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../features/home/model/home_feed_item.dart';

class PinDetailScreen extends StatelessWidget {
  final HomeFeedItem item;
  final List<HomeFeedItem> relatedItems;

  const PinDetailScreen({
    super.key,
    required this.item,
    required this.relatedItems,
  });

  String _buildTitle() {
    if (item.alt.trim().isNotEmpty) {
      return item.alt.trim();
    }

    if (item.photographer.trim().isNotEmpty) {
      return '${item.photographer.trim()} inspiration';
    }

    return 'Creative pin';
  }

  String _buildCreatorName() {
    if (item.photographer.trim().isNotEmpty) {
      return item.photographer.trim();
    }
    return 'Pinterest creator';
  }

  @override
  Widget build(BuildContext context) {
    final title = _buildTitle();
    final creator = _buildCreatorName();

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F4),
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _PinHeroSection(item: item),
                    const SizedBox(height: 14),
                    _PinActionRow(),
                    const SizedBox(height: 16),
                    _CreatorRow(creatorName: creator),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          height: 1.1,
                          letterSpacing: -0.7,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        'More to explore',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          letterSpacing: -0.4,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 28),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    final related = relatedItems[index];
                    return _RelatedPinCard(item: related);
                  },
                  childCount: relatedItems.length,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.72,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PinHeroSection extends StatelessWidget {
  final HomeFeedItem item;

  const _PinHeroSection({
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(26),
      child: Stack(
        children: [
          AspectRatio(
            aspectRatio: item.aspectRatio == 0 ? 1 : item.aspectRatio,
            child: CachedNetworkImage(
              imageUrl: item.imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) {
                return Shimmer.fromColors(
                  baseColor: const Color(0xFFEAEAEA),
                  highlightColor: const Color(0xFFF7F7F7),
                  child: Container(color: Colors.white),
                );
              },
              errorWidget: (context, url, error) {
                return Container(
                  color: const Color(0xFFEAEAEA),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.broken_image_outlined,
                    size: 42,
                    color: Colors.grey,
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: 14,
            left: 14,
            child: _TopCircleIcon(
              icon: Icons.arrow_back_ios_new,
              onTap: () => Navigator.pop(context),
            ),
          ),
          Positioned(
            right: 12,
            bottom: 10,
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.96),
                borderRadius: BorderRadius.circular(18),
              ),
              alignment: Alignment.center,
              child: const Icon(
                Icons.search_outlined,
                size: 24,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TopCircleIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _TopCircleIcon({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withOpacity(0.72),
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: SizedBox(
          width: 48,
          height: 48,
          child: Icon(
            icon,
            size: 24,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

class _PinActionRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          const Icon(Icons.favorite_border, size: 21, color: Colors.black),
          const SizedBox(width: 10),
          const Text(
            '23',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 26),
          const Icon(Icons.mode_comment_outlined, size: 21, color: Colors.black),
          const SizedBox(width: 26),
          const Icon(Icons.share_outlined, size: 21, color: Colors.black),
          const SizedBox(width: 26),
          const Icon(Icons.more_horiz, size: 21, color: Colors.black),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFE60023),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Text(
              'Save',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CreatorRow extends StatelessWidget {
  final String creatorName;

  const _CreatorRow({
    required this.creatorName,
  });

  @override
  Widget build(BuildContext context) {
    final letter = creatorName.isNotEmpty ? creatorName[0].toUpperCase() : 'P';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              color: Color(0xFF5A69C7),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              letter,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              creatorName,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: const Color(0xFFE9E9E2),
              borderRadius: BorderRadius.circular(14),
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.keyboard_arrow_down,
              size: 18,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class _RelatedPinCard extends StatelessWidget {
  final HomeFeedItem item;

  const _RelatedPinCard({
    required this.item,
  });

  String _title() {
    if (item.alt.trim().isNotEmpty) return item.alt.trim();
    if (item.photographer.trim().isNotEmpty) {
      return '${item.photographer.trim()} idea';
    }
    return 'Creative inspiration';
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: Stack(
        children: [
          Positioned.fill(
            child: CachedNetworkImage(
              imageUrl: item.imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) {
                return Shimmer.fromColors(
                  baseColor: const Color(0xFFEAEAEA),
                  highlightColor: const Color(0xFFF7F7F7),
                  child: Container(color: Colors.white),
                );
              },
              errorWidget: (context, url, error) {
                return Container(
                  color: const Color(0xFFEAEAEA),
                  alignment: Alignment.center,
                  child: const Icon(Icons.broken_image_outlined),
                );
              },
            ),
          ),
          Positioned(
            left: 12,
            right: 12,
            bottom: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.28),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                _title(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  height: 1.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}