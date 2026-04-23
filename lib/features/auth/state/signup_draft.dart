class SignupDraft {
  final String email;
  final String password;
  final String fullName;

  const SignupDraft({
    this.email = '',
    this.password = '',
    this.fullName = '',
  });

  SignupDraft copyWith({
    String? email,
    String? password,
    String? fullName,
    bool clearPassword = false,
    bool clearName = false,
  }) {
    return SignupDraft(
      email: email ?? this.email,
      password: clearPassword ? '' : (password ?? this.password),
      fullName: clearName ? '' : (fullName ?? this.fullName),
    );
  }
}