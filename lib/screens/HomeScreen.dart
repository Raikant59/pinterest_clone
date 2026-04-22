import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest_clone/services/state/providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          TextButton(
            onPressed: () async {
              await ref.read(authControllerProvider.notifier).signOut();
            },
            child: const Text('Sign out'),
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Signed in as\n${auth.userEmail ?? ''}',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}