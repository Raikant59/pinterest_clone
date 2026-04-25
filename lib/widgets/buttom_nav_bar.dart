import 'package:flutter/material.dart';
import '../utils/app_responsive.dart';

class HomeBottomNavBar extends StatelessWidget {
  const HomeBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.savedAvatarLetter,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final String savedAvatarLetter;

  @override
  Widget build(BuildContext context) {
    final double navHeight =
    AppResponsive.h(context, 78).clamp(68.0, 84.0);
    final double topPadding =
    AppResponsive.h(context, 6).clamp(4.0, 8.0);
    final double bottomPadding =
    AppResponsive.h(context, 6).clamp(4.0, 8.0);

    return Container(
      height: navHeight,
      color: Colors.white,
      padding: EdgeInsets.only(
        top: topPadding,
        bottom: bottomPadding,
      ),
      child: Row(
        children: [
          _NavItem(
            isSelected: currentIndex == 0,
            selectedIcon: Icons.home_filled,
            unselectedIcon: Icons.home_outlined,
            label: 'Home',
            onTap: () => onTap(0),
          ),
          _NavItem(
            isSelected: currentIndex == 1,
            selectedIcon: Icons.search,
            unselectedIcon: Icons.search,
            label: 'Search',
            onTap: () => onTap(1),
          ),
          _NavItem(
            isSelected: currentIndex == 2,
            selectedIcon: Icons.add_circle,
            unselectedIcon: Icons.add_circle_outline,
            label: 'Create',
            onTap: () => onTap(2),
          ),
          _NavItem(
            isSelected: currentIndex == 3,
            selectedIcon: Icons.chat_bubble,
            unselectedIcon: Icons.chat_bubble_outline,
            label: 'Inbox',
            onTap: () => onTap(3),
          ),
          _SavedNavItem(
            isSelected: currentIndex == 4,
            label: 'Saved',
            letter: savedAvatarLetter,
            onTap: () => onTap(4),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.isSelected,
    required this.selectedIcon,
    required this.unselectedIcon,
    required this.label,
    required this.onTap,
  });

  final bool isSelected;
  final IconData selectedIcon;
  final IconData unselectedIcon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final double selectedIconSize =
    AppResponsive.r(context, 29).clamp(24.0, 31.0);
    final double unselectedIconSize =
    AppResponsive.r(context, 27).clamp(22.0, 29.0);
    final double labelSize =
    AppResponsive.sp(context, 11).clamp(10.0, 12.5);
    final double gap =
    AppResponsive.h(context, 2).clamp(1.0, 4.0);

    return Expanded(
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSelected ? selectedIcon : unselectedIcon,
              size: isSelected ? selectedIconSize : unselectedIconSize,
              color: Colors.black,
            ),
            SizedBox(height: gap),
            Text(
              label,
              style: TextStyle(
                fontSize: labelSize,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SavedNavItem extends StatelessWidget {
  const _SavedNavItem({
    required this.isSelected,
    required this.label,
    required this.letter,
    required this.onTap,
  });

  final bool isSelected;
  final String label;
  final String letter;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final double selectedSize =
    AppResponsive.r(context, 30).clamp(26.0, 32.0);
    final double unselectedSize =
    AppResponsive.r(context, 28).clamp(24.0, 30.0);
    final double borderWidth =
    AppResponsive.r(context, 1.5).clamp(1.0, 2.0);
    final double textSizeSelected =
    AppResponsive.sp(context, 13).clamp(11.0, 14.0);
    final double textSizeUnselected =
    AppResponsive.sp(context, 12).clamp(10.0, 13.0);
    final double labelSize =
    AppResponsive.sp(context, 11).clamp(10.0, 12.5);
    final double gap =
    AppResponsive.h(context, 2).clamp(1.0, 4.0);

    return Expanded(
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: isSelected ? selectedSize : unselectedSize,
              height: isSelected ? selectedSize : unselectedSize,
              decoration: BoxDecoration(
                color: const Color(0xFFB45ADC),
                shape: BoxShape.circle,
                border: isSelected
                    ? Border.all(
                  color: Colors.black,
                  width: borderWidth,
                )
                    : null,
              ),
              alignment: Alignment.center,
              child: Text(
                letter,
                style: TextStyle(
                  fontSize:
                  isSelected ? textSizeSelected : textSizeUnselected,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: gap),
            Text(
              label,
              style: TextStyle(
                fontSize: labelSize,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}