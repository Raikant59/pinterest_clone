import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/auth/state/providers.dart';
import '../utils/app_responsive.dart';

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

    final double horizontalPadding =
    AppResponsive.w(context, 26).clamp(18.0, 30.0);
    final double topHorizontalPadding =
    AppResponsive.w(context, 22).clamp(16.0, 26.0);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F4),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                topHorizontalPadding,
                AppResponsive.h(context, 18).clamp(14.0, 20.0),
                topHorizontalPadding,
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
                      size: AppResponsive.r(context, 28).clamp(22.0, 30.0),
                      color: Colors.black,
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(
                      AppResponsive.r(context, 16).clamp(12.0, 18.0),
                    ),
                    child: Icon(
                      Icons.share_outlined,
                      size: AppResponsive.r(context, 28).clamp(22.0, 30.0),
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: AppResponsive.h(context, 30).clamp(20.0, 34.0),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: AppResponsive.r(context, 56).clamp(46.0, 60.0),
                    height: AppResponsive.r(context, 56).clamp(46.0, 60.0),
                    decoration: const BoxDecoration(
                      color: Color(0xFFB44ED3),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      avatarLetter,
                      style: TextStyle(
                        fontSize: AppResponsive.sp(context, 28).clamp(22.0, 30.0),
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: AppResponsive.w(context, 22).clamp(14.0, 24.0),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: AppResponsive.h(context, 8).clamp(6.0, 10.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userName,
                            style: TextStyle(
                              fontSize: AppResponsive.sp(context, 16)
                                  .clamp(14.0, 17.0),
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              letterSpacing: 0,
                            ),
                          ),
                          Text(
                            userEmail,
                            style: TextStyle(
                              fontSize: AppResponsive.sp(context, 12)
                                  .clamp(11.0, 13.0),
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF6F6F69),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: AppResponsive.h(context, 18).clamp(12.0, 20.0),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '0 followers · 0 following',
                  style: TextStyle(
                    fontSize:
                    AppResponsive.sp(context, 12).clamp(11.0, 13.0),
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: AppResponsive.h(context, 8).clamp(6.0, 10.0),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                0,
                AppResponsive.w(context, 95).clamp(60.0, 100.0),
                0,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Add a short bio to personalise your profile',
                      style: TextStyle(
                        fontSize:
                        AppResponsive.sp(context, 11).clamp(10.0, 12.0),
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF5E5E59),
                      ),
                    ),
                  ),
                  Icon(
                    Icons.edit_outlined,
                    size: AppResponsive.r(context, 19).clamp(16.0, 20.0),
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: AppResponsive.h(context, 8).clamp(6.0, 10.0),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppResponsive.w(context, 18).clamp(14.0, 20.0),
                    vertical: AppResponsive.h(context, 10).clamp(8.0, 12.0),
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE5E5DE),
                    borderRadius: BorderRadius.circular(
                      AppResponsive.r(context, 17).clamp(14.0, 18.0),
                    ),
                  ),
                  child: Text(
                    'Edit profile',
                    style: TextStyle(
                      fontSize:
                      AppResponsive.sp(context, 16).clamp(14.0, 17.0),
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: AppResponsive.h(context, 90).clamp(50.0, 95.0),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppResponsive.w(context, 80).clamp(36.0, 84.0),
              ),
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
            SizedBox(
              height: AppResponsive.h(context, 50).clamp(28.0, 54.0),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    _currentTab == EditProfileTab.created
                        ? 'Inspire with a Pin'
                        : 'You have not saved any ideas yet',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize:
                      AppResponsive.sp(context, 22).clamp(18.0, 24.0),
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      letterSpacing: -0.4,
                    ),
                  ),
                  SizedBox(
                    height: AppResponsive.h(context, 16).clamp(12.0, 18.0),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppResponsive.w(context, 24).clamp(18.0, 26.0),
                      vertical: AppResponsive.h(context, 10).clamp(8.0, 12.0),
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE60023),
                      borderRadius: BorderRadius.circular(
                        AppResponsive.r(context, 22).clamp(18.0, 24.0),
                      ),
                    ),
                    child: Text(
                      _currentTab == EditProfileTab.created ? 'Create' : 'Save',
                      style: TextStyle(
                        fontSize:
                        AppResponsive.sp(context, 14).clamp(12.0, 15.0),
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
    final double titleSize =
    AppResponsive.sp(context, 18).clamp(15.0, 19.0);
    final double gap =
    AppResponsive.h(context, 10).clamp(8.0, 12.0);
    final double underlineWidth =
    AppResponsive.w(context, 90).clamp(60.0, 92.0);
    final double underlineHeight =
    AppResponsive.h(context, 3).clamp(2.0, 3.5);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(
        AppResponsive.r(context, 10).clamp(8.0, 12.0),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: titleSize,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          SizedBox(height: gap),
          AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            width: selected ? underlineWidth : 0,
            height: underlineHeight,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}