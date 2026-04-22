enum AuthStatus {
  unknown,
  authenticated,
  unauthenticated,
}

class AuthSession {
  final AuthStatus status;
  final bool isSubmitting;
  final String? errorMessage;
  final String? userEmail;
  final String? userName;

  const AuthSession({
    required this.status,
    this.isSubmitting = false,
    this.errorMessage,
    this.userEmail,
    this.userName,
  });

  const AuthSession.unknown()
      : status = AuthStatus.unknown,
        isSubmitting = false,
        errorMessage = null,
        userEmail = null,
        userName = null;

  const AuthSession.unauthenticated({
    this.isSubmitting = false,
    this.errorMessage,
  })  : status = AuthStatus.unauthenticated,
        userEmail = null,
        userName = null;

  const AuthSession.authenticated({
    required this.userEmail,
    required this.userName,
    this.isSubmitting = false,
  })  : status = AuthStatus.authenticated,
        errorMessage = null;

  AuthSession copyWith({
    AuthStatus? status,
    bool? isSubmitting,
    String? errorMessage,
    String? userEmail,
    String? userName,
    bool clearError = false,
  }) {
    return AuthSession(
      status: status ?? this.status,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      userEmail: userEmail ?? this.userEmail,
      userName: userName ?? this.userName,
    );
  }
}