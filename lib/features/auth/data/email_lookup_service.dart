import 'package:shared_preferences/shared_preferences.dart';

class EmailLookupService {
  static const String _registeredEmailsKey = 'registered_emails';

  Future<bool> checkIfUserExists(String email) async {
    final prefs = await SharedPreferences.getInstance();
    final storedEmails = prefs.getStringList(_registeredEmailsKey) ?? [];

    final normalizedEmail = email.trim().toLowerCase();
    return storedEmails.contains(normalizedEmail);
  }

  Future<void> saveRegisteredEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    final storedEmails = prefs.getStringList(_registeredEmailsKey) ?? [];

    final normalizedEmail = email.trim().toLowerCase();

    if (!storedEmails.contains(normalizedEmail)) {
      storedEmails.add(normalizedEmail);
      await prefs.setStringList(_registeredEmailsKey, storedEmails);
    }
  }

  Future<List<String>> getAllRegisteredEmails() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_registeredEmailsKey) ?? [];
  }
}