import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:onestop_ui/index.dart';

import '../../models/post_model.dart';
import '../../services/launcher.dart';
import '../ui/custom_modal.dart';
import '../ui/route_info_section.dart';
import '../ui/seats_progress_section.dart';
import '../ui/contact_action_buttons.dart';

/// Modal to display post details when user taps "Join" on a cab card
class PostDetailModal extends StatelessWidget {
  final PostModel post;
  final String userEmail;
  final VoidCallback? onJoin;

  const PostDetailModal({
    super.key,
    required this.post,
    required this.userEmail,
    this.onJoin,
  });

  /// Shows the post detail modal
  static Future<void> show(
    BuildContext context, {
    required PostModel post,
    required String userEmail,
    VoidCallback? onJoin,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) =>
              PostDetailModal(post: post, userEmail: userEmail, onJoin: onJoin),
    );
  }

  @override
  Widget build(BuildContext context) {
    final int totalSeats = post.totalSeats;
    final int joinedCount = post.totalSeats - post.availableSeats;
    final bool isOwnPost = userEmail == post.email;

    final phoneNumber = post.phonenumber ?? '';

    return CustomModal(
      headerIcon: TablerIcons.car,
      heading: 'Current Post',
      headerButtonPressed: () => Navigator.pop(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Route info section
          RouteInfoSection(post: post),
          const SizedBox(height: OSpacing.m),

          // Seats progress section
          SeatsProgressSection(
            joinedCount: joinedCount,
            totalSeats: totalSeats,
          ),
          const SizedBox(height: OSpacing.m),
          // Requested by section
          _RequesterSection(post: post),
          const SizedBox(height: OSpacing.m),

          // Note section
          _NoteSection(note: post.note),
          const SizedBox(height: OSpacing.m),

          // Action buttons (Call, Text, Mail)
          ContactActionButtons(
            phoneNumber: phoneNumber,
            email: post.email,
            onCall: () => launchPhoneURL(phoneNumber),
            onText: () => launchSmsURL(phoneNumber),
            onMail: () => launchEmailURL(post.email),
          ),
        ],
      ),
      buttonLabel: isOwnPost ? 'Edit' : 'Join',
      buttonPressed:
          isOwnPost
              ? () {
                //TODO: Implement edit post functionality
              }
              : () {
                Navigator.pop(context);
                onJoin?.call();
              },
    );
  }
}

/// Requester info section
class _RequesterSection extends StatelessWidget {
  final PostModel post;

  const _RequesterSection({required this.post});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Requested by',
          style: OTextStyle.bodySmall.copyWith(color: OColor.gray500),
        ),
        const SizedBox(height: OSpacing.xs),
        Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: OColor.green100,
              backgroundImage: NetworkImage(
                'https://ui-avatars.com/api/?name=${Uri.encodeComponent(post.name)}&background=random',
              ),
            ),
            const SizedBox(width: OSpacing.s),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.name,
                    style: OTextStyle.bodyMedium.copyWith(
                      color: OColor.gray800,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    post.email,
                    style: OTextStyle.bodySmall.copyWith(color: OColor.gray500),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Note section
class _NoteSection extends StatelessWidget {
  final String note;

  const _NoteSection({required this.note});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Note',
          style: OTextStyle.bodySmall.copyWith(color: OColor.gray500),
        ),
        const SizedBox(height: OSpacing.xxs),
        Text(
          note.isNotEmpty ? note : 'No additional notes',
          style: OTextStyle.bodyMedium.copyWith(color: OColor.gray700),
        ),
      ],
    );
  }
}
