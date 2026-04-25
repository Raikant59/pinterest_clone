import 'package:flutter/material.dart';
import '../utils/app_responsive.dart';

class GoogleIcon extends StatelessWidget {
  const GoogleIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final double boxSize = AppResponsive.r(context, 24).clamp(20.0, 28.0);
    final double fontSize = AppResponsive.sp(context, 22).clamp(18.0, 24.0);

    return SizedBox(
      width: boxSize,
      height: boxSize,
      child: Center(
        child: Text(
          'G',
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF4285F4),
            height: 1,
          ),
        ),
      ),
    );
  }
}