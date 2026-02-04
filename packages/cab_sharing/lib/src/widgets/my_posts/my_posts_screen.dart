import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:onestop_ui/index.dart';
import 'package:provider/provider.dart';

import '../../functions/formatters.dart';
import '../../models/post_model.dart';
import '../../services/api.dart';
import '../../services/user_store.dart';

//import 'post_detail_page.dart';
import 'current_post_popup.dart';
import 'past_post_popup.dart';

/// Screen to display user's own posts
class MyPostsScreen extends StatefulWidget {
  final VoidCallback onPostDeleted;

  const MyPostsScreen({super.key, required this.onPostDeleted});

  @override
  State<MyPostsScreen> createState() => _MyPostsScreenState();
}

class _MyPostsScreenState extends State<MyPostsScreen> {
  @override
  Widget build(BuildContext context) {
    var commonStore = context.read<CommonStore>();

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(TablerIcons.arrow_left, color: OColor.green600),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: OText(
          text: 'My Cab Sharing Posts',
          style: OTextStyle.headingMedium.copyWith(color: OColor.gray800),
        ),
        backgroundColor: OColor.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.info , color: OColor.green600),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      backgroundColor: OColor.white,
      body: Builder(
        builder: (context) {
          // API IMPLEMENTATION (Commented out for now)
          /*
          return FutureBuilder(
            future: APIService().getMyPosts(LoginStore.userData),
            builder: (context, snapshot) { ... }
          );
          */

          // HARDCODED MOCK DATA FOR TESTING
          final allPosts = [
            PostModel(
              id: '1',
              name: 'Test User',
              email: 'test@iitg.ac.in',
              travelDateTime: '2026-01-31T08:00:00',
              from: 'IIT Guwahati',
              to: 'Kamakhya Station',
              note: 'Flight at 8:00 AM, but I am a bit flexible with the timings.',
              margin: 2,
              chatId: 'chat1',
              phonenumber: '1234567890',
            ),
            PostModel(
              id: '2',
              name: 'Test User',
              email: 'test@iitg.ac.in',
              travelDateTime: '2026-01-31T09:00:00',
              from: 'IIT Guwahati',
              to: 'Kamakhya Station',
              note: 'Flight at 8:00 AM, but I am a bit flexible with the timings.',
              margin: 1,
              chatId: 'chat2',
              phonenumber: '1234567890',
            ),
            PostModel(
              id: '3',
              name: 'Test User',
              email: 'test@iitg.ac.in',
              travelDateTime: '2026-01-31T09:00:00',
              from: 'IIT Guwahati',
              to: 'Kamakhya Station',
              note: 'Flight at 8:00 AM, but I am a bit flexible with the timings.',
              margin: 0,
              chatId: 'chat3',
              phonenumber: '1234567890',
            ),
            PostModel(
              id: '4',
              name: 'Test User',
              email: 'test@iitg.ac.in',
              travelDateTime: '2026-01-31T09:00:00',
              from: 'IIT Guwahati',
              to: 'Kamakhya Station',
              note: 'Flight at 8:00 AM, but I am a bit flexible with the timings.',
              margin: 2,
              chatId: 'chat4',
              phonenumber: '1234567890',
            ),
            PostModel(
              id: '5',
              name: 'Test User',
              email: 'test@iitg.ac.in',
              travelDateTime: '2026-01-31T09:00:00',
              from: 'IIT Guwahati',
              to: 'Kamakhya Station',
              note: 'Flight at 8:00 AM, but I am a bit flexible with the timings.',
              margin: 1,
              chatId: 'chat5',
              phonenumber: '1234567890',
            ),
            PostModel(
              id: '6',
              name: 'Test User',
              email: 'test@iitg.ac.in',
              travelDateTime: '2026-01-31T09:00:00',
              from: 'IIT Guwahati',
              to: 'Kamakhya Station',
              note: 'Flight at 8:00 AM, but I am a bit flexible with the timings.',
              margin: 0,
              chatId: 'chat6',
              phonenumber: '1234567890',
            ),
          ];

          final currentPost = allPosts.isNotEmpty ? allPosts.first : null;
          final pastPosts = allPosts.length > 1 ? allPosts.sublist(1) : <PostModel>[];

          return SingleChildScrollView(
           // padding: const EdgeInsets.all(OSpacing.s),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Current Post Section
                if (currentPost != null) ...[
                  _SectionHeader(title: 'Current Post'),
                  const SizedBox(height: OSpacing.xs),
                  CurrentPostCard(
                    post: currentPost,
                    commonStore: commonStore,
                    onDeleted: () {
                      widget.onPostDeleted();
                      setState(() {});
                    },
                  ),
                ],
                
                // Past Posts Section
                if (pastPosts.isNotEmpty) ...[
                  const SizedBox(height: OSpacing.m),
                  _SectionHeader(title: 'Past Posts'),
                  const SizedBox(height: OSpacing.xs),
                  ...pastPosts.map((post) => PastPostCard(
                    post: post,
                    commonStore: commonStore,
                  )),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

/// Section header widget
class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: OSpacing.s),
      child: OText(
        text: title,
        style: OTextStyle.headingSmall.copyWith(
          color: OColor.gray800,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

/// Card widget for displaying current (active) post with Edit/Delete buttons
class CurrentPostCard extends StatelessWidget {                                               
  final PostModel post;
  final CommonStore commonStore;
  final VoidCallback onDeleted;

  const CurrentPostCard({
    super.key,
    required this.post,
    required this.commonStore,
    required this.onDeleted,
  });

  void _navigateToDetail(BuildContext context) {
    showCurrentPostPopup(context, post);
  }

  void _editPost(BuildContext context) {
    // Navigate to edit screen
    _navigateToDetail(context);
  }

  Future<void> _deletePost(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Post'),
        content: const Text('Are you sure you want to delete this post?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      Map<String, String> data = {
        'postId': post.id,
        'email': commonStore.userEmail,
        'security-key': commonStore.securityKey,
      };

      bool success = await APIService().deletePost(data);
      if (success) {
        onDeleted();
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Post deleted successfully')),
          );
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to delete post')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: OSpacing.xs,
        vertical: OSpacing.xxs,
      ),
      child: OCabSharingCard(
        isEnabled: true,
        isUserAvailable: false,
        byTrain: isTravelByTrain(post.to),
        origin: formatLocationShort(post.from),
        destination: formatLocationShort(post.to),
        time: post.getTime(),
        date: formatDate(post.getDate()),
        status: formatStatus(post.getMargin()),
        statusIcon: TablerIcons.clock,
        subHeading: formatNote(post.note),
        onArrowPressed: () => _navigateToDetail(context),
        buttonIcon1: TablerIcons.edit,
        buttonLabel1: 'Edit',
        pressedButton1: () => _editPost(context),
        buttonIcon2: TablerIcons.trash,
        buttonLabel2: 'Delete',
        pressedButton2: () => _deletePost(context),
      ),
    );
  }
}

/// Card widget for displaying past posts (no Edit/Delete buttons)
class PastPostCard extends StatelessWidget {
  final PostModel post;
  final CommonStore commonStore;

  const PastPostCard({
    super.key,
    required this.post,
    required this.commonStore,
  });

  void _navigateToDetail(BuildContext context) {
    showPastPostPopup(context, post);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: OSpacing.xs,
        vertical: OSpacing.xxs,
      ),
      child: CompactCabSharingCard(
        post: post,
        onTap: () => _navigateToDetail(context),
      ),
    );
  }
}

/// A compact version of OCabSharingCard without the bottom buttons gap
class CompactCabSharingCard extends StatelessWidget {
  final PostModel post;
  final VoidCallback onTap;

  const CompactCabSharingCard({
    super.key,
    required this.post,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool byTrain = isTravelByTrain(post.to);
    final String origin = formatLocationShort(post.from);
    final String destination = formatLocationShort(post.to);
    final String time = post.getTime();
    final String date = formatDate(post.getDate());
    final String status = formatStatus(post.getMargin());
    final String note = formatNote(post.note);

    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: OColor.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: OColor.gray200),
        ),
        padding: const EdgeInsets.all(OSpacing.m),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row: Origin -> Destination
            Row(
              children: [
                _IconBadge(
                  icon: TablerIcons.school,
                  color: const Color(0xFF4D51EF),
                ),
                const SizedBox(width: OSpacing.xs),
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        origin,
                        style: OTextStyle.labelLarge.copyWith(
                          color: OColor.gray800,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: OSpacing.xs),
                        child: Icon(
                          TablerIcons.arrow_narrow_right,
                          size: 20,
                          color: OColor.gray500,
                        ),
                      ),
                      _IconBadge(
                        icon: byTrain ? TablerIcons.train : TablerIcons.plane_tilt,
                        color: byTrain
                            ? const Color(0xFF14B8A6)
                            : const Color(0xFF0D99D8),
                      ),
                      const SizedBox(width: OSpacing.xs),
                      Flexible(
                        child: Text(
                          destination,
                          style: OTextStyle.labelLarge.copyWith(
                            color: OColor.gray800,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(TablerIcons.chevron_right, color: OColor.gray500, size: 20),
              ],
            ),
            const SizedBox(height: OSpacing.s),
            
            // Info Row: Status, Time, Date
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: OSpacing.xs,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD1FAE5), // Light green
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        TablerIcons.clock,
                        size: 14,
                        color: Color(0xFF047857),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        status,
                        style: OTextStyle.labelSmall.copyWith(
                          color: const Color(0xFF047857),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: OSpacing.s),
                Row(
                  children: [
                    Icon(TablerIcons.clock, size: 14, color: OColor.gray500),
                    const SizedBox(width: 4),
                    Text(
                      time,
                      style: OTextStyle.labelSmall.copyWith(
                        color: OColor.gray600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: OSpacing.s),
                Row(
                  children: [
                    Icon(TablerIcons.calendar, size: 14, color: OColor.gray500),
                    const SizedBox(width: 4),
                    Text(
                      date,
                      style: OTextStyle.labelSmall.copyWith(
                        color: OColor.gray600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            
            // Note Text
            if (note != 'No notes') ...[
              const SizedBox(height: OSpacing.s),
              Text(
                note,
                style: OTextStyle.bodySmall.copyWith(color: OColor.gray600),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _IconBadge extends StatelessWidget {
  final IconData icon;
  final Color color;

  const _IconBadge({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.white, size: 12),
    );
  }
}
