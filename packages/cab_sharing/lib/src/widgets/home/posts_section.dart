import 'package:flutter/material.dart';

import '../../functions/filter_helpers.dart';
import '../../models/post_model.dart';
import '../../services/api.dart';
import '../../services/user_store.dart';
import '../../stores/login_store.dart';
import '../ui/corner_case.dart';
import '../ui/post_shimer.dart';
import '../../screens/error_screen.dart';
import 'cab_card.dart';

/// Main posts section with FutureBuilder and filter support
class PostsSection extends StatelessWidget {
  final CabFilter selectedFilter;
  final DateTime? selectedDate;
  final CommonStore commonStore;
  final VoidCallback onRefresh;
  final void Function(PostModel post) onPostTap;

  const PostsSection({
    super.key,
    required this.selectedFilter,
    required this.selectedDate,
    required this.commonStore,
    required this.onRefresh,
    required this.onPostTap,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => onRefresh(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 100), // Space for FAB
        child: FutureBuilder(
          future: APIService().getAllPosts(LoginStore.userData),
          builder: (
            BuildContext context,
            AsyncSnapshot<List<Map<String, List<PostModel>>>> snapshot,
          ) {
            if (snapshot.hasError) {
              return ErrorScreen(reloadCallback: onRefresh);
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingScreen();
            }
            if (snapshot.data == null) {
              return const CornerCase(
                message: 'Some error occurred, please try again',
              );
            }

            final filteredPosts = filterPosts(
              snapshot.data!,
              selectedFilter,
              selectedDate,
            );

            if (filteredPosts.isEmpty) {
              return const CornerCase(message: 'No Posts Available');
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var dateGroup in filteredPosts) ...[
                  DateHeader(date: dateGroup.keys.first),
                  for (var post in dateGroup.values.first)
                    CabCard(
                      post: post,
                      userName: post.name,
                      userEmail: post.email,
                      onTap: () => onPostTap(post),
                      onJoinPressed: () => onPostTap(post),
                    ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}
