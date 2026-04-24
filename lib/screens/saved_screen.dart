import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/state/providers.dart';
import '../routes/routes.dart';

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
    final String userEmail =
    (auth.userEmail != null && auth.userEmail!.trim().isNotEmpty)
        ? auth.userEmail!.trim()
        : '@username';

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
                context.push(AppRoutes.editProfile);
              },
              onSettingsTap: () {
                context.push(AppRoutes.account);
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
                  SavedTabType.pins => _PinsTabContent(
                    key: const ValueKey('pins'),
                  ),
                  SavedTabType.boards => _BoardsTabContent(
                    key: const ValueKey('boards'),
                  ),
                  SavedTabType.collages => _CollagesTabContent(
                    key: const ValueKey('collages'),
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 18, 12, 0),
      child: Column(
        children: [
          Row(
            children: [
              InkWell(
                onTap: onAvatarTap,
                borderRadius: BorderRadius.circular(24),
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: const BoxDecoration(
                    color: Color(0xFFB44ED3),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    avatarLetter,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
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
              const SizedBox(width: 12),
              InkWell(
                onTap: onSettingsTap,
                borderRadius: BorderRadius.circular(20),
                child: const Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(
                    Icons.settings_outlined,
                    size: 34,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
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
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.black,
                letterSpacing: 0,
              ),
            ),
            const SizedBox(height: 2),
            AnimatedContainer(
              duration: const Duration(milliseconds: 160),
              width: selected ? 62 : 0,
              height: 3,
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFF7F7F4),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: const Color(0xFFAAAAA3),
                  width: 1.4,
                ),
              ),
              child: Row(
                children: const [
                  Icon(
                    Icons.search,
                    size: 24,
                    color: Colors.black,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Search your Pins',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF6F6F69),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          InkWell(
            onTap: (){},
            child: const Icon(
              Icons.add,
              size: 32,
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFE6E6E0),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Text(
              'Created by you',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFE6E6E0),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Text(
              'In progress',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ),
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
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(24, 18, 24, 120),
      child: Column(
        children: [
          const SizedBox(height: 20),
          _SavedIllustration(type: imageType),
          const SizedBox(height: 6),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Colors.black,
              height: 1.15,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black,
              height: 1.35,
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
            decoration: BoxDecoration(
              color: const Color(0xFFE60023),
              borderRadius: BorderRadius.circular(24),
            ),
            child: InkWell(
              onTap: (){debugPrint('Tapped');},
              child: Text(
                buttonText,
                style: const TextStyle(
                  fontSize: 16,
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
          width: 250,
          height: 250,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 205,
                height: 205,
                decoration: const BoxDecoration(
                  color: Color(0xFFD3E1DD),
                  shape: BoxShape.circle,
                ),
              ),
              Container(
                width: 165,
                height: 165,
                decoration: BoxDecoration(
                  color: const Color(0xFFECE9F1),
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              Positioned(
                top: 45,
                child: Container(
                  width: 96,
                  height: 12,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD8E7E5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Positioned(
                top: 61,
                child: Container(
                  width: 102,
                  height: 8,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD8E7E5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Positioned(
                top: 80,
                left: 54,
                child: _PuzzlePiece(color: const Color(0xFF2E9438), angle: -0.6),
              ),
              Positioned(
                top: 78,
                left: 98,
                child: _PuzzlePiece(color: const Color(0xFFF2C2E1), angle: 0.55),
              ),
              Positioned(
                top: 69,
                left: 142,
                child: _PuzzlePiece(color: const Color(0xFFE60023), angle: 0.75),
              ),
              Positioned(
                top: 136,
                left: 58,
                child: _PuzzlePiece(color: const Color(0xFFF4B04C), angle: 0.0),
              ),
              Positioned(
                top: 126,
                left: 110,
                child: _PuzzlePiece(color: const Color(0xFFD4E173), angle: -0.3),
              ),
              Positioned(
                top: 146,
                left: 156,
                child: _PuzzlePiece(color: const Color(0xFF7FE0D0), angle: -0.5),
              ),
              Positioned(
                top: 168,
                left: 94,
                child: _PuzzlePiece(color: const Color(0xFF2C8C32), angle: 0.45),
              ),
              Positioned(
                top: 152,
                left: 28,
                child: _PuzzlePiece(color: const Color(0xFF89E2D7), angle: -0.85),
              ),
              Positioned(
                top: 176,
                left: 22,
                child: _PuzzlePiece(color: const Color(0xFFD8D05C), angle: -0.55),
              ),
            ],
          ),
        );

      case _SavedIllustrationType.boards:
        return SizedBox(
          width: 270,
          height: 225,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 195,
                height: 195,
                decoration: const BoxDecoration(
                  color: Color(0xFFE7D1F0),
                  shape: BoxShape.circle,
                ),
              ),
              Positioned(
                top: 30,
                child: Container(
                  width: 170,
                  height: 6,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD895E3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              Positioned(
                top: 29,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFF9A256B),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                top: 40,
                child: Container(
                  width: 204,
                  height: 126,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7C68E),
                    border: Border.all(
                      color: const Color(0xFFF46F3E),
                      width: 6,
                    ),
                  ),
                ),
              ),
              const Positioned(
                top: 53,
                left: 60,
                child: _BoardPaper(color: Color(0xFFFF5A2C), angle: -0.2),
              ),
              const Positioned(
                top: 62,
                left: 108,
                child: _BoardPaper(color: Color(0xFFE1D75E), angle: -0.03),
              ),
              const Positioned(
                top: 70,
                left: 158,
                child: _BoardPaper(color: Color(0xFFF0D98C), angle: 0.22),
              ),
              const Positioned(
                top: 118,
                left: 46,
                child: _BoardPaper(color: Color(0xFFECE57F), angle: 0.08),
              ),
              const Positioned(
                top: 140,
                left: 76,
                child: _BoardPaper(color: Color(0xFFB554C8), angle: 0.25),
              ),
              const Positioned(
                top: 114,
                left: 104,
                child: _BoardPaper(color: Color(0xFFF4EFF4), angle: 0.0),
              ),
              const Positioned(
                top: 126,
                left: 156,
                child: _BoardPaper(color: Color(0xFF6FD7BF), angle: -0.04),
              ),
              Positioned(
                top: 62,
                right: 38,
                child: Transform.rotate(
                  angle: 0.12,
                  child: Container(
                    width: 40,
                    height: 56,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF7E7EA),
                      border: Border.all(
                        color: Colors.white,
                        width: 3,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        '🧁',
                        style: TextStyle(fontSize: 18),
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
          width: 245,
          height: 245,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 205,
                height: 205,
                decoration: const BoxDecoration(
                  color: Color(0xFFDCD4F1),
                  shape: BoxShape.circle,
                ),
              ),
              Positioned(
                top: 36,
                left: 72,
                child: Transform.rotate(
                  angle: 0.18,
                  child: Container(
                    width: 62,
                    height: 74,
                    decoration: const BoxDecoration(
                      color: Color(0xFF7CB7E8),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 100,
                left: 48,
                child: Transform.rotate(
                  angle: -0.42,
                  child: Container(
                    width: 94,
                    height: 72,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF0B097),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 154,
                left: 38,
                child: Transform.rotate(
                  angle: -0.32,
                  child: Container(
                    width: 38,
                    height: 34,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE60023),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 148,
                right: 44,
                child: Transform.rotate(
                  angle: 0.22,
                  child: Container(
                    width: 46,
                    height: 38,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFF6A2D),
                    ),
                  ),
                ),
              ),
              const Positioned(
                top: 82,
                left: 74,
                child: RotatedBox(
                  quarterTurns: 0,
                  child: Icon(
                    Icons.content_cut,
                    size: 96,
                    color: Color(0xFF6279E8),
                  ),
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
    return Transform.rotate(
      angle: angle,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
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
    return Transform.rotate(
      angle: angle,
      child: Container(
        width: 46,
        height: 50,
        decoration: BoxDecoration(
          color: color,
        ),
      ),
    );
  }
}