import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pinterest_clone/screens/pin_detail_screen.dart';
import '../features/home/state/home_feed_controller.dart';
import '../features/home/widgets/four_dot_refresh_loader.dart';
import '../features/home/widgets/home_feed_loading_grid.dart';
import '../features/home/widgets/home_pin_card.dart';
import '../features/home/widgets/personalized_button.dart';
import '../routes/route_transition.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  bool _showRefreshHeader = false;
  double _pullExtent = 0;
  bool _refreshTriggered = false;
  int _bottomNavIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScrollChanged);
  }

  void _onScrollChanged() {
    final position = _scrollController.position;
    final state = ref.read(homeFeedControllerProvider);

    if (position.pixels >= position.maxScrollExtent - 300) {
      ref.read(homeFeedControllerProvider.notifier).loadMore();
    }

    if (position.pixels > 0 && _showRefreshHeader && !_refreshTriggered) {
      setState(() {
        _showRefreshHeader = false;
        _pullExtent = 0;
      });
    }

    if (state.isLoadingMore) {
      setState(() {});
    }
  }

  Future<void> _handleRefresh() async {
    if (_refreshTriggered) return;

    setState(() {
      _refreshTriggered = true;
      _showRefreshHeader = true;
    });

    await ref.read(homeFeedControllerProvider.notifier).refreshFeed();

    if (!mounted) return;

    await Future.delayed(const Duration(milliseconds: 350));

    setState(() {
      _refreshTriggered = false;
      _showRefreshHeader = false;
      _pullExtent = 0;
    });
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification.metrics.axis != Axis.vertical) return false;

    if (notification.metrics.pixels <= 0) {
      if (notification is OverscrollNotification && !_refreshTriggered) {
        setState(() {
          _pullExtent =
              (_pullExtent + notification.overscroll.abs()).clamp(0.0, 42.0);
          _showRefreshHeader = _pullExtent > 6;
        });
      }

      if (notification is ScrollUpdateNotification &&
          notification.dragDetails != null &&
          !_refreshTriggered) {
        final overscroll = (-notification.metrics.pixels).clamp(0.0, 42.0);
        setState(() {
          _pullExtent = overscroll;
          _showRefreshHeader = overscroll > 6;
        });
      }
    }

    if (notification is ScrollEndNotification) {
      if (_pullExtent >= 32 && !_refreshTriggered) {
        _handleRefresh();
      } else if (!_refreshTriggered) {
        setState(() {
          _pullExtent = 0;
          _showRefreshHeader = false;
        });
      }
    }

    return false;
  }

  double _itemHeightForIndex(int index) {
    const heights = [420.0, 285.0, 250.0, 360.0, 260.0, 390.0, 240.0, 330.0];
    return heights[index % heights.length];
  }

  void _handleBottomNavTap(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScrollChanged)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeFeedControllerProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F4),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 15, left: 8),
                      child: _ForYouHeader(),
                    ),
                  ),
                  PersonalizedIcon(),
                ],
              ),
            ),

            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOut,
              height: _showRefreshHeader
                  ? (_refreshTriggered ? 42 : _pullExtent.clamp(0.0, 42.0))
                  : 0,
              alignment: Alignment.center,
              child: Opacity(
                opacity: _showRefreshHeader ? 1 : 0,
                child: const Padding(
                  padding: EdgeInsets.only(bottom: 4),
                  child: FourDotRefreshLoader(
                    size: 30,
                    dotSize: 6.5,
                  ),
                ),
              ),
            ),

            Expanded(
              child: NotificationListener<ScrollNotification>(
                onNotification: _handleScrollNotification,
                child: CustomScrollView(
                  controller: _scrollController,
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  slivers: [
                    if (state.isInitialLoading)
                      const HomeFeedLoadingGrid()
                    else if (state.items.isEmpty)
                      const SliverFillRemaining(
                        child: Center(
                          child: Text(
                            'No images found',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      )
                    else
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 100),
                        sliver: SliverMasonryGrid.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childCount: state.items.length,
                          itemBuilder: (context, index) {
                            final item = state.items[index];
                            return HomePinCard(
                              item: item,
                              height: _itemHeightForIndex(index),
                              onTap: () {
                                final related = state.items
                                    .where((e) => e.id != item.id)
                                    .take(6)
                                    .toList();

                                Navigator.push(
                                  context,
                                  buildSlideRoute(
                                    child: PinDetailScreen(
                                      item: item,
                                      relatedItems: related,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ForYouHeader extends StatelessWidget {
  const _ForYouHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'For you',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
            letterSpacing: -0.4,
          ),
        ),
        SizedBox(height: 1),
        SizedBox(
          width: 52,
          child: Divider(
            thickness: 2,
            height: 1,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}