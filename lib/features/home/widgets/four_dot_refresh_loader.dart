import 'dart:math' as math;
import 'package:flutter/material.dart';

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
    final orbit = widget.size * 0.22;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final rotation = 2 * math.pi * _controller.value;

        return Container(
          width: widget.size+2,
          height: widget.size+2,
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
                  width: widget.dotSize,
                  height: widget.dotSize,
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