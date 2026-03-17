import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:onestop_ui/index.dart';
import 'package:provider/provider.dart';

import '../../functions/formatters.dart';
import '../../models/post_model.dart';
import '../../services/api.dart';
import '../../services/user_store.dart';
import '../ui/corner_case.dart';
import '../ui/post_shimer.dart';
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
  int _refreshKey = 0;

  void _refresh() {
    setState(() => _refreshKey++);
  }

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
  
      ),
      backgroundColor: OColor.white,
      body: FutureBuilder<List<PostModel>>(
        key: ValueKey(_refreshKey),
        future: APIService().getMyPosts({'email': commonStore.userEmail}),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingScreen();
          }
          if (snapshot.hasError || snapshot.data == null) {
            return const CornerCase(message: 'Failed to load posts');
          }

          final allPosts = snapshot.data!;

          if (allPosts.isEmpty) {
            return const CornerCase(message: 'No Posts Available');
          }

          final now = DateTime.now();
          final upcomingPosts =
              allPosts
                  .where((p) => !DateTime.parse(p.travelDateTime).isBefore(now))
                  .toList()
                ..sort((a, b) => a.travelDateTime.compareTo(b.travelDateTime));

          final pastPosts =
              allPosts
                  .where((p) => DateTime.parse(p.travelDateTime).isBefore(now))
                  .toList()
                ..sort((a, b) => b.travelDateTime.compareTo(a.travelDateTime));

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (upcomingPosts.isNotEmpty) ...[
                  _SectionHeader(title: 'Current Post'),
                  const SizedBox(height: OSpacing.xs),
                  ...upcomingPosts.map(
                    (post) => CurrentPostCard(
                      post: post,
                      commonStore: commonStore,
                      onDeleted: () {
                        widget.onPostDeleted();
                        _refresh();
                      },
                      onUpdated: _refresh,
                    ),
                  ),
                ],
                if (pastPosts.isNotEmpty) ...[
                  const SizedBox(height: OSpacing.m),
                  _SectionHeader(title: 'Past Posts'),
                  const SizedBox(height: OSpacing.xs),
                  ...pastPosts.map(
                    (post) => PastPostCard(
                      post: post,
                      commonStore: commonStore,
                      onDeleted: () {
                        widget.onPostDeleted();
                        _refresh();
                      },
                    ),
                  ),
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
  final VoidCallback onUpdated;

  const CurrentPostCard({
    super.key,
    required this.post,
    required this.commonStore,
    required this.onDeleted,
    required this.onUpdated,
  });

  void _navigateToDetail(BuildContext context) {
    showCurrentPostPopup(
      context,
      post,
      onUpdate: onUpdated,
      onDeleted: onDeleted,
    );
  }

  

  Future<void> _deletePost(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
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
    final int pendingBookings = post.bookings.where((b) => b.isPending).length;

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
        status: '$pendingBookings Req',
        statusIcon: TablerIcons.car,
        subHeading: formatNote(post.note),
        onArrowPressed: () => _navigateToDetail(context),
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
  final VoidCallback onDeleted;

  const PastPostCard({
    super.key,
    required this.post,
    required this.commonStore,
    required this.onDeleted,
  });

  void _navigateToDetail(BuildContext context) {
    showPastPostPopup(context, post, onDeleted: onDeleted);
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
                _IconBadge(icon: TablerIcons.school, color: OColor.gray200),
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
                        icon:
                            byTrain
                                ? TablerIcons.train
                                : TablerIcons.plane_tilt,
                        color: OColor.gray200,
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
                Icon(
                  TablerIcons.chevron_right,
                  color: OColor.gray500,
                  size: 20,
                ),
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
                        TablerIcons.chair_director,
                        size: 14,
                        color: Color(0xFF047857),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${post.totalSeats - post.availableSeats} co-riders',
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
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Icon(icon, color: Colors.white, size: 12),
    );
  }
}
