import 'package:clerk_flutter/clerk_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest_clone/services/auth/auth_repo.dart';
import '../auth/email_lookup_service.dart';
import 'auth_controller.dart';
import 'auth_session.dart';
import 'signup_draft.dart';

final clerkAuthStateProvider = StateProvider<ClerkAuthState?>((ref) => null);

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref);
});

final emailLookupServiceProvider = Provider<EmailLookupService>((ref) {
  return EmailLookupService();
});

final authControllerProvider =
NotifierProvider<AuthController, AuthSession>(AuthController.new);

final signupDraftProvider =
StateNotifierProvider<SignupDraftController, SignupDraft>(
      (ref) => SignupDraftController(),
);

class SignupDraftController extends StateNotifier<SignupDraft> {
  SignupDraftController() : super(const SignupDraft());

  void setEmail(String email) {
    state = state.copyWith(email: email);
  }

  void setPassword(String password) {
    state = state.copyWith(password: password);
  }

  void setFullName(String fullName) {
    state = state.copyWith(fullName: fullName);
  }

  void clear() {
    state = const SignupDraft();
  }
}