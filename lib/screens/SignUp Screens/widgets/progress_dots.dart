import 'package:flutter/material.dart';

class ProgressDots extends StatelessWidget {
  final int filledCount;
  final int outlinedIndex;
  final int total;

  const ProgressDots({
    required this.filledCount,
    required this.outlinedIndex,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 18,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(total, (index) {
          final bool isFilled = index < filledCount;
          final bool isOutlined = index == outlinedIndex;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Container(
              width: 11,
              height: 11,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isFilled
                    ? Colors.black
                    : isOutlined
                    ? Colors.white
                    : const Color(0xFF87877F),
                border: Border.all(
                  color: isOutlined ? Colors.black : Colors.transparent,
                  width: isOutlined ? 2.2 : 0,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}