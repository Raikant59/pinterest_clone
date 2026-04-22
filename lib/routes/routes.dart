import 'package:flutter/material.dart';
import 'package:pinterest_clone/screens/Startup_screen.dart';
import 'package:pinterest_clone/screens/loader_screen.dart';

class AppRoutes {
  static const String loader = '/';
  static const String startupScreen = '/email-entry';

  static Map<String, WidgetBuilder> routes = {
    loader: (context) => const LoaderScreen(),
    startupScreen: (context) => const EmailEntryScreen(),
  };
}