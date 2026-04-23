import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/providers.dart';
class ClerkSessionBridge extends ConsumerWidget {
  const ClerkSessionBridge({
    super.key,
    required this.child,
  });

  final Widget child;

  void _syncSignedIn(WidgetRef ref, ClerkAuthState authState) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(clerkAuthStateProvider.notifier).state = authState;
      ref.read(authControllerProvider.notifier).syncFromClerk(authState);
    });
  }

  void _syncSignedOut(WidgetRef ref, ClerkAuthState authState) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final auth = ref.read(authControllerProvider);

      // Important: during login/signup, ignore temporary signed-out states
      if (auth.isSubmitting) {
        return;
      }

      ref.read(clerkAuthStateProvider.notifier).state = authState;
      ref.read(authControllerProvider.notifier).syncFromClerk(authState);
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClerkErrorListener(
      child: ClerkAuthBuilder(
        signedInBuilder: (context, authState) {
          _syncSignedIn(ref, authState);
          return child;
        },
        signedOutBuilder: (context, authState) {
          _syncSignedOut(ref, authState);
          return child;
        },
      ),
    );
  }
}