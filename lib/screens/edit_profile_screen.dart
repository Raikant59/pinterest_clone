import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/state/providers.dart';

enum EditProfileTab { created, saved }

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  EditProfileTab _currentTab = EditProfileTab.created;

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authControllerProvider);

    final String userName =
    (auth.userName != null && auth.userName!.trim().isNotEmpty)
        ? auth.userName!.trim()
        : 'User';
    final String userEmail =
    (auth.userEmail != null && auth.userEmail!.trim().isNotEmpty)
        ? auth.userEmail!.trim().split('@').first
        : 'username';

    final String avatarLetter = userName[0].toUpperCase();

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F4),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 18, 22, 0),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    borderRadius: BorderRadius.circular(16),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 28,
                      color: Colors.black,
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(16),
                    child: const Icon(
                      Icons.share_outlined,
                      size: 28,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: const BoxDecoration(
                      color: Color(0xFFB44ED3),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      avatarLetter,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 22),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userName,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              letterSpacing: 0,
                            ),
                          ),
                          Text(
                            userEmail,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF6F6F69),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 26),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '0 followers · 0 following',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.fromLTRB(26, 0, 95, 0),
              child: Row(
                children: const [
                  Expanded(
                    child: Text(
                      'Add a short bio to personalise your profile',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF5E5E59),
                      ),
                    ),
                  ),
                  Icon(
                    Icons.edit_outlined,
                    size: 19,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE5E5DE),
                    borderRadius: BorderRadius.circular(17),
                  ),
                  child: const Text(
                    'Edit profile',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 90),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _EditProfileTabButton(
                    title: 'Created',
                    selected: _currentTab == EditProfileTab.created,
                    onTap: () {
                      setState(() {
                        _currentTab = EditProfileTab.created;
                      });
                    },
                  ),
                  _EditProfileTabButton(
                    title: 'Saved',
                    selected: _currentTab == EditProfileTab.saved,
                    onTap: () {
                      setState(() {
                        _currentTab = EditProfileTab.saved;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            Expanded(
              child: Column(
                children: [
                  Text(
                    _currentTab == EditProfileTab.created
                        ? 'Inspire with a Pin'
                        : 'You have not saved any ideas yet',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      letterSpacing: -0.4,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE60023),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Text(
                      _currentTab == EditProfileTab.created ? 'Create' : 'Save',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EditProfileTabButton extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const _EditProfileTabButton({
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            width: selected ? 90 : 0,
            height: 3,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}