import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../features/auth/state/providers.dart';
import 'edit_profile_screen.dart';

class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authControllerProvider);

    final String userName =
    (auth.userName != null && auth.userName!.trim().isNotEmpty)
        ? auth.userName!.trim()
        : 'User';
    final String userHandle =
    (auth.userEmail != null && auth.userEmail!.trim().isNotEmpty)
        ? '@${auth.userEmail!.trim().split('@').first}'
        : '@username';
    final String avatarLetter = userName[0].toUpperCase();

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F4),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 16, 18, 0),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    borderRadius: BorderRadius.circular(16),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 24,
                      color: Colors.black,
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Your account',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 32),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(18, 0, 18, 30),
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFEFEA),
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 46,
                              height: 46,
                              decoration: const BoxDecoration(
                                color: Color(0xFFB44ED3),
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                avatarLetter,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userName,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    userHandle,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF6E6E69),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            Expanded(
                              child: _AccountActionButton(
                                title: 'View profile',
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const EditProfileScreen(),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _AccountActionButton(
                                title: 'Share profile',
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const EditProfileScreen(),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 18),
                  _AccountListTile(title: 'Account management', onTap: () {}),
                  _AccountListTile(title: 'Profile visibility', onTap: () {}),
                  _AccountListTile(
                      title: 'Refine your recommendations', onTap: () {}),
                  _AccountListTile(
                      title: 'Claimed external accounts', onTap: () {}),
                  _AccountListTile(title: 'Social permissions', onTap: () {}),
                  _AccountListTile(title: 'Notifications', onTap: () {}),
                  _AccountListTile(title: 'Privacy and data', onTap: () {}),
                  _AccountListTile(
                      title: 'Reports and violations centre', onTap: () {}),
                  _AccountListTile(title: 'Labs', onTap: () {}),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 18),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  _AccountListTile(title: 'Add account', onTap: () {}),
                  _AccountListTile(title: 'Security', onTap: () {}),
                  InkWell(
                    onTap: () async {
                      await ref.read(authControllerProvider.notifier).signOut();
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 18),
                      child: Text(
                        'Log out',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 18),
                    child: Text(
                      'Support',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  _AccountListTile(title: 'Help Centre', onTap: () {}),
                  _AccountListTile(title: 'Terms of Service', onTap: () {}),
                  _AccountListTile(title: 'Privacy Policy', onTap: () {}),
                  _AccountListTile(title: 'About', onTap: () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AccountActionButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _AccountActionButton({
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFF7F7F4),
          borderRadius: BorderRadius.circular(18),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

class _AccountListTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _AccountListTile({
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right,
              size: 24,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}