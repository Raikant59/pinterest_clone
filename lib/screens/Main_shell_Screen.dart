import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/auth/state/providers.dart';
import '../widgets/buttom_nav_bar.dart';
import 'HomeScreen.dart';
import 'create_screen.dart';
import 'inbox_screen.dart';
import 'saved_screen.dart';
import 'search_screen.dart';

class MainShellScreen extends ConsumerStatefulWidget {
  final int currentIndex;

  const MainShellScreen({
    super.key,
    required this.currentIndex,
  });

  @override
  ConsumerState<MainShellScreen> createState() => _MainShellScreenState();
}

class _MainShellScreenState extends ConsumerState<MainShellScreen> {
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
    final auth = ref.watch(authControllerProvider);
    final name =
    (auth.userName != null && auth.userName!.trim().isNotEmpty)
        ? auth.userName!.trim()
        : 'U';
    final letter = name[0].toUpperCase();

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F4),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: HomeBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _handleBottomNavTap,
        savedAvatarLetter: letter,
      ),
    );
  }
}