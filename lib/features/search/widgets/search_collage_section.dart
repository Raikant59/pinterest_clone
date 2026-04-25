import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../utils/app_responsive.dart';
import '../model/search_board_item.dart';

class SearchCollageSectionWidget extends StatelessWidget {
  final SearchCollageSection section;

  const SearchCollageSectionWidget({
    super.key,
    required this.section,
  });

  @override
  Widget build(BuildContext context) {
    final double outerHorizontal =
    AppResponsive.w(context, 8).clamp(6.0, 10.0);
    final double outerBottom =
    AppResponsive.h(context, 22).clamp(18.0, 24.0);
    final double innerHorizontal =
    AppResponsive.w(context, 10).clamp(8.0, 12.0);
    final double smallTitleSize =
    AppResponsive.sp(context, 12).clamp(11.0, 13.0);
    final double smallGap =
    AppResponsive.h(context, 3).clamp(2.0, 4.0);
    final double titleSize =
    AppResponsive.sp(context, 20).clamp(18.0, 22.0);
    final double searchBoxSize =
    AppResponsive.r(context, 42).clamp(38.0, 46.0);
    final double searchBoxRadius =
    AppResponsive.r(context, 16).clamp(14.0, 18.0);
    final double searchIconSize =
    AppResponsive.r(context, 26).clamp(22.0, 28.0);
    final double betweenHeaderAndCollage =
    AppResponsive.h(context, 14).clamp(10.0, 16.0);
    final double collageHeight =
    AppResponsive.h(context, 150).clamp(130.0, 165.0);
    final double collageRadius =
    AppResponsive.r(context, 24).clamp(20.0, 26.0);
    final double imageGap =
    AppResponsive.w(context, 1).clamp(0.5, 1.5);
    final double errorIconSize =
    AppResponsive.r(context, 24).clamp(20.0, 28.0);

    return Padding(
      padding: EdgeInsets.fromLTRB(
        outerHorizontal,
        0,
        outerHorizontal,
        outerBottom,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: innerHorizontal),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        section.smallTitle,
                        style: TextStyle(
                          fontSize: smallTitleSize,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: smallGap),
                      Text(
                        section.title,
                        style: TextStyle(
                          fontSize: titleSize,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                          height: 1.08,
                          letterSpacing: -0.2,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: searchBoxSize,
                  height: searchBoxSize,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8E8E2),
                    borderRadius: BorderRadius.circular(searchBoxRadius),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.search,
                    size: searchIconSize,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: betweenHeaderAndCollage),
          SizedBox(
            height: collageHeight,
            child: Row(
              children: List.generate(section.imageUrls.length, (index) {
                final imageUrl = section.imageUrls[index];

                BorderRadius radius = BorderRadius.zero;
                if (index == 0) {
                  radius = BorderRadius.only(
                    topLeft: Radius.circular(collageRadius),
                    bottomLeft: Radius.circular(collageRadius),
                  );
                } else if (index == section.imageUrls.length - 1) {
                  radius = BorderRadius.only(
                    topRight: Radius.circular(collageRadius),
                    bottomRight: Radius.circular(collageRadius),
                  );
                }

                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: index == 0 ? 0 : imageGap,
                    ),
                    child: ClipRRect(
                      borderRadius: radius,
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.cover,
                        height: double.infinity,
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
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}