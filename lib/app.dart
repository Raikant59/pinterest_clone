import 'package:flutter/material.dart';
import 'package:pinterest_clone/routes/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pinterest Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE60023),
        ),
      ),
      initialRoute: AppRoutes.loader,
      routes: AppRoutes.routes,
    );
  }
}