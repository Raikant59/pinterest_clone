import 'package:flutter/material.dart';
import '../../../utils/app_responsive.dart';

class ProgressDots extends StatelessWidget {
  final int filledCount;
  final int outlinedIndex;
  final int total;

  const ProgressDots({
    super.key,
    required this.filledCount,
    required this.outlinedIndex,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final double rowHeight =
    AppResponsive.h(context, 18).clamp(16.0, 20.0);
    final double dotSize =
    AppResponsive.r(context, 11).clamp(9.0, 12.0);
    final double horizontalGap =
    AppResponsive.w(context, 5).clamp(3.5, 6.0);
    final double outlinedBorderWidth =
    AppResponsive.r(context, 2.2).clamp(1.8, 2.4);

    return SizedBox(
      height: rowHeight,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(total, (index) {
          final bool isFilled = index < filledCount;
          final bool isOutlined = index == outlinedIndex;

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalGap),
            child: Container(
              width: dotSize,
              height: dotSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isFilled
                    ? Colors.black
                    : isOutlined
                    ? Colors.white
                    : const Color(0xFF87877F),
                border: Border.all(
                  color: isOutlined ? Colors.black : Colors.transparent,
                  width: isOutlined ? outlinedBorderWidth : 0,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}