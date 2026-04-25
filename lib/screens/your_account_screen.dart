import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/auth/state/providers.dart';
import '../utils/app_responsive.dart';
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

    final double horizontalPadding =
    AppResponsive.w(context, 18).clamp(14.0, 24.0);
    final double topPadding =
    AppResponsive.h(context, 16).clamp(12.0, 20.0);
    final double cardRadius =
    AppResponsive.r(context, 28).clamp(22.0, 30.0);
    final double titleSize =
    AppResponsive.sp(context, 18).clamp(16.0, 20.0);
    final double sectionTitleSize =
    AppResponsive.sp(context, 16).clamp(14.0, 18.0);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F4),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                topPadding,
                horizontalPadding,
                0,
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    borderRadius: BorderRadius.circular(
                      AppResponsive.r(context, 16).clamp(12.0, 18.0),
                    ),
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      size: AppResponsive.r(context, 24).clamp(20.0, 28.0),
                      color: Colors.black,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Your account',
                        style: TextStyle(
                          fontSize: titleSize,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: AppResponsive.w(context, 32).clamp(24.0, 36.0)),
                ],
              ),
            ),
            SizedBox(height: AppResponsive.h(context, 20).clamp(14.0, 24.0)),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  0,
                  horizontalPadding,
                  AppResponsive.h(context, 30).clamp(20.0, 36.0),
                ),
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(
                      AppResponsive.w(context, 16).clamp(14.0, 20.0),
                      AppResponsive.h(context, 16).clamp(14.0, 20.0),
                      AppResponsive.w(context, 16).clamp(14.0, 20.0),
                      AppResponsive.h(context, 14).clamp(12.0, 18.0),
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFEFEA),
                      borderRadius: BorderRadius.circular(cardRadius),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: AppResponsive.r(context, 46).clamp(40.0, 52.0),
                              height: AppResponsive.r(context, 46).clamp(40.0, 52.0),
                              decoration: const BoxDecoration(
                                color: Color(0xFFB44ED3),
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                avatarLetter,
                                style: TextStyle(
                                  fontSize:
                                  AppResponsive.sp(context, 24).clamp(20.0, 26.0),
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: AppResponsive.w(context, 14).clamp(10.0, 16.0),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userName,
                                    style: TextStyle(
                                      fontSize:
                                      AppResponsive.sp(context, 15).clamp(14.0, 17.0),
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    userHandle,
                                    style: TextStyle(
                                      fontSize:
                                      AppResponsive.sp(context, 12).clamp(11.0, 13.5),
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xFF6E6E69),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: AppResponsive.h(context, 14).clamp(10.0, 16.0),
                        ),
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
                            SizedBox(
                              width: AppResponsive.w(context, 12).clamp(8.0, 14.0),
                            ),
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
                  SizedBox(height: AppResponsive.h(context, 25).clamp(18.0, 28.0)),
                  Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: sectionTitleSize,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: AppResponsive.h(context, 18).clamp(14.0, 20.0)),
                  _AccountListTile(title: 'Account management', onTap: () {}),
                  _AccountListTile(title: 'Profile visibility', onTap: () {}),
                  _AccountListTile(
                    title: 'Refine your recommendations',
                    onTap: () {},
                  ),
                  _AccountListTile(
                    title: 'Claimed external accounts',
                    onTap: () {},
                  ),
                  _AccountListTile(title: 'Social permissions', onTap: () {}),
                  _AccountListTile(title: 'Notifications', onTap: () {}),
                  _AccountListTile(title: 'Privacy and data', onTap: () {}),
                  _AccountListTile(
                    title: 'Reports and violations centre',
                    onTap: () {},
                  ),
                  _AccountListTile(title: 'Labs', onTap: () {}),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: AppResponsive.h(context, 18).clamp(14.0, 20.0),
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: sectionTitleSize,
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
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: AppResponsive.h(context, 18).clamp(14.0, 20.0),
                      ),
                      child: Text(
                        'Log out',
                        style: TextStyle(
                          fontSize: sectionTitleSize,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: AppResponsive.h(context, 18).clamp(14.0, 20.0),
                    ),
                    child: Text(
                      'Support',
                      style: TextStyle(
                        fontSize: sectionTitleSize,
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
    final double radius =
    AppResponsive.r(context, 18).clamp(14.0, 20.0);
    final double verticalPadding =
    AppResponsive.h(context, 12).clamp(10.0, 14.0);
    final double fontSize =
    AppResponsive.sp(context, 15).clamp(13.0, 16.0);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: verticalPadding),
        decoration: BoxDecoration(
          color: const Color(0xFFF7F7F4),
          borderRadius: BorderRadius.circular(radius),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            fontSize: fontSize,
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
    final double verticalPadding =
    AppResponsive.h(context, 18).clamp(14.0, 20.0);
    final double fontSize =
    AppResponsive.sp(context, 15).clamp(13.0, 16.0);
    final double iconSize =
    AppResponsive.r(context, 24).clamp(20.0, 26.0);

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: verticalPadding),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              size: iconSize,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}