import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../features/home/model/home_feed_item.dart';
import '../utils/app_responsive.dart';

class PinDetailScreen extends StatelessWidget {
  final HomeFeedItem item;
  final List<HomeFeedItem> relatedItems;

  const PinDetailScreen({
    super.key,
    required this.item,
    required this.relatedItems,
  });

  String _buildTitle() {
    if (item.alt.trim().isNotEmpty) {
      return item.alt.trim();
    }

    if (item.photographer.trim().isNotEmpty) {
      return '${item.photographer.trim()} inspiration';
    }

    return 'Creative pin';
  }

  String _buildCreatorName() {
    if (item.photographer.trim().isNotEmpty) {
      return item.photographer.trim();
    }
    return 'Pinterest creator';
  }

  @override
  Widget build(BuildContext context) {
    final title = _buildTitle();
    final creator = _buildCreatorName();

    final double outerHorizontal =
    AppResponsive.w(context, 8).clamp(6.0, 12.0);
    final double topPadding =
    AppResponsive.h(context, 8).clamp(6.0, 10.0);
    final double titleHorizontal =
    AppResponsive.w(context, 12).clamp(10.0, 16.0);
    final double betweenHeroAndActions =
    AppResponsive.h(context, 14).clamp(10.0, 16.0);
    final double betweenActionsAndCreator =
    AppResponsive.h(context, 16).clamp(12.0, 18.0);
    final double betweenCreatorAndTitle =
    AppResponsive.h(context, 8).clamp(6.0, 10.0);
    final double betweenTitleAndExplore =
    AppResponsive.h(context, 18).clamp(14.0, 20.0);
    final double betweenExploreAndGrid =
    AppResponsive.h(context, 14).clamp(10.0, 16.0);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F4),
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  outerHorizontal,
                  topPadding,
                  outerHorizontal,
                  0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _PinHeroSection(item: item),
                    SizedBox(height: betweenHeroAndActions),
                    const _PinActionRow(),
                    SizedBox(height: betweenActionsAndCreator),
                    _CreatorRow(creatorName: creator),
                    SizedBox(height: betweenCreatorAndTitle),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: titleHorizontal),
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: AppResponsive.sp(context, 18)
                              .clamp(16.0, 20.0),
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          height: 1.1,
                          letterSpacing: -0.7,
                        ),
                      ),
                    ),
                    SizedBox(height: betweenTitleAndExplore),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: titleHorizontal),
                      child: Text(
                        'More to explore',
                        style: TextStyle(
                          fontSize: AppResponsive.sp(context, 20)
                              .clamp(18.0, 22.0),
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          letterSpacing: -0.4,
                        ),
                      ),
                    ),
                    SizedBox(height: betweenExploreAndGrid),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(
                outerHorizontal,
                0,
                outerHorizontal,
                AppResponsive.h(context, 28).clamp(20.0, 32.0),
              ),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    final related = relatedItems[index];
                    return _RelatedPinCard(item: related);
                  },
                  childCount: relatedItems.length,
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing:
                  AppResponsive.w(context, 10).clamp(8.0, 12.0),
                  mainAxisSpacing:
                  AppResponsive.h(context, 10).clamp(8.0, 12.0),
                  childAspectRatio: 0.72,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PinHeroSection extends StatelessWidget {
  final HomeFeedItem item;

  const _PinHeroSection({
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final double radius =
    AppResponsive.r(context, 26).clamp(20.0, 28.0);
    final double topInset =
    AppResponsive.h(context, 14).clamp(10.0, 16.0);
    final double leftInset =
    AppResponsive.w(context, 14).clamp(10.0, 16.0);
    final double rightInset =
    AppResponsive.w(context, 12).clamp(10.0, 14.0);
    final double bottomInset =
    AppResponsive.h(context, 10).clamp(8.0, 12.0);
    final double searchBoxSize =
    AppResponsive.r(context, 48).clamp(42.0, 52.0);
    final double searchBoxRadius =
    AppResponsive.r(context, 18).clamp(14.0, 20.0);
    final double searchIconSize =
    AppResponsive.r(context, 24).clamp(20.0, 26.0);

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Stack(
        children: [
          AspectRatio(
            aspectRatio: item.aspectRatio == 0 ? 1 : item.aspectRatio,
            child: CachedNetworkImage(
              imageUrl: item.imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) {
                return Shimmer.fromColors(
                  baseColor: const Color(0xFFEAEAEA),
                  highlightColor: const Color(0xFFF7F7F7),
                  child: Container(color: Colors.white),
                );
              },
              errorWidget: (context, url, error) {
                return Container(
                  color: const Color(0xFFEAEAEA),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.broken_image_outlined,
                    size: AppResponsive.r(context, 42).clamp(34.0, 46.0),
                    color: Colors.grey,
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: topInset,
            left: leftInset,
            child: _TopCircleIcon(
              icon: Icons.arrow_back_ios_new,
              onTap: () => Navigator.pop(context),
            ),
          ),
          Positioned(
            right: rightInset,
            bottom: bottomInset,
            child: Container(
              width: searchBoxSize,
              height: searchBoxSize,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.96),
                borderRadius: BorderRadius.circular(searchBoxRadius),
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.search_outlined,
                size: searchIconSize,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TopCircleIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _TopCircleIcon({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double boxSize =
    AppResponsive.r(context, 48).clamp(42.0, 52.0);
    final double iconSize =
    AppResponsive.r(context, 24).clamp(20.0, 26.0);
    final double radius =
    AppResponsive.r(context, 22).clamp(18.0, 24.0);

    return Material(
      color: Colors.white.withOpacity(0.72),
      borderRadius: BorderRadius.circular(radius),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(radius),
        child: SizedBox(
          width: boxSize,
          height: boxSize,
          child: Icon(
            icon,
            size: iconSize,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

class _PinActionRow extends StatelessWidget {
  const _PinActionRow();

  @override
  Widget build(BuildContext context) {
    final double horizontal =
    AppResponsive.w(context, 10).clamp(8.0, 12.0);
    final double smallIconSize =
    AppResponsive.r(context, 21).clamp(18.0, 23.0);
    final double countSize =
    AppResponsive.sp(context, 15).clamp(13.0, 16.0);
    final double gapSmall =
    AppResponsive.w(context, 10).clamp(8.0, 12.0);
    final double gapLarge =
    AppResponsive.w(context, 26).clamp(18.0, 28.0);
    final double saveHorizontal =
    AppResponsive.w(context, 20).clamp(16.0, 24.0);
    final double saveVertical =
    AppResponsive.h(context, 12).clamp(10.0, 14.0);
    final double saveRadius =
    AppResponsive.r(context, 18).clamp(16.0, 20.0);
    final double saveFont =
    AppResponsive.sp(context, 15).clamp(13.0, 16.0);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal),
      child: Row(
        children: [
          Icon(Icons.favorite_border, size: smallIconSize, color: Colors.black),
          SizedBox(width: gapSmall),
          Text(
            '23',
            style: TextStyle(
              fontSize: countSize,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          SizedBox(width: gapLarge),
          Icon(Icons.mode_comment_outlined,
              size: smallIconSize, color: Colors.black),
          SizedBox(width: gapLarge),
          Icon(Icons.share_outlined, size: smallIconSize, color: Colors.black),
          SizedBox(width: gapLarge),
          Icon(Icons.more_horiz, size: smallIconSize, color: Colors.black),
          const Spacer(),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: saveHorizontal,
              vertical: saveVertical,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFE60023),
              borderRadius: BorderRadius.circular(saveRadius),
            ),
            child: Text(
              'Save',
              style: TextStyle(
                fontSize: saveFont,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CreatorRow extends StatelessWidget {
  final String creatorName;

  const _CreatorRow({
    required this.creatorName,
  });

  @override
  Widget build(BuildContext context) {
    final letter = creatorName.isNotEmpty ? creatorName[0].toUpperCase() : 'P';

    final double horizontal =
    AppResponsive.w(context, 12).clamp(10.0, 16.0);
    final double avatarSize =
    AppResponsive.r(context, 24).clamp(22.0, 28.0);
    final double avatarFont =
    AppResponsive.sp(context, 12).clamp(11.0, 13.0);
    final double gap =
    AppResponsive.w(context, 6).clamp(4.0, 8.0);
    final double nameSize =
    AppResponsive.sp(context, 12).clamp(11.0, 13.0);
    final double trailingSize =
    AppResponsive.r(context, 32).clamp(28.0, 34.0);
    final double trailingRadius =
    AppResponsive.r(context, 14).clamp(12.0, 16.0);
    final double trailingIcon =
    AppResponsive.r(context, 18).clamp(16.0, 20.0);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal),
      child: Row(
        children: [
          Container(
            width: avatarSize,
            height: avatarSize,
            decoration: const BoxDecoration(
              color: Color(0xFF5A69C7),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              letter,
              style: TextStyle(
                fontSize: avatarFont,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(width: gap),
          Expanded(
            child: Text(
              creatorName,
              style: TextStyle(
                fontSize: nameSize,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          Container(
            width: trailingSize,
            height: trailingSize,
            decoration: BoxDecoration(
              color: const Color(0xFFE9E9E2),
              borderRadius: BorderRadius.circular(trailingRadius),
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.keyboard_arrow_down,
              size: trailingIcon,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class _RelatedPinCard extends StatelessWidget {
  final HomeFeedItem item;

  const _RelatedPinCard({
    required this.item,
  });

  String _title() {
    if (item.alt.trim().isNotEmpty) return item.alt.trim();
    if (item.photographer.trim().isNotEmpty) {
      return '${item.photographer.trim()} idea';
    }
    return 'Creative inspiration';
  }

  @override
  Widget build(BuildContext context) {
    final double radius =
    AppResponsive.r(context, 22).clamp(18.0, 24.0);
    final double overlayHorizontal =
    AppResponsive.w(context, 12).clamp(8.0, 12.0);
    final double overlayBottom =
    AppResponsive.h(context, 12).clamp(8.0, 12.0);
    final double overlayInnerHorizontal =
    AppResponsive.w(context, 10).clamp(8.0, 12.0);
    final double overlayInnerVertical =
    AppResponsive.h(context, 8).clamp(6.0, 9.0);
    final double overlayRadius =
    AppResponsive.r(context, 14).clamp(12.0, 16.0);
    final double titleSize =
    AppResponsive.sp(context, 13).clamp(11.0, 13.5);

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Stack(
        children: [
          Positioned.fill(
            child: CachedNetworkImage(
              imageUrl: item.imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) {
                return Shimmer.fromColors(
                  baseColor: const Color(0xFFEAEAEA),
                  highlightColor: const Color(0xFFF7F7F7),
                  child: Container(color: Colors.white),
                );
              },
              errorWidget: (context, url, error) {
                return Container(
                  color: const Color(0xFFEAEAEA),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.broken_image_outlined,
                    size: AppResponsive.r(context, 24).clamp(20.0, 28.0),
                  ),
                );
              },
            ),
          ),
          Positioned(
            left: overlayHorizontal,
            right: overlayHorizontal,
            bottom: overlayBottom,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: overlayInnerHorizontal,
                vertical: overlayInnerVertical,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.28),
                borderRadius: BorderRadius.circular(overlayRadius),
              ),
              child: Text(
                _title(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: titleSize,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  height: 1.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}