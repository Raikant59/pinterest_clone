import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../utils/app_responsive.dart';
import '../model/search_board_item.dart';

class IdeaBoardCard extends StatelessWidget {
  final SearchBoardItem item;

  const IdeaBoardCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final double cardRadius =
    AppResponsive.r(context, 22).clamp(18.0, 24.0);
    final double gapAfterImage =
    AppResponsive.h(context, 10).clamp(8.0, 12.0);
    final double titleSize =
    AppResponsive.sp(context, 16).clamp(14.0, 17.0);
    final double gapAfterTitle =
    AppResponsive.h(context, 3).clamp(2.0, 4.0);
    final double subtitleSize =
    AppResponsive.sp(context, 14).clamp(12.5, 15.0);
    final double checkIconSize =
    AppResponsive.r(context, 18).clamp(16.0, 20.0);
    final double rowGap =
    AppResponsive.w(context, 6).clamp(4.0, 7.0);
    final double gapAfterSubtitleRow =
    AppResponsive.h(context, 2).clamp(1.0, 3.0);
    final double metaSize =
    AppResponsive.sp(context, 13).clamp(11.5, 13.5);
    final double errorIconSize =
    AppResponsive.r(context, 24).clamp(20.0, 28.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(cardRadius),
            child: CachedNetworkImage(
              imageUrl: item.imageUrl,
              width: double.infinity,
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
          ),
        ),
        SizedBox(height: gapAfterImage),
        Text(
          item.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: titleSize,
            fontWeight: FontWeight.w700,
            color: Colors.black,
            height: 1.2,
            letterSpacing: -0.3,
          ),
        ),
        SizedBox(height: gapAfterTitle),
        Row(
          children: [
            Flexible(
              child: Text(
                item.subtitle,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: subtitleSize,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(width: rowGap),
            Icon(
              Icons.check_circle,
              size: checkIconSize,
              color: Colors.red,
            ),
          ],
        ),
        SizedBox(height: gapAfterSubtitleRow),
        Text(
          item.meta,
          style: TextStyle(
            fontSize: metaSize,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF6E6E69),
          ),
        ),
      ],
    );
  }
}