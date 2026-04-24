import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/search/state/search_screen_controller.dart';
import '../features/search/widgets/idea_board_card.dart';
import '../features/search/widgets/search_screen_loading.dart';
import '../features/search/widgets/search_hero_section.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final PageController _pageController = PageController(viewportFraction: 1);
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      final page = _pageController.page?.round() ?? 0;
      if (page != _currentPage && mounted) {
        setState(() {
          _currentPage = page;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(searchScreenControllerProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F4),
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(15, 8, 15, 10),
              child: _SearchBar(),
            ),
            Expanded(
              child: state.isInitialLoading
                  ? const SearchScreenLoading()
                  : CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  if (state.featuredItems.isNotEmpty) ...[
                    SliverToBoxAdapter(
                      child: SearchTopBanner(
                        controller: _pageController,
                        items: state.featuredItems,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 14),
                        child: _DotsIndicator(
                          count: state.featuredItems.length,
                          currentIndex: _currentPage.clamp(
                            0,
                            state.featuredItems.length - 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(18, 0, 18, 2),
                      child: Text(
                        'Explore featured boards',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(18, 0, 18, 14),
                      child: Text(
                        'Ideas you might like',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                          height: 1.1,
                          letterSpacing: -0.2,
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 330,
                      child: ListView.separated(
                        padding: const EdgeInsets.fromLTRB(18, 0, 18, 110),
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.boardItems.length,
                        separatorBuilder: (context, index) => const SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          final item = state.boardItems[index];
                          return SizedBox(
                            width: 220,
                            child: IdeaBoardCard(item: item),
                          );
                        },
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

class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFAFAFAA),
          width: 1.4,
        ),
      ),
      child: Row(
        children: const [
          Icon(
            Icons.search,
            size: 25,
            color: Colors.black,
          ),
          SizedBox(width: 14),
          Expanded(
            child: Text(
              'Search for ideas',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Color(0xFF6D6D68),
                letterSpacing: -0.2,
              ),
            ),
          ),
          Icon(
            Icons.photo_camera_outlined,
            size: 25,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}

class _DotsIndicator extends StatelessWidget {
  final int count;
  final int currentIndex;

  const _DotsIndicator({
    required this.count,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    if (count <= 1) return const SizedBox.shrink();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final selected = index == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: selected ? 9 : 7,
          height: selected ? 9 : 7,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: selected ? Colors.black : const Color(0xFFA6A6A1),
          ),
        );
      }),
    );
  }
}