import 'package:flutter/material.dart';
import '../utils/app_responsive.dart';

class CreateScreen extends StatelessWidget {
  const CreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F4),
      body: Center(
        child: Text(
          'Create Screen',
          style: TextStyle(
            fontSize: AppResponsive.sp(context, 18).clamp(16.0, 20.0),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}