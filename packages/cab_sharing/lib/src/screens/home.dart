import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:onestop_ui/index.dart';
import 'package:provider/provider.dart';
import '../functions/filter_helpers.dart';
import '../services/api.dart';
import '../models/post_model.dart';
import '../services/date.dart';
import '../services/user_store.dart';
import '../stores/login_store.dart';
import '../widgets/home/filter_section.dart';
import '../widgets/home/home_date_picker_modal.dart';
import '../widgets/home/bottom_actions.dart';
import '../widgets/home/posts_section.dart';
import '../widgets/home/post_detail_modal.dart';
import '../widgets/my_posts/my_posts_screen.dart';
import '../functions/snackbar.dart';
import 'add_post_page.dart';

final GlobalKey<ScaffoldMessengerState> cabSharingRootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class CabSharingScreen extends StatefulWidget {
  const CabSharingScreen({super.key});

  @override
  State<CabSharingScreen> createState() => _CabSharingScreenState();
}

class _CabSharingScreenState extends State<CabSharingScreen> {
  CabFilter _selectedFilter = CabFilter.all;
  DateTime? _selectedDate;

  void _showDatePicker() {
    HomeDatePickerModal.show(
      context,
      onDateSelected: (date) => setState(() => _selectedDate = date),
    );
  }

  void _showPostDetailModal(PostModel post, CommonStore commonStore) {
    final booking = post.getUserBooking(commonStore.userEmail);
    PostDetailModal.show(
      context,
      post: post,
      userEmail: commonStore.userEmail,
      onJoin: () async {
        final success = await APIService().createBooking(
          postId: post.id,
          name: commonStore.userName,
          email: commonStore.userEmail,
          phoneNumber: commonStore.userPhone,
        );
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          getSnackBar(
            success
                ? 'Join request sent!'
                : 'Failed to send request. Try again.',
            isError: !success,
          ),
        );
      },
      onCancelRequest:
          booking == null
              ? null
              : () async {
                final success = await APIService().cancelBooking(
                  postId: post.id,
                  bookingId: booking.id,
                );
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  getSnackBar(
                    success
                        ? 'Request cancelled.'
                        : 'Failed to cancel. Try again.',
                    isError: !success,
                  ),
                );
                if (success) setState(() {});
              },
      onDelete: () async {
        final success = await APIService().deletePost({
          'postId': post.id,
          'email': commonStore.userEmail,
          'security-key': commonStore.securityKey,
        });
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          getSnackBar(
            success ? 'Post deleted.' : 'Failed to delete. Try again.',
            isError: !success,
          ),
        );
        if (success) setState(() {});
      },
    );
  }

  void _navigateToAddPost(CommonStore commonStore) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => Provider.value(
              value: commonStore,
              child: ChangeNotifierProvider(
                create: (context) => DateController(),
                child: const AddPostPage(),
              ),
            ),
      ),
    );
  }

  void _navigateToMyPosts(CommonStore commonStore) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => Provider.value(
              value: commonStore,
              child: MyPostsScreen(onPostDeleted: () => setState(() {})),
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => CommonStore(userData: LoginStore.userData),
      builder: (context, _) {
        var commonStore = context.read<CommonStore>();
        return SafeArea(
          top: false,
          bottom: false,
          child: Scaffold(
            appBar: AppBar(
    
              scrolledUnderElevation: 0,
              backgroundColor: OColor.white,
              leading: IconButton(
                icon: Icon(
                  TablerIcons.arrow_left,
                  color: OColor.gray700,
                  size: 24,
                ),
                onPressed: () {
                  Navigator.popUntil(context, ModalRoute.withName("/home2"));
                },
              ),
              centerTitle: true,
              title: Text(
                'Cab Sharing',
                style: OTextStyle.headingMedium.copyWith(
                  color: OColor.gray800,
                  fontWeight: FontWeight.w600,
                ),
              ),
             
            ),
            backgroundColor: OColor.gray100,
            body: Column(
              children: [
                // Filter Section
                FilterSection(
                  selectedFilter: _selectedFilter,
                  selectedDate: _selectedDate,
                  onFilterChanged:
                      (filter) => setState(() => _selectedFilter = filter),
                  onDatePickerTap: _showDatePicker,
                  onClearDate: () => setState(() => _selectedDate = null),
                ),
                // Posts Section
                Expanded(
                  child: PostsSection(
                    selectedFilter: _selectedFilter,
                    selectedDate: _selectedDate,
                    commonStore: commonStore,
                    onRefresh: () => setState(() {}),
                    onPostTap:
                        (post) => _showPostDetailModal(post, commonStore),
                  ),
                ),
              ],
            ),
            // Bottom Action Buttons
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton:
                (!LoginStore.isGuest)
                    ? HomeBottomActions(
                      onMyPostsPressed: () => _navigateToMyPosts(commonStore),
                      onShareCabPressed: () => _navigateToAddPost(commonStore),
                    )
                    : null,
          ),
        );
      },
    );
  }
}
