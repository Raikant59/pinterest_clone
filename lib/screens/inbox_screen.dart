import 'package:flutter/material.dart';
import '../utils/app_responsive.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  void _handleComposeTap(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Compose action can be connected later'),
      ),
    );
  }

  void _handleSeeAllTap(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('See all page can be connected later'),
      ),
    );
  }

  void _handleInviteFriendsTap(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Invite friends page can be connected later'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double horizontal =
    AppResponsive.w(context, 14).clamp(12.0, 18.0);
    final double betweenHeaderAndMessages =
    AppResponsive.h(context, 2).clamp(0.0, 4.0);
    final double betweenMessagesAndInvite =
    AppResponsive.h(context, 7).clamp(6.0, 10.0);
    final double betweenInviteAndUpdates =
    AppResponsive.h(context, 20).clamp(16.0, 24.0);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F4),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _InboxTopBar(
              onComposeTap: () => _handleComposeTap(context),
            ),
            SizedBox(height: betweenHeaderAndMessages),
            _MessagesHeader(
              onSeeAllTap: () => _handleSeeAllTap(context),
            ),
            SizedBox(height: betweenMessagesAndInvite),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontal),
              child: _InviteFriendsTile(
                onTap: () => _handleInviteFriendsTap(context),
              ),
            ),
            SizedBox(height: betweenInviteAndUpdates),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontal),
              child: Text(
                'Updates',
                style: TextStyle(
                  fontSize: AppResponsive.sp(context, 22).clamp(18.0, 24.0),
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  letterSpacing: 0,
                ),
              ),
            ),
            const Expanded(
              child: _NoUpdatesSection(),
            ),
          ],
        ),
      ),
    );
  }
}

class _InboxTopBar extends StatelessWidget {
  final VoidCallback onComposeTap;

  const _InboxTopBar({
    required this.onComposeTap,
  });

  @override
  Widget build(BuildContext context) {
    final double horizontal =
    AppResponsive.w(context, 14).clamp(12.0, 18.0);
    final double top =
    AppResponsive.h(context, 12).clamp(10.0, 16.0);
    final double titleSize =
    AppResponsive.sp(context, 30).clamp(24.0, 32.0);
    final double actionSize =
    AppResponsive.r(context, 30).clamp(26.0, 32.0);
    final double tapRadius =
    AppResponsive.r(context, 18).clamp(14.0, 20.0);

    return Padding(
      padding: EdgeInsets.fromLTRB(horizontal, top, horizontal, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              'Inbox',
              style: TextStyle(
                fontSize: titleSize,
                fontWeight: FontWeight.w600,
                color: Colors.black,
                letterSpacing: 0,
              ),
            ),
          ),
          InkWell(
            onTap: onComposeTap,
            borderRadius: BorderRadius.circular(tapRadius),
            child: SizedBox(
              width: actionSize,
              height: actionSize,
              child: Icon(
                Icons.edit_note_outlined,
                size: actionSize,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MessagesHeader extends StatelessWidget {
  final VoidCallback onSeeAllTap;

  const _MessagesHeader({
    required this.onSeeAllTap,
  });

  @override
  Widget build(BuildContext context) {
    final double horizontal =
    AppResponsive.w(context, 14).clamp(12.0, 18.0);
    final double titleSize =
    AppResponsive.sp(context, 22).clamp(18.0, 24.0);
    final double seeAllSize =
    AppResponsive.sp(context, 16).clamp(14.0, 17.0);
    final double arrowSize =
    AppResponsive.r(context, 30).clamp(24.0, 32.0);
    final double tapRadius =
    AppResponsive.r(context, 16).clamp(12.0, 18.0);
    final double verticalPadding =
    AppResponsive.h(context, 3).clamp(2.0, 5.0);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Messages',
              style: TextStyle(
                fontSize: titleSize,
                fontWeight: FontWeight.w500,
                color: Colors.black,
                letterSpacing: 0,
              ),
            ),
          ),
          InkWell(
            onTap: onSeeAllTap,
            borderRadius: BorderRadius.circular(tapRadius),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: verticalPadding),
              child: Row(
                children: [
                  Text(
                    'See all',
                    style: TextStyle(
                      fontSize: seeAllSize,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      letterSpacing: 0,
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    size: arrowSize,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InviteFriendsTile extends StatelessWidget {
  final VoidCallback onTap;

  const _InviteFriendsTile({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double iconBoxSize =
    AppResponsive.r(context, 60).clamp(54.0, 64.0);
    final double iconBoxRadius =
    AppResponsive.r(context, 20).clamp(16.0, 22.0);
    final double personIconSize =
    AppResponsive.r(context, 20).clamp(18.0, 22.0);
    final double spacing =
    AppResponsive.w(context, 16).clamp(12.0, 18.0);
    final double titleSize =
    AppResponsive.sp(context, 16).clamp(14.0, 17.0);
    final double subtitleSize =
    AppResponsive.sp(context, 16).clamp(14.0, 17.0);
    final double tileRadius =
    AppResponsive.r(context, 24).clamp(20.0, 26.0);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(tileRadius),
      child: Row(
        children: [
          Container(
            width: iconBoxSize,
            height: iconBoxSize,
            decoration: BoxDecoration(
              color: const Color(0xFFE8E8E2),
              borderRadius: BorderRadius.circular(iconBoxRadius),
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.person_add_alt_1_outlined,
              size: personIconSize,
              color: Colors.black,
            ),
          ),
          SizedBox(width: spacing),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Invite your friends',
                  style: TextStyle(
                    fontSize: titleSize,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    letterSpacing: 0,
                  ),
                ),
                Text(
                  'Connect to start chatting',
                  style: TextStyle(
                    fontSize: subtitleSize,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF6F6F69),
                    letterSpacing: 0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NoUpdatesSection extends StatelessWidget {
  const _NoUpdatesSection();

  @override
  Widget build(BuildContext context) {
    final double horizontal =
    AppResponsive.w(context, 28).clamp(22.0, 32.0);
    final double iconBoxSize =
    AppResponsive.r(context, 70).clamp(60.0, 76.0);
    final double iconBoxRadius =
    AppResponsive.r(context, 28).clamp(22.0, 30.0);
    final double iconSize =
    AppResponsive.r(context, 40).clamp(34.0, 44.0);
    final double titleGap =
    AppResponsive.h(context, 10).clamp(8.0, 12.0);
    final double subtitleGap =
    AppResponsive.h(context, 8).clamp(6.0, 10.0);
    final double titleSize =
    AppResponsive.sp(context, 22).clamp(18.0, 24.0);
    final double subtitleSize =
    AppResponsive.sp(context, 16).clamp(14.0, 17.0);

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontal),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: iconBoxSize,
              height: iconBoxSize,
              decoration: BoxDecoration(
                color: const Color(0xFFE8E8E2),
                borderRadius: BorderRadius.circular(iconBoxRadius),
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.notifications_none_rounded,
                size: iconSize,
                color: Colors.black,
              ),
            ),
            SizedBox(height: titleGap),
            Text(
              'No updates',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: titleSize,
                fontWeight: FontWeight.w700,
                color: Colors.black,
                letterSpacing: 0,
              ),
            ),
            SizedBox(height: subtitleGap),
            Text(
              'You’ll see your latest Pinterest updates here.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: subtitleSize,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF6F6F69),
                letterSpacing: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}