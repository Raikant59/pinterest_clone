import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../utils/app_responsive.dart';

class SearchScreenLoading extends StatelessWidget {
  const SearchScreenLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding =
    AppResponsive.w(context, 18).clamp(14.0, 22.0);
    final double topPadding =
    AppResponsive.h(context, 10).clamp(8.0, 12.0);
    final double searchBarHeight =
    AppResponsive.h(context, 72).clamp(62.0, 76.0);
    final double searchBarRadius =
    AppResponsive.r(context, 26).clamp(20.0, 28.0);
    final double gapAfterSearch =
    AppResponsive.h(context, 18).clamp(14.0, 20.0);
    final double bannerHeight =
    AppResponsive.h(context, 640).clamp(420.0, 680.0);
    final double gapAfterBanner =
    AppResponsive.h(context, 20).clamp(16.0, 22.0);
    final double smallLineWidth =
    AppResponsive.w(context, 200).clamp(150.0, 220.0);
    final double smallLineHeight =
    AppResponsive.h(context, 18).clamp(14.0, 20.0);
    final double gapAfterSmallLine =
    AppResponsive.h(context, 12).clamp(8.0, 14.0);
    final double largeLineWidth =
    AppResponsive.w(context, 260).clamp(190.0, 280.0);
    final double largeLineHeight =
    AppResponsive.h(context, 34).clamp(26.0, 38.0);
    final double gapAfterLargeLine =
    AppResponsive.h(context, 20).clamp(16.0, 22.0);
    final double cardGap =
    AppResponsive.w(context, 12).clamp(8.0, 14.0);

    return Shimmer.fromColors(
      baseColor: const Color(0xFFE9E9E9),
      highlightColor: const Color(0xFFF8F8F8),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          horizontalPadding,
          topPadding,
          horizontalPadding,
          0,
        ),
        child: Column(
          children: [
            Container(
              height: searchBarHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(searchBarRadius),
              ),
            ),
            SizedBox(height: gapAfterSearch),
            Container(
              height: bannerHeight,
              color: Colors.white,
            ),
            SizedBox(height: gapAfterBanner),
            Container(
              width: smallLineWidth,
              height: smallLineHeight,
              color: Colors.white,
            ),
            SizedBox(height: gapAfterSmallLine),
            Container(
              width: largeLineWidth,
              height: largeLineHeight,
              color: Colors.white,
            ),
            SizedBox(height: gapAfterLargeLine),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Container(color: Colors.white),
                  ),
                  SizedBox(width: cardGap),
                  Expanded(
                    child: Container(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}