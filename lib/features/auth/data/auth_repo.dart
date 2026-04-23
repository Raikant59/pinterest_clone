import 'package:clerk_auth/clerk_auth.dart' as clerk;
import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../features/auth/state/providers.dart';

class AuthRepository {
  AuthRepository(this.ref);

  final Ref ref;

  ClerkAuthState _clerk() {
    final state = ref.read(clerkAuthStateProvider);
    if (state == null) {
      throw Exception('Clerk is not ready yet.');
    }
    return state;
  }

  bool get isSignedIn {
    final state = ref.read(clerkAuthStateProvider);
    return state?.isSignedIn ?? false;
  }

  Future<void> signInWithPassword({
    required String email,
    required String password,
  }) async {
    final auth = _clerk();

    await auth.attemptSignIn(
      strategy: clerk.Strategy.password,
      identifier: email.trim(),
      password: password,
    );
  }

  Future<void> signUpWithEmailPassword({
    required String email,
    required String password,
    required String fullName,
  }) async {
    final auth = _clerk();

    final nameParts = fullName.trim().split(RegExp(r'\s+'));
    final firstName = nameParts.isEmpty ? '' : nameParts.first;
    final lastName =
    nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

    await auth.attemptSignUp(
      strategy: clerk.Strategy.emailCode,
      emailAddress: email.trim(),
      password: password,
      passwordConfirmation: password,
      firstName: firstName,
      lastName: lastName,
    );
  }

  Future<void> signOut() async {
    final auth = _clerk();
    await auth.signOut();
  }
}