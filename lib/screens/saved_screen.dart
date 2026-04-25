import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest_clone/screens/your_account_screen.dart';
import '../features/auth/state/providers.dart';
import '../utils/app_responsive.dart';
import 'edit_profile_screen.dart';

enum SavedTabType { pins, boards, collages }

class SavedScreen extends ConsumerStatefulWidget {
  const SavedScreen({super.key});

  @override
  ConsumerState<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends ConsumerState<SavedScreen> {
  SavedTabType _currentTab = SavedTabType.pins;

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authControllerProvider);
    final String userName =
    (auth.userName != null && auth.userName!.trim().isNotEmpty)
        ? auth.userName!.trim()
        : 'User';

    final String avatarLetter = userName[0].toUpperCase();

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F4),
      body: SafeArea(
        child: Column(
          children: [
            _SavedHeader(
              avatarLetter: avatarLetter,
              currentTab: _currentTab,
              onAvatarTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const EditProfileScreen(),
                  ),
                );
              },
              onSettingsTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AccountScreen(),
                  ),
                );
              },
              onTabSelected: (tab) {
                setState(() {
                  _currentTab = tab;
                });
              },
            ),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 180),
                child: switch (_currentTab) {
                  SavedTabType.pins => const _PinsTabContent(
                    key: ValueKey('pins'),
                  ),
                  SavedTabType.boards => const _BoardsTabContent(
                    key: ValueKey('boards'),
                  ),
                  SavedTabType.collages => const _CollagesTabContent(
                    key: ValueKey('collages'),
                  ),
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SavedHeader extends StatelessWidget {
  final String avatarLetter;
  final SavedTabType currentTab;
  final VoidCallback onAvatarTap;
  final VoidCallback onSettingsTap;
  final ValueChanged<SavedTabType> onTabSelected;

  const _SavedHeader({
    required this.avatarLetter,
    required this.currentTab,
    required this.onAvatarTap,
    required this.onSettingsTap,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding =
    AppResponsive.w(context, 12).clamp(10.0, 16.0);
    final double topPadding =
    AppResponsive.h(context, 18).clamp(14.0, 22.0);
    final double avatarSize =
    AppResponsive.r(context, 38).clamp(34.0, 42.0);
    final double avatarFontSize =
    AppResponsive.sp(context, 18).clamp(16.0, 20.0);
    final double betweenAvatarAndTabs =
    AppResponsive.w(context, 12).clamp(8.0, 14.0);
    final double betweenTabsAndSettings =
    AppResponsive.w(context, 12).clamp(8.0, 14.0);
    final double settingsIconSize =
    AppResponsive.r(context, 34).clamp(28.0, 36.0);
    final double bottomGap =
    AppResponsive.h(context, 18).clamp(14.0, 20.0);

    return Padding(
      padding: EdgeInsets.fromLTRB(
        horizontalPadding,
        topPadding,
        horizontalPadding,
        0,
      ),
      child: Column(
        children: [
          Row(
            children: [
              InkWell(
                onTap: onAvatarTap,
                borderRadius: BorderRadius.circular(
                  AppResponsive.r(context, 24).clamp(20.0, 26.0),
                ),
                child: Container(
                  width: avatarSize,
                  height: avatarSize,
                  decoration: const BoxDecoration(
                    color: Color(0xFFB44ED3),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    avatarLetter,
                    style: TextStyle(
                      fontSize: avatarFontSize,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(width: betweenAvatarAndTabs),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _HeaderTab(
                      title: 'Pins',
                      selected: currentTab == SavedTabType.pins,
                      onTap: () => onTabSelected(SavedTabType.pins),
                    ),
                    _HeaderTab(
                      title: 'Boards',
                      selected: currentTab == SavedTabType.boards,
                      onTap: () => onTabSelected(SavedTabType.boards),
                    ),
                    _HeaderTab(
                      title: 'Collages',
                      selected: currentTab == SavedTabType.collages,
                      onTap: () => onTabSelected(SavedTabType.collages),
                    ),
                  ],
                ),
              ),
              SizedBox(width: betweenTabsAndSettings),
              InkWell(
                onTap: onSettingsTap,
                borderRadius: BorderRadius.circular(
                  AppResponsive.r(context, 20).clamp(16.0, 22.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(
                    AppResponsive.r(context, 4).clamp(3.0, 5.0),
                  ),
                  child: Icon(
                    Icons.settings_outlined,
                    size: settingsIconSize,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: bottomGap),
          if (currentTab == SavedTabType.collages)
            const _CollageFilters()
          else
            const _SavedSearchRow(),
        ],
      ),
    );
  }
}

class _HeaderTab extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const _HeaderTab({
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding =
    AppResponsive.w(context, 8).clamp(6.0, 10.0);
    final double verticalPadding =
    AppResponsive.h(context, 2).clamp(1.0, 3.0);
    final double fontSize =
    AppResponsive.sp(context, 15).clamp(13.0, 16.0);
    final double gap =
    AppResponsive.h(context, 2).clamp(1.0, 4.0);
    final double underlineWidth =
    AppResponsive.w(context, 62).clamp(44.0, 64.0);
    final double underlineHeight =
    AppResponsive.h(context, 3).clamp(2.0, 3.5);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(
        AppResponsive.r(context, 10).clamp(8.0, 12.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w500,
                color: Colors.black,
                letterSpacing: 0,
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
      ),
    );
  }
}

class _SavedSearchRow extends StatelessWidget {
  const _SavedSearchRow();

  @override
  Widget build(BuildContext context) {
    final double fieldHeight =
    AppResponsive.h(context, 48).clamp(44.0, 52.0);
    final double fieldHorizontalPadding =
    AppResponsive.w(context, 16).clamp(12.0, 18.0);
    final double fieldRadius =
    AppResponsive.r(context, 24).clamp(20.0, 24.0);
    final double fieldBorderWidth =
    AppResponsive.r(context, 1.4).clamp(1.0, 1.5);
    final double iconSize =
    AppResponsive.r(context, 24).clamp(20.0, 26.0);
    final double textSize =
    AppResponsive.sp(context, 15).clamp(13.0, 16.0);
    final double betweenFieldAndPlus =
    AppResponsive.w(context, 10).clamp(8.0, 12.0);
    final double plusSize =
    AppResponsive.r(context, 32).clamp(28.0, 34.0);
    final double bottomPadding =
    AppResponsive.h(context, 6).clamp(4.0, 8.0);

    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: fieldHeight,
              padding: EdgeInsets.symmetric(horizontal: fieldHorizontalPadding),
              decoration: BoxDecoration(
                color: const Color(0xFFF7F7F4),
                borderRadius: BorderRadius.circular(fieldRadius),
                border: Border.all(
                  color: const Color(0xFFAAAAA3),
                  width: fieldBorderWidth,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    size: iconSize,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: AppResponsive.w(context, 12).clamp(8.0, 14.0),
                  ),
                  Expanded(
                    child: Text(
                      'Search your Pins',
                      style: TextStyle(
                        fontSize: textSize,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF6F6F69),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: betweenFieldAndPlus),
          InkWell(
            onTap: () {},
            child: Icon(
              Icons.add,
              size: plusSize,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class _CollageFilters extends StatelessWidget {
  const _CollageFilters();

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding =
    AppResponsive.w(context, 16).clamp(12.0, 18.0);
    final double verticalPadding =
    AppResponsive.h(context, 8).clamp(6.0, 10.0);
    final double radius =
    AppResponsive.r(context, 16).clamp(14.0, 18.0);
    final double fontSize =
    AppResponsive.sp(context, 14).clamp(12.0, 15.0);
    final double spacing =
    AppResponsive.w(context, 12).clamp(8.0, 14.0);
    final double bottomPadding =
    AppResponsive.h(context, 6).clamp(4.0, 8.0);

    Widget buildChip(String text) {
      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFE6E6E0),
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: Row(
        children: [
          buildChip('Created by you'),
          SizedBox(width: spacing),
          buildChip('In progress'),
        ],
      ),
    );
  }
}

class _PinsTabContent extends StatelessWidget {
  const _PinsTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const _EmptyStateContent(
      imageType: _SavedIllustrationType.pins,
      title: 'Save what inspires you',
      description:
      'Saving Pins is Pinterest’s superpower.\nBrowse Pins, save what you love, find\nthem here to get inspired all over\nagain.',
      buttonText: 'Explore Pins',
    );
  }
}

class _BoardsTabContent extends StatelessWidget {
  const _BoardsTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const _EmptyStateContent(
      imageType: _SavedIllustrationType.boards,
      title: 'Organise your ideas',
      description:
      'Pins are sparks of inspiration.\nBoards are where they live.\nCreate boards to organise your\nPins your way.',
      buttonText: 'Create a board',
    );
  }
}

class _CollagesTabContent extends StatelessWidget {
  const _CollagesTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const _EmptyStateContent(
      imageType: _SavedIllustrationType.collages,
      title: 'Make your first collage',
      description:
      'Snip and paste the best parts of your\nfavourite Pins to create something\ncompletely new.',
      buttonText: 'Create collage',
    );
  }
}

enum _SavedIllustrationType { pins, boards, collages }

class _EmptyStateContent extends StatelessWidget {
  final _SavedIllustrationType imageType;
  final String title;
  final String description;
  final String buttonText;

  const _EmptyStateContent({
    required this.imageType,
    required this.title,
    required this.description,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding =
    AppResponsive.w(context, 24).clamp(18.0, 28.0);
    final double topPadding =
    AppResponsive.h(context, 18).clamp(14.0, 20.0);
    final double bottomPadding =
    AppResponsive.h(context, 120).clamp(80.0, 130.0);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.fromLTRB(
        horizontalPadding,
        topPadding,
        horizontalPadding,
        bottomPadding,
      ),
      child: Column(
        children: [
          SizedBox(height: AppResponsive.h(context, 20).clamp(12.0, 22.0)),
          _SavedIllustration(type: imageType),
          SizedBox(height: AppResponsive.h(context, 6).clamp(4.0, 8.0)),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: AppResponsive.sp(context, 18).clamp(16.0, 20.0),
              fontWeight: FontWeight.w800,
              color: Colors.black,
              height: 1.15,
              letterSpacing: -0.2,
            ),
          ),
          SizedBox(height: AppResponsive.h(context, 6).clamp(4.0, 8.0)),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: AppResponsive.sp(context, 14).clamp(12.5, 15.0),
              fontWeight: FontWeight.w400,
              color: Colors.black,
              height: 1.35,
              letterSpacing: -0.2,
            ),
          ),
          SizedBox(height: AppResponsive.h(context, 18).clamp(14.0, 20.0)),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppResponsive.w(context, 30).clamp(24.0, 34.0),
              vertical: AppResponsive.h(context, 14).clamp(12.0, 16.0),
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFE60023),
              borderRadius: BorderRadius.circular(
                AppResponsive.r(context, 24).clamp(20.0, 24.0),
              ),
            ),
            child: InkWell(
              onTap: () {
                debugPrint('Tapped');
              },
              child: Text(
                buttonText,
                style: TextStyle(
                  fontSize: AppResponsive.sp(context, 16).clamp(14.0, 17.0),
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SavedIllustration extends StatelessWidget {
  final _SavedIllustrationType type;

  const _SavedIllustration({
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case _SavedIllustrationType.pins:
        return SizedBox(
          width: AppResponsive.r(context, 250).clamp(210.0, 260.0),
          height: AppResponsive.r(context, 250).clamp(210.0, 260.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: AppResponsive.r(context, 205).clamp(170.0, 215.0),
                height: AppResponsive.r(context, 205).clamp(170.0, 215.0),
                decoration: const BoxDecoration(
                  color: Color(0xFFD3E1DD),
                  shape: BoxShape.circle,
                ),
              ),
              Container(
                width: AppResponsive.r(context, 165).clamp(138.0, 172.0),
                height: AppResponsive.r(context, 165).clamp(138.0, 172.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFECE9F1),
                  borderRadius: BorderRadius.circular(
                    AppResponsive.r(context, 24).clamp(18.0, 24.0),
                  ),
                ),
              ),
              Positioned(
                top: AppResponsive.h(context, 45).clamp(34.0, 48.0),
                child: Container(
                  width: AppResponsive.w(context, 96).clamp(80.0, 100.0),
                  height: AppResponsive.h(context, 12).clamp(8.0, 12.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD8E7E5),
                    borderRadius: BorderRadius.circular(
                      AppResponsive.r(context, 10).clamp(8.0, 10.0),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: AppResponsive.h(context, 61).clamp(46.0, 64.0),
                child: Container(
                  width: AppResponsive.w(context, 102).clamp(84.0, 106.0),
                  height: AppResponsive.h(context, 8).clamp(6.0, 9.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD8E7E5),
                    borderRadius: BorderRadius.circular(
                      AppResponsive.r(context, 10).clamp(8.0, 10.0),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: AppResponsive.h(context, 80).clamp(62.0, 84.0),
                left: AppResponsive.w(context, 54).clamp(42.0, 58.0),
                child: const _PuzzlePiece(
                  color: Color(0xFF2E9438),
                  angle: -0.6,
                ),
              ),
              Positioned(
                top: AppResponsive.h(context, 78).clamp(60.0, 82.0),
                left: AppResponsive.w(context, 98).clamp(76.0, 102.0),
                child: const _PuzzlePiece(
                  color: Color(0xFFF2C2E1),
                  angle: 0.55,
                ),
              ),
              Positioned(
                top: AppResponsive.h(context, 69).clamp(54.0, 72.0),
                left: AppResponsive.w(context, 142).clamp(110.0, 148.0),
                child: const _PuzzlePiece(
                  color: Color(0xFFE60023),
                  angle: 0.75,
                ),
              ),
              Positioned(
                top: AppResponsive.h(context, 136).clamp(104.0, 142.0),
                left: AppResponsive.w(context, 58).clamp(46.0, 62.0),
                child: const _PuzzlePiece(
                  color: Color(0xFFF4B04C),
                  angle: 0.0,
                ),
              ),
              Positioned(
                top: AppResponsive.h(context, 126).clamp(98.0, 132.0),
                left: AppResponsive.w(context, 110).clamp(86.0, 116.0),
                child: const _PuzzlePiece(
                  color: Color(0xFFD4E173),
                  angle: -0.3,
                ),
              ),
              Positioned(
                top: AppResponsive.h(context, 146).clamp(114.0, 152.0),
                left: AppResponsive.w(context, 156).clamp(122.0, 162.0),
                child: const _PuzzlePiece(
                  color: Color(0xFF7FE0D0),
                  angle: -0.5,
                ),
              ),
              Positioned(
                top: AppResponsive.h(context, 168).clamp(130.0, 174.0),
                left: AppResponsive.w(context, 94).clamp(72.0, 98.0),
                child: const _PuzzlePiece(
                  color: Color(0xFF2C8C32),
                  angle: 0.45,
                ),
              ),
              Positioned(
                top: AppResponsive.h(context, 152).clamp(118.0, 158.0),
                left: AppResponsive.w(context, 28).clamp(20.0, 30.0),
                child: const _PuzzlePiece(
                  color: Color(0xFF89E2D7),
                  angle: -0.85,
                ),
              ),
              Positioned(
                top: AppResponsive.h(context, 176).clamp(138.0, 182.0),
                left: AppResponsive.w(context, 22).clamp(16.0, 24.0),
                child: const _PuzzlePiece(
                  color: Color(0xFFD8D05C),
                  angle: -0.55,
                ),
              ),
            ],
          ),
        );

      case _SavedIllustrationType.boards:
        return SizedBox(
          width: AppResponsive.w(context, 270).clamp(230.0, 280.0),
          height: AppResponsive.h(context, 225).clamp(190.0, 235.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: AppResponsive.r(context, 195).clamp(162.0, 202.0),
                height: AppResponsive.r(context, 195).clamp(162.0, 202.0),
                decoration: const BoxDecoration(
                  color: Color(0xFFE7D1F0),
                  shape: BoxShape.circle,
                ),
              ),
              Positioned(
                top: AppResponsive.h(context, 30).clamp(22.0, 32.0),
                child: Container(
                  width: AppResponsive.w(context, 170).clamp(142.0, 176.0),
                  height: AppResponsive.h(context, 6).clamp(4.0, 7.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD895E3),
                    borderRadius: BorderRadius.circular(
                      AppResponsive.r(context, 8).clamp(6.0, 8.0),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: AppResponsive.h(context, 29).clamp(22.0, 31.0),
                child: Container(
                  width: AppResponsive.r(context, 8).clamp(6.0, 8.5),
                  height: AppResponsive.r(context, 8).clamp(6.0, 8.5),
                  decoration: const BoxDecoration(
                    color: Color(0xFF9A256B),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                top: AppResponsive.h(context, 40).clamp(30.0, 42.0),
                child: Container(
                  width: AppResponsive.w(context, 204).clamp(172.0, 212.0),
                  height: AppResponsive.h(context, 126).clamp(108.0, 132.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7C68E),
                    border: Border.all(
                      color: const Color(0xFFF46F3E),
                      width: AppResponsive.r(context, 6).clamp(4.0, 6.0),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: AppResponsive.h(context, 53).clamp(40.0, 56.0),
                left: AppResponsive.w(context, 60).clamp(46.0, 64.0),
                child: const _BoardPaper(
                  color: Color(0xFFFF5A2C),
                  angle: -0.2,
                ),
              ),
              Positioned(
                top: AppResponsive.h(context, 62).clamp(48.0, 66.0),
                left: AppResponsive.w(context, 108).clamp(82.0, 112.0),
                child: const _BoardPaper(
                  color: Color(0xFFE1D75E),
                  angle: -0.03,
                ),
              ),
              Positioned(
                top: AppResponsive.h(context, 70).clamp(54.0, 74.0),
                left: AppResponsive.w(context, 158).clamp(120.0, 164.0),
                child: const _BoardPaper(
                  color: Color(0xFFF0D98C),
                  angle: 0.22,
                ),
              ),
              Positioned(
                top: AppResponsive.h(context, 118).clamp(92.0, 124.0),
                left: AppResponsive.w(context, 46).clamp(34.0, 50.0),
                child: const _BoardPaper(
                  color: Color(0xFFECE57F),
                  angle: 0.08,
                ),
              ),
              Positioned(
                top: AppResponsive.h(context, 140).clamp(110.0, 146.0),
                left: AppResponsive.w(context, 76).clamp(58.0, 80.0),
                child: const _BoardPaper(
                  color: Color(0xFFB554C8),
                  angle: 0.25,
                ),
              ),
              Positioned(
                top: AppResponsive.h(context, 114).clamp(90.0, 120.0),
                left: AppResponsive.w(context, 104).clamp(78.0, 108.0),
                child: const _BoardPaper(
                  color: Color(0xFFF4EFF4),
                  angle: 0.0,
                ),
              ),
              Positioned(
                top: AppResponsive.h(context, 126).clamp(98.0, 132.0),
                left: AppResponsive.w(context, 156).clamp(120.0, 162.0),
                child: const _BoardPaper(
                  color: Color(0xFF6FD7BF),
                  angle: -0.04,
                ),
              ),
              Positioned(
                top: AppResponsive.h(context, 62).clamp(48.0, 66.0),
                right: AppResponsive.w(context, 38).clamp(28.0, 40.0),
                child: Transform.rotate(
                  angle: 0.12,
                  child: Container(
                    width: AppResponsive.w(context, 40).clamp(32.0, 42.0),
                    height: AppResponsive.h(context, 56).clamp(44.0, 58.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF7E7EA),
                      border: Border.all(
                        color: Colors.white,
                        width: AppResponsive.r(context, 3).clamp(2.0, 3.0),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '🧁',
                        style: TextStyle(
                          fontSize: AppResponsive.sp(context, 18)
                              .clamp(14.0, 18.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );

      case _SavedIllustrationType.collages:
        return SizedBox(
          width: AppResponsive.r(context, 245).clamp(205.0, 255.0),
          height: AppResponsive.r(context, 245).clamp(205.0, 255.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: AppResponsive.r(context, 205).clamp(170.0, 212.0),
                height: AppResponsive.r(context, 205).clamp(170.0, 212.0),
                decoration: const BoxDecoration(
                  color: Color(0xFFDCD4F1),
                  shape: BoxShape.circle,
                ),
              ),
              Positioned(
                top: AppResponsive.h(context, 36).clamp(26.0, 38.0),
                left: AppResponsive.w(context, 72).clamp(54.0, 76.0),
                child: Transform.rotate(
                  angle: 0.18,
                  child: Container(
                    width: AppResponsive.w(context, 62).clamp(50.0, 66.0),
                    height: AppResponsive.h(context, 74).clamp(60.0, 78.0),
                    decoration: const BoxDecoration(
                      color: Color(0xFF7CB7E8),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: AppResponsive.h(context, 100).clamp(76.0, 104.0),
                left: AppResponsive.w(context, 48).clamp(36.0, 52.0),
                child: Transform.rotate(
                  angle: -0.42,
                  child: Container(
                    width: AppResponsive.w(context, 94).clamp(76.0, 98.0),
                    height: AppResponsive.h(context, 72).clamp(58.0, 76.0),
                    decoration: const BoxDecoration(
                      color: Color(0xFFF0B097),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: AppResponsive.h(context, 154).clamp(120.0, 160.0),
                left: AppResponsive.w(context, 38).clamp(28.0, 42.0),
                child: Transform.rotate(
                  angle: -0.32,
                  child: Container(
                    width: AppResponsive.w(context, 38).clamp(30.0, 40.0),
                    height: AppResponsive.h(context, 34).clamp(28.0, 36.0),
                    decoration: const BoxDecoration(
                      color: Color(0xFFE60023),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: AppResponsive.h(context, 148).clamp(116.0, 154.0),
                right: AppResponsive.w(context, 44).clamp(32.0, 46.0),
                child: Transform.rotate(
                  angle: 0.22,
                  child: Container(
                    width: AppResponsive.w(context, 46).clamp(36.0, 48.0),
                    height: AppResponsive.h(context, 38).clamp(30.0, 40.0),
                    decoration: const BoxDecoration(
                      color: Color(0xFFFF6A2D),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: AppResponsive.h(context, 82).clamp(62.0, 86.0),
                left: AppResponsive.w(context, 74).clamp(56.0, 78.0),
                child: Icon(
                  Icons.content_cut,
                  size: AppResponsive.r(context, 96).clamp(78.0, 100.0),
                  color: const Color(0xFF6279E8),
                ),
              ),
            ],
          ),
        );
    }
  }
}

class _PuzzlePiece extends StatelessWidget {
  final Color color;
  final double angle;

  const _PuzzlePiece({
    required this.color,
    required this.angle,
  });

  @override
  Widget build(BuildContext context) {
    final double size = AppResponsive.r(context, 40).clamp(32.0, 42.0);
    final double radius = AppResponsive.r(context, 8).clamp(6.0, 8.0);

    return Transform.rotate(
      angle: angle,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}

class _BoardPaper extends StatelessWidget {
  final Color color;
  final double angle;

  const _BoardPaper({
    required this.color,
    required this.angle,
  });

  @override
  Widget build(BuildContext context) {
    final double width = AppResponsive.w(context, 46).clamp(38.0, 48.0);
    final double height = AppResponsive.h(context, 50).clamp(40.0, 52.0);

    return Transform.rotate(
      angle: angle,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
        ),
      ),
    );
  }
}