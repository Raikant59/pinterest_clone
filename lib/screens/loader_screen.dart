import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pinterest_clone/routes/routes.dart';
import 'package:pinterest_clone/widgets/loader.dart';

class LoaderScreen extends StatefulWidget {
  const LoaderScreen({super.key});

  @override
  State<LoaderScreen> createState() => _LoaderScreenState();
}

class _LoaderScreenState extends State<LoaderScreen>
    with SingleTickerProviderStateMixin {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(milliseconds: 1000), () {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, AppRoutes.startupScreen);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Loader()
      ),
    );
  }
}