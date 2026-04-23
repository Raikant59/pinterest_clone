import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';

class HomeFeedLoadingGrid extends StatelessWidget {
  const HomeFeedLoadingGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final heights = [320.0, 220.0, 250.0, 300.0, 210.0, 280.0, 240.0, 330.0];

    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 100),
      sliver: SliverMasonryGrid.count(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
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
    return Shimmer.fromColors(
      baseColor: const Color(0xFFE8E8E8),
      highlightColor: const Color(0xFFF7F7F7),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Container(
          height: height,
          color: Colors.white,
        ),
      ),
    );
  }
}