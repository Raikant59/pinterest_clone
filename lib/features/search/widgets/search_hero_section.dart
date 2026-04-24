import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../model/search_board_item.dart';

class SearchTopBanner extends StatelessWidget {
  final PageController controller;
  final List<SearchBoardItem> items;

  const SearchTopBanner({
    super.key,
    required this.controller,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: PageView.builder(
        controller: controller,
        itemCount: items.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final item = items[index];

          return ClipRRect(
            borderRadius: BorderRadius.circular(0),
            child: Stack(
              fit: StackFit.expand,
              children: [
                CachedNetworkImage(
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
                Container(
                  color: Colors.black.withOpacity(0.28),
                ),
                const Positioned.fill(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 34),
                      child: _BannerText(),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _BannerText extends StatelessWidget {
  const _BannerText();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Text(
          'On the menu',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.white70,
          ),
        ),
        SizedBox(height: 6),
        Text(
          'Vegetarian recipes to make\non repeat',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Colors.white,
            height: 1.2,
            letterSpacing: -0.4,
          ),
        ),
      ],
    );
  }
}