import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:onestop_ui/index.dart';
import 'package:provider/provider.dart';

import '../../functions/formatters.dart';
import '../../models/post_model.dart';
import '../../services/api.dart';
import '../../services/user_store.dart';
import '../../stores/login_store.dart';
import '../ui/corner_case.dart';
import '../ui/post_shimer.dart';
import '../../screens/post_detail_page.dart';

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
          text: 'My Posts',
          style: OTextStyle.headingMedium.copyWith(color: OColor.gray800),
        ),
        backgroundColor: OColor.white,
        elevation: 0,
      ),
      backgroundColor: OColor.white,
      body: FutureBuilder(
        future: APIService().getMyPosts(LoginStore.userData),
        builder: (
          BuildContext context,
          AsyncSnapshot<List<PostModel>> snapshot,
        ) {
          if (snapshot.hasError) {
            return const CornerCase(message: 'Error loading posts');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingScreen();
          }
          if (snapshot.data == null || snapshot.data!.isEmpty) {
            return const CornerCase(message: 'No posts yet');
          }

          return ListView.builder(
            padding: const EdgeInsets.all(OSpacing.s),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final post = snapshot.data![index];
              return MyPostCard(
                post: post,
                commonStore: commonStore,
                onDeleted: () {
                  widget.onPostDeleted();
                  setState(() {});
                },
              );
            },
          );
        },
      ),
    );
  }
}

/// Card widget for displaying user's own post
class MyPostCard extends StatelessWidget {
  final PostModel post;
  final CommonStore commonStore;
  final VoidCallback onDeleted;

  const MyPostCard({
    super.key,
    required this.post,
    required this.commonStore,
    required this.onDeleted,
  });

  void _navigateToDetail(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => Provider.value(
              value: commonStore,
              child: PostDetailPage(post: post),
            ),
      ),
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
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: OSpacing.m,
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
        buttonLabel1: 'View',
        pressedButton1: () => _navigateToDetail(context),
        buttonIcon2: TablerIcons.trash,
        buttonLabel2: 'Delete',
        pressedButton2: () => _deletePost(context),
      ),
    );
  }
}
