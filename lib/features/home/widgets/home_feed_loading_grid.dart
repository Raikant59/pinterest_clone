import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';
import '../../../utils/app_responsive.dart';

class HomeFeedLoadingGrid extends StatelessWidget {
  const HomeFeedLoadingGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final double scale = AppResponsive.scale(context).clamp(0.9, 1.08);

    final heights = [
      320.0 * scale,
      220.0 * scale,
      250.0 * scale,
      300.0 * scale,
      210.0 * scale,
      280.0 * scale,
      240.0 * scale,
      330.0 * scale,
    ];

    return SliverPadding(
      padding: EdgeInsets.fromLTRB(
        AppResponsive.w(context, 8).clamp(6.0, 10.0),
        0,
        AppResponsive.w(context, 8).clamp(6.0, 10.0),
        AppResponsive.h(context, 100).clamp(84.0, 110.0),
      ),
      sliver: SliverMasonryGrid.count(
        crossAxisCount: 2,
        mainAxisSpacing: AppResponsive.w(context, 10).clamp(8.0, 12.0),
        crossAxisSpacing: AppResponsive.w(context, 10).clamp(8.0, 12.0),
        childCount: 12,
        itemBuilder: (context, index) {
          return _ShimmerPinCard(
            height: heights[index % heights.length],
          );
        },
      ),
    );
  }
}

class _ShimmerPinCard extends StatelessWidget {
  const _ShimmerPinCard({required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    final double radius =
    AppResponsive.r(context, 28).clamp(22.0, 30.0);

    return Shimmer.fromColors(
      baseColor: const Color(0xFFE8E8E8),
      highlightColor: const Color(0xFFF7F7F7),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Container(
          height: height,
          color: Colors.white,
        ),
      ),
    );
  }
}