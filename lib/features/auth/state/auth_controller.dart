import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_session.dart';
import 'providers.dart';

class AuthController extends Notifier<AuthSession> {
  @override
  AuthSession build() {
    return const AuthSession.unknown();
  }

  void syncFromClerk(ClerkAuthState authState) {
    final isSignedIn = authState.isSignedIn && authState.user != null;

    if (isSignedIn) {
      state = AuthSession.authenticated(
        userEmail: authState.user?.email ?? '',
        userName: authState.user?.name ?? authState.user?.firstName ?? '',
        isSubmitting: false,
      );
      return;
    }

    state = const AuthSession.unauthenticated(
      isSubmitting: false,
    );
  }

  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(
      isSubmitting: true,
      clearError: true,
    );

    try {
      await ref.read(authRepositoryProvider).signInWithPassword(
        email: email,
        password: password,
      );

      // Do not mark unauthenticated here.
      // Wait for ClerkSessionBridge -> syncFromClerk().
      return true;
    } catch (error) {
      state = AuthSession.unauthenticated(
        errorMessage: error.toString(),
      );
      return false;
    }
  }

  Future<bool> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    state = state.copyWith(
      isSubmitting: true,
      clearError: true,
    );

    try {
      await ref.read(authRepositoryProvider).signUpWithEmailPassword(
        email: email,
        password: password,
        fullName: fullName,
      );

      await ref.read(emailLookupServiceProvider).saveRegisteredEmail(email);
      ref.read(signupDraftProvider.notifier).clear();

      // Do not mark unauthenticated here.
      // Wait for ClerkSessionBridge -> syncFromClerk().
      return true;
    } catch (error) {
      state = AuthSession.unauthenticated(
        errorMessage: error.toString(),
      );
      return false;
    }
  }

  Future<void> signOut() async {
    state = state.copyWith(
      isSubmitting: true,
      clearError: true,
    );

    try {
      await ref.read(authRepositoryProvider).signOut();
      ref.read(signupDraftProvider.notifier).clear();

      // Bridge will sync final signed-out state
      state = const AuthSession.unauthenticated(
        isSubmitting: false,
      );
    } catch (error) {
      state = state.copyWith(
        isSubmitting: false,
        errorMessage: error.toString(),
      );
    }
  }
}