import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pinterest_clone/routes/routes.dart';

class Loader extends StatefulWidget {
  const Loader({super.key});

  @override
  State<Loader> createState() => _LoaderState();
}

class _LoaderState extends State<Loader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  final List<Color> _rotationColors = const [
    Color(0xFFE60023), // red
    Color(0xFF8E44AD), // purple
    Color(0xFF1E88E5), // blue
  ];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  int getCurrentRotationIndex() {
    final int completedRotations =
        (_controller.lastElapsedDuration?.inMilliseconds ?? 0) ~/
            _controller.duration!.inMilliseconds;

    return completedRotations % _rotationColors.length;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 20,
        height: 20,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final double progress = _controller.value;
            final double rotationAngle = 2 * pi * progress;

            const double orbitRadius = 13;
            const double dotSize = 8;

            final Color currentColor =
            _rotationColors[getCurrentRotationIndex()];

            return SizedBox(
              width: 15,
              height: 15,
              child: Stack(
                alignment: Alignment.center,
                children: List.generate(3, (index) {
                  final double angle = rotationAngle + (index * 2 * pi / 3);

                  final double dx = orbitRadius * cos(angle);
                  final double dy = orbitRadius * sin(angle);

                  return Transform.translate(
                    offset: Offset(dx, dy),
                    child: Container(
                      width: dotSize,
                      height: dotSize,
                      decoration: BoxDecoration(
                        color: currentColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                }),
              ),
            );
          },
        ),
      );
  }
}