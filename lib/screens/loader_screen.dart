import 'package:flutter/material.dart';
import 'dart:math' as math;

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            final t = _controller.value;
            return SizedBox(
              width: 72,
              height: 72,
              child: Stack(
                alignment: Alignment.center,
                children: List.generate(3, (index) {
                  final angle = (t * 6.28318) + (index * 2.09439);
                  final dx = 18 * (index == 0 ? 1 : 1) * Math.cos(angle);
                  final dy = 18 * Math.sin(angle);

                  return Transform.translate(
                    offset: Offset(dx, dy),
                    child: Container(
                      width: 12,
                      height: 12,
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

class Math {
  static double sin(double x) => math.sin(x);
  static double cos(double x) => math.cos(x);
}