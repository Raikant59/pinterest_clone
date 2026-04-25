import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../utils/app_responsive.dart';

class FourDotRefreshLoader extends StatefulWidget {
  const FourDotRefreshLoader({
    super.key,
    this.size = 36,
    this.dotSize = 7,
  });

  final double size;
  final double dotSize;

  @override
  State<FourDotRefreshLoader> createState() => _FourDotRefreshLoaderState();
}

class _FourDotRefreshLoaderState extends State<FourDotRefreshLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  final List<Color> _colors = const [
    Color(0xFF8B8B84),
    Color(0xFF111111),
    Color(0xFF8B8B84),
    Color(0xFFB9B9B1),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color _colorAt(int index) {
    return _colors[index % _colors.length];
  }

  @override
  Widget build(BuildContext context) {
    final double responsiveSize =
    AppResponsive.r(context, widget.size).clamp(28.0, 42.0);
    final double responsiveDotSize =
    AppResponsive.r(context, widget.dotSize).clamp(5.0, 8.0);
    final double orbit = responsiveSize * 0.22;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final rotation = 2 * math.pi * _controller.value;

        return Container(
          width: responsiveSize + 2,
          height: responsiveSize + 2,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: List.generate(4, (index) {
              final angle = rotation + (index * 2 * math.pi / 4);

              return Transform.translate(
                offset: Offset(
                  orbit * math.cos(angle),
                  orbit * math.sin(angle),
                ),
                child: Container(
                  width: responsiveDotSize,
                  height: responsiveDotSize,
                  decoration: BoxDecoration(
                    color: _colorAt(index),
                    shape: BoxShape.circle,
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}