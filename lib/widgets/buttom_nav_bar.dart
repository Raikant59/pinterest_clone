import 'package:flutter/material.dart';

class HomeBottomNavBar extends StatelessWidget {
  const HomeBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      color: Colors.white,
      padding: const EdgeInsets.only(top: 5, bottom: 5),
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
              size: isSelected ? 24 : 26,
              color: Colors.black,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
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
    required this.onTap,
  });

  final bool isSelected;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: isSelected ? 26 : 24,
              height: isSelected ? 26 : 24,
              decoration: const BoxDecoration(
                color: Color(0xFFB45ADC),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                '0',
                style: TextStyle(
                  fontSize: isSelected ? 11 : 9,
                  fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
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