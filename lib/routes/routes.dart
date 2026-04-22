import 'package:flutter/material.dart';
import 'package:pinterest_clone/screens/SignUp%20Screens/create_password_screen.dart';
import 'package:pinterest_clone/screens/Startup_screen.dart';
import 'package:pinterest_clone/screens/loader_screen.dart';
import 'package:pinterest_clone/screens/login.dart';

class AppRoutes {
  static const String loader = '/';
  static const String startupScreen = '/email-entry';
  static const String login = '/login';
  static const String signup = '/signup';

  static Map<String, WidgetBuilder> routes = {
    loader: (context) => const LoaderScreen(),
    startupScreen: (context) => const EmailEntryScreen(),
    login: (context) => const LoginScreen(),
    signup: (context) => CreatePasswordScreen(),
  };
}