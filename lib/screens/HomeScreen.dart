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
import '../utils/app_responsive.dart';

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

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScrollChanged);
  }

  void _onScrollChanged() {
    final position = _scrollController.position;
    final state = ref.read(homeFeedControllerProvider);

    final double loadMoreTrigger =
    AppResponsive.h(context, 300).clamp(240.0, 340.0);

    if (position.pixels >= position.maxScrollExtent - loadMoreTrigger) {
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

    final double maxPull =
    AppResponsive.h(context, 42).clamp(36.0, 46.0);
    final double showThreshold =
    AppResponsive.h(context, 6).clamp(5.0, 7.0);
    final double triggerThreshold =
    AppResponsive.h(context, 32).clamp(28.0, 34.0);

    if (notification.metrics.pixels <= 0) {
      if (notification is OverscrollNotification && !_refreshTriggered) {
        setState(() {
          _pullExtent =
              (_pullExtent + notification.overscroll.abs()).clamp(0.0, maxPull);
          _showRefreshHeader = _pullExtent > showThreshold;
        });
      }

      if (notification is ScrollUpdateNotification &&
          notification.dragDetails != null &&
          !_refreshTriggered) {
        final overscroll = (-notification.metrics.pixels).clamp(0.0, maxPull);
        setState(() {
          _pullExtent = overscroll;
          _showRefreshHeader = overscroll > showThreshold;
        });
      }
    }

    if (notification is ScrollEndNotification) {
      if (_pullExtent >= triggerThreshold && !_refreshTriggered) {
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
    final double scale = AppResponsive.scale(context).clamp(0.9, 1.08);
    const baseHeights = [420.0, 285.0, 250.0, 360.0, 260.0, 390.0, 240.0, 330.0];
    return baseHeights[index % baseHeights.length] * scale;
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

    final double outerHorizontal =
    AppResponsive.w(context, 8).clamp(6.0, 10.0);
    final double headerTop =
    AppResponsive.h(context, 8).clamp(6.0, 10.0);
    final double headerBottom =
    AppResponsive.h(context, 14).clamp(10.0, 16.0);
    final double refreshMaxHeight =
    AppResponsive.h(context, 42).clamp(36.0, 46.0);
    final double refreshBottomPadding =
    AppResponsive.h(context, 4).clamp(2.0, 6.0);
    final double gridBottom =
    AppResponsive.h(context, 100).clamp(84.0, 110.0);
    final double gridSpacing =
    AppResponsive.w(context, 10).clamp(8.0, 12.0);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F4),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                outerHorizontal,
                headerTop,
                outerHorizontal,
                headerBottom,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: AppResponsive.h(context, 15).clamp(12.0, 16.0),
                        left: AppResponsive.w(context, 8).clamp(6.0, 10.0),
                      ),
                      child: const _ForYouHeader(),
                    ),
                  ),
                  const PersonalizedIcon(),
                ],
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOut,
              height: _showRefreshHeader
                  ? (_refreshTriggered
                  ? refreshMaxHeight
                  : _pullExtent.clamp(0.0, refreshMaxHeight))
                  : 0,
              alignment: Alignment.center,
              child: Opacity(
                opacity: _showRefreshHeader ? 1 : 0,
                child: Padding(
                  padding: EdgeInsets.only(bottom: refreshBottomPadding),
                  child: FourDotRefreshLoader(
                    size: AppResponsive.r(context, 30).clamp(26.0, 32.0),
                    dotSize: AppResponsive.r(context, 6.5).clamp(5.5, 7.0),
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
                      SliverFillRemaining(
                        child: Center(
                          child: Text(
                            'No images found',
                            style: TextStyle(
                              fontSize:
                              AppResponsive.sp(context, 16).clamp(14.0, 17.0),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      )
                    else
                      SliverPadding(
                        padding: EdgeInsets.fromLTRB(
                          outerHorizontal,
                          0,
                          outerHorizontal,
                          gridBottom,
                        ),
                        sliver: SliverMasonryGrid.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: gridSpacing,
                          crossAxisSpacing: gridSpacing,
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
    final double titleSize =
    AppResponsive.sp(context, 16).clamp(14.0, 17.0);
    final double gap =
    AppResponsive.h(context, 1).clamp(1.0, 3.0);
    final double underlineWidth =
    AppResponsive.w(context, 52).clamp(44.0, 56.0);
    final double underlineThickness =
    AppResponsive.h(context, 2).clamp(1.5, 2.5);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'For you',
          style: TextStyle(
            fontSize: titleSize,
            fontWeight: FontWeight.w500,
            color: Colors.black,
            letterSpacing: -0.4,
          ),
        ),
        SizedBox(height: gap),
        SizedBox(
          width: underlineWidth,
          child: Divider(
            thickness: underlineThickness,
            height: underlineThickness,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}