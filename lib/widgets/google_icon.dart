import 'package:flutter/material.dart';

class GoogleIcon extends StatelessWidget {
  const GoogleIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      alignment: Alignment.center,
      child: const Text(
        'G',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: Color(0xFF4285F4),
          height: 1,
        ),
      ),
    );
  }
}