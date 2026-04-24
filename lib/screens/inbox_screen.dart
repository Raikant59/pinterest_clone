import 'package:flutter/material.dart';

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
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F4),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _InboxTopBar(
              onComposeTap: () => _handleComposeTap(context),
            ),


            _MessagesHeader(
              onSeeAllTap: () => _handleSeeAllTap(context),
            ),
            const SizedBox(height: 7),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: _InviteFriendsTile(
                onTap: () => _handleInviteFriendsTap(context),
              ),
            ),

            SizedBox(height: 20),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Text(
                'Updates',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  letterSpacing: 0,
                ),
              ),
            ),
            Expanded(
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Expanded(
            child: Text(
              'Inbox',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
                color: Colors.black,
                letterSpacing: 0,
              ),
            ),
          ),
          InkWell(
            onTap: onComposeTap,
            borderRadius: BorderRadius.circular(18),
            child: const SizedBox(
              width: 30,
              height: 30,
              child: Icon(
                Icons.edit_note_outlined,
                size: 30,
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              'Messages',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: Colors.black,
                letterSpacing: 0,
              ),
            ),
          ),
          InkWell(
            onTap: onSeeAllTap,
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.symmetric( vertical: 3),
              child: Row(
                children: const [
                  Text(
                    'See all',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      letterSpacing: 0,
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    size: 30,
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
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xFFE8E8E2),
              borderRadius: BorderRadius.circular(20),
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.person_add_alt_1_outlined,
              size: 20,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Invite your friends',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    letterSpacing: 0,
                  ),
                ),
                Text(
                  'Connect to start chatting',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF6F6F69),
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
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: const Color(0xFFE8E8E2),
                borderRadius: BorderRadius.circular(28),
              ),
              alignment: Alignment.center,
              child: const Icon(
                Icons.notifications_none_rounded,
                size: 40,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            const Text(
              'No updates',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.black,
                letterSpacing: 0,
              ),
            ),
            SizedBox(height: 8),
            const Text(
              'You’ll see your latest Pinterest updates here.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xFF6F6F69),
                letterSpacing: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}