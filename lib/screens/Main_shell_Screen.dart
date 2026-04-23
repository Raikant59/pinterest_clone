import 'package:flutter/material.dart';
import 'HomeScreen.dart';
import 'create_screen.dart';
import 'inbox_screen.dart';
import 'saved_screen.dart';
import 'search_screen.dart';
import '../widgets/buttom_nav_bar.dart';

class MainShellScreen extends StatefulWidget {
  final int currentIndex;

  const MainShellScreen({
    super.key,
    required this.currentIndex,
  });

  @override
  State<MainShellScreen> createState() => _MainShellScreenState();
}

class _MainShellScreenState extends State<MainShellScreen> {
  late int _currentIndex;

  final List<Widget> _pages = const [
    HomeScreen(),
    SearchScreen(),
    CreateScreen(),
    InboxScreen(),
    SavedScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
  }

  @override
  void didUpdateWidget(covariant MainShellScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      _currentIndex = widget.currentIndex;
    }
  }

  void _handleBottomNavTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F4),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: HomeBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _handleBottomNavTap,
      ),
    );
  }
}