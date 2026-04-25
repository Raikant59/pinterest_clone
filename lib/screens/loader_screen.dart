import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../utils/app_responsive.dart';

class LoaderScreen extends StatefulWidget {
  const LoaderScreen({super.key});

  @override
  State<LoaderScreen> createState() => _LoaderScreenState();
}

class _LoaderScreenState extends State<LoaderScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  final List<Color> _colors = const [
    Color(0xFFE60023),
    Color(0xFF111111),
    Color(0xFF87877F),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color _animatedColor(double t, int index) {
    final shifted = (t + index / 3) % 1.0;
    if (shifted < 1 / 3) {
      return Color.lerp(_colors[0], _colors[0], shifted * 3)!;
    } else if (shifted < 2 / 3) {
      return Color.lerp(_colors[1], _colors[1], (shifted - 1 / 3) * 3)!;
    }
    return Color.lerp(_colors[2], _colors[2], (shifted - 2 / 3) * 3)!;
  }

  @override
  Widget build(BuildContext context) {
    final double boxSize = AppResponsive.r(context, 20).clamp(18.0, 24.0);
    final double orbit = AppResponsive.r(context, 18).clamp(14.0, 20.0);
    final double dotSize = AppResponsive.r(context, 10).clamp(8.0, 12.0);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            final t = _controller.value;

            return SizedBox(
              width: boxSize,
              height: boxSize,
              child: Stack(
                alignment: Alignment.center,
                children: List.generate(3, (index) {
                  final angle = (t * 2 * math.pi) + (index * 2 * math.pi / 3);
                  final dx = orbit * math.cos(angle);
                  final dy = orbit * math.sin(angle);

                  return Transform.translate(
                    offset: Offset(dx, dy),
                    child: Container(
                      width: dotSize,
                      height: dotSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _animatedColor(t, index),
                      ),
                    ),
                  );
                }),
              ),
            );
          },
        ),
      ),
    );
  }
}