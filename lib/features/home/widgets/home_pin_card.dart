import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../utils/app_responsive.dart';
import '../model/home_feed_item.dart';

class HomePinCard extends StatelessWidget {
  const HomePinCard({
    super.key,
    required this.item,
    required this.height,
    required this.onTap,
  });

  final HomeFeedItem item;
  final double height;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final double radius =
    AppResponsive.r(context, 28).clamp(22.0, 30.0);
    final double gap =
    AppResponsive.h(context, 2).clamp(1.0, 4.0);
    final double iconRightPadding =
    AppResponsive.w(context, 10).clamp(8.0, 12.0);
    final double iconSize =
    AppResponsive.r(context, 20).clamp(18.0, 22.0);
    final double errorIconSize =
    AppResponsive.r(context, 24).clamp(20.0, 28.0);

    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: SizedBox(
              height: height,
              width: double.infinity,
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
                    child: Icon(
                      Icons.image_not_supported_outlined,
                      size: errorIconSize,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: gap),
          Padding(
            padding: EdgeInsets.only(right: iconRightPadding),
            child: Icon(
              Icons.more_horiz,
              size: iconSize,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}