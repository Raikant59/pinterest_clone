import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/search/state/search_screen_controller.dart';
import '../features/search/widgets/idea_board_card.dart';
import '../features/search/widgets/search_hero_section.dart';
import '../features/search/widgets/search_screen_loading.dart';
import '../features/search/widgets/search_collage_section.dart';
import '../utils/app_responsive.dart';

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

    final double outerHorizontal =
    AppResponsive.w(context, 12).clamp(10.0, 16.0);
    final double topPadding =
    AppResponsive.h(context, 8).clamp(6.0, 12.0);
    final double bottomPadding =
    AppResponsive.h(context, 12).clamp(10.0, 16.0);
    final double sectionHorizontal =
    AppResponsive.w(context, 18).clamp(14.0, 22.0);
    final double ideaListHeight =
    AppResponsive.h(context, 220).clamp(190.0, 240.0);
    final double ideaCardWidth =
    AppResponsive.w(context, 200).clamp(170.0, 220.0);
    final double ideaCardSpacing =
    AppResponsive.w(context, 12).clamp(8.0, 14.0);
    final double dotsTop =
    AppResponsive.h(context, 10).clamp(8.0, 12.0);
    final double dotsBottom =
    AppResponsive.h(context, 14).clamp(10.0, 16.0);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F4),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                outerHorizontal,
                topPadding,
                outerHorizontal,
                bottomPadding,
              ),
              child: const _SearchBar(),
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
                        padding: EdgeInsets.only(
                          top: dotsTop,
                          bottom: dotsBottom,
                        ),
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
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        sectionHorizontal,
                        0,
                        sectionHorizontal,
                        AppResponsive.h(context, 2).clamp(1.0, 3.0),
                      ),
                      child: Text(
                        'Explore featured boards',
                        style: TextStyle(
                          fontSize:
                          AppResponsive.sp(context, 12).clamp(11.0, 13.0),
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        sectionHorizontal,
                        0,
                        sectionHorizontal,
                        AppResponsive.h(context, 14).clamp(10.0, 16.0),
                      ),
                      child: Text(
                        'Ideas you might like',
                        style: TextStyle(
                          fontSize:
                          AppResponsive.sp(context, 20).clamp(18.0, 22.0),
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
                      height: ideaListHeight,
                      child: ListView.separated(
                        padding: EdgeInsets.fromLTRB(
                          sectionHorizontal,
                          0,
                          sectionHorizontal,
                          AppResponsive.h(context, 20).clamp(14.0, 24.0),
                        ),
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.boardItems.length,
                        separatorBuilder: (context, index) => SizedBox(
                          width: ideaCardSpacing,
                        ),
                        itemBuilder: (context, index) {
                          final item = state.boardItems[index];
                          return SizedBox(
                            width: ideaCardWidth,
                            child: IdeaBoardCard(item: item),
                          );
                        },
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        final section = state.collageSections[index];
                        return SearchCollageSectionWidget(section: section);
                      },
                      childCount: state.collageSections.length,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: AppResponsive.h(context, 100)
                          .clamp(80.0, 120.0),
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
    final double height =
    AppResponsive.h(context, 50).clamp(46.0, 56.0);
    final double horizontalPadding =
    AppResponsive.w(context, 10).clamp(8.0, 14.0);
    final double radius =
    AppResponsive.r(context, 18).clamp(16.0, 20.0);
    final double borderWidth =
    AppResponsive.r(context, 1.4).clamp(1.0, 1.5);
    final double iconSize =
    AppResponsive.r(context, 25).clamp(22.0, 28.0);
    final double textSize =
    AppResponsive.sp(context, 18).clamp(16.0, 19.0);
    final double gap =
    AppResponsive.w(context, 14).clamp(10.0, 16.0);

    return Container(
      height: height,
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F6),
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color: const Color(0xFFAFAFAA),
          width: borderWidth,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            size: iconSize,
            color: Colors.black,
          ),
          SizedBox(width: gap),
          Expanded(
            child: Text(
              'Search for ideas',
              style: TextStyle(
                fontSize: textSize,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF6D6D68),
                letterSpacing: -0.2,
              ),
            ),
          ),
          Icon(
            Icons.photo_camera_outlined,
            size: iconSize,
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

    final double selectedSize =
    AppResponsive.r(context, 10).clamp(8.0, 11.0);
    final double unselectedSize =
    AppResponsive.r(context, 8).clamp(6.0, 9.0);
    final double horizontalMargin =
    AppResponsive.w(context, 3).clamp(2.0, 4.0);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final selected = index == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          margin: EdgeInsets.symmetric(horizontal: horizontalMargin),
          width: selected ? selectedSize : unselectedSize,
          height: selected ? selectedSize : unselectedSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: selected ? Colors.black : const Color(0xFFA6A6A1),
          ),
        );
      }),
    );
  }
}