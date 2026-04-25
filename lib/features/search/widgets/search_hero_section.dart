import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../utils/app_responsive.dart';
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
    final double bannerHeight =
    AppResponsive.h(context, 350).clamp(300.0, 380.0);
    final double errorIconSize =
    AppResponsive.r(context, 28).clamp(22.0, 32.0);

    return SizedBox(
      height: bannerHeight,
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
                      child: Icon(
                        Icons.broken_image_outlined,
                        size: errorIconSize,
                      ),
                    );
                  },
                ),
                Container(
                  color: Colors.black.withOpacity(0.28),
                ),
                const Positioned.fill(
                  child: Center(
                    child: _BannerText(),
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
    final double horizontalPadding =
    AppResponsive.w(context, 34).clamp(24.0, 38.0);
    final double subtitleSize =
    AppResponsive.sp(context, 15).clamp(13.0, 16.0);
    final double subtitleGap =
    AppResponsive.h(context, 6).clamp(4.0, 8.0);
    final double titleSize =
    AppResponsive.sp(context, 20).clamp(18.0, 22.0);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'On the menu',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: subtitleSize,
              fontWeight: FontWeight.w600,
              color: Colors.white70,
            ),
          ),
          SizedBox(height: subtitleGap),
          Text(
            'Vegetarian recipes to make\non repeat',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: titleSize,
              fontWeight: FontWeight.w400,
              color: Colors.white,
              height: 1.2,
              letterSpacing: -0.4,
            ),
          ),
        ],
      ),
    );
  }
}