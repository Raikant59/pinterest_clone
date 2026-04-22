import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest_clone/routes/router.dart';
import 'package:pinterest_clone/services/widgets/clerk_session_bridge.dart';

class PinterestCloneApp extends ConsumerWidget {
  const PinterestCloneApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF6F6F6),
        useMaterial3: true,
      ),
      builder: (context, child) {
        return ClerkSessionBridge(
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}