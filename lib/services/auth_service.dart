class AuthService {
  AuthService._();

  static final AuthService instance = AuthService._();

  Future<bool> checkIfUserExists(String email) async {
    await Future.delayed(const Duration(milliseconds: 800));

    final existingUsers = <String>{
      'nitish@gmail.com',
      'test@gmail.com',
      'demo@gmail.com',
      'user@gmail.com',
    };

    return existingUsers.contains(email.trim().toLowerCase());
  }
}