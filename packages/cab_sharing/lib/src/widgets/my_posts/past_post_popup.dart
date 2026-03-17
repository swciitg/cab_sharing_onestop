import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:onestop_ui/index.dart';

import '../../functions/formatters.dart';
import '../../models/booking_model.dart';
import '../../models/post_model.dart';
import '../../services/api.dart';
import '../../services/launcher.dart';

/// Shows the Past Post Popup as a bottom sheet
void showPastPostPopup(
  BuildContext context,
  PostModel post, {
  VoidCallback? onDeleted,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder:
        (context) => PastPostBottomSheet(post: post, onDeleted: onDeleted),
  );
}

/// Past Post Bottom Sheet showing historical cab sharing post details
/// with cab co-riders list and delete history option
class PastPostBottomSheet extends StatefulWidget {
  final PostModel post;
  final VoidCallback? onDeleted;

  const PastPostBottomSheet({super.key, required this.post, this.onDeleted});

  @override
  State<PastPostBottomSheet> createState() => _PastPostBottomSheetState();
}

class _PastPostBottomSheetState extends State<PastPostBottomSheet> {
  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (dialogContext) => AlertDialog(
            title: const Text('Delete Post History'),
            content: const Text(
              'Are you sure you want to delete this post from history?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  Map<String, String> data = {
                    "postId": widget.post.id,
                    "email": widget.post.email,
                  };
                  Navigator.pop(dialogContext); // pop dialog
                  bool success = await APIService().deletePost(data);
                  if (success && mounted) {
                    widget.onDeleted?.call();
                    Navigator.pop(context); // pop bottom sheet
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Post deleted successfully'),
                      ),
                    );
                  } else if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Failed to delete post')),
                    );
                  }
                },
                child: Text('Delete', style: TextStyle(color: OColor.red600)),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final int totalSeats = widget.post.totalSeats;
    final int filledSeats = widget.post.totalSeats - widget.post.availableSeats;
    final coRiders = widget.post.bookings.where((b) => b.isApproved).toList();

    return Container(
      decoration: BoxDecoration(
        color: OColor.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: DraggableScrollableSheet(
        initialChildSize: 0.75,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) {
          return Column(
            children: [
              // Drag Handle
              Container(
                margin: const EdgeInsets.only(top: OSpacing.s),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: OColor.gray300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Header with title and close button
              _PastPostHeader(onClose: () => Navigator.pop(context)),

              Divider(height: 1, color: OColor.gray200),

              // Scrollable Content
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(OSpacing.m),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Route Row
                        _RouteRow(post: widget.post),
                        const SizedBox(height: OSpacing.s),

                        // Time and Date Row
                        _TimeAndDateRow(post: widget.post),
                        const SizedBox(height: OSpacing.l),

                        // Seats Progress Section
                        _SeatsProgressSection(
                          filledSeats: filledSeats,
                          totalSeats: totalSeats,
                        ),
                        const SizedBox(height: OSpacing.l),

                        // Cab Co-riders Section
                        _CabCoRidersSection(coRiders: coRiders),

                        const SizedBox(height: OSpacing.m),
                      ],
                    ),
                  ),
                ),
              ),

              Divider(height: 1, color: OColor.gray200),

              // Delete Post History Button
              SafeArea(
                child: _DeleteHistoryButton(
                  onPressed: () => _showDeleteConfirmation(context),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

/// Header with "Past Post" title and close button
class _PastPostHeader extends StatelessWidget {
  final VoidCallback onClose;

  const _PastPostHeader({required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(OSpacing.m),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(TablerIcons.car, color: OColor.green600, size: 24),
              const SizedBox(width: OSpacing.s),
              Text(
                'Past Post',
                style: OTextStyle.headingSmall.copyWith(
                  color: OColor.gray800,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: onClose,
            child: Icon(TablerIcons.x, color: OColor.gray500, size: 24),
          ),
        ],
      ),
    );
  }
}

/// Route row showing origin -> destination
class _RouteRow extends StatelessWidget {
  final PostModel post;

  const _RouteRow({required this.post});

  @override
  Widget build(BuildContext context) {
    final bool byTrain = isTravelByTrain(post.to);
    final String origin = formatLocationShort(post.from);
    final String destination = formatLocationShort(post.to);

    return Row(
      children: [
        _IconBadge(icon: TablerIcons.school, color: const Color(0xFF4D51EF)),
        const SizedBox(width: OSpacing.xs),
        Text(
          origin,
          style: OTextStyle.labelLarge.copyWith(
            color: OColor.gray800,
            fontWeight: FontWeight.w600,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: OSpacing.xs),
          child: Icon(
            TablerIcons.arrow_narrow_right,
            size: 18,
            color: OColor.gray400,
          ),
        ),
        _IconBadge(
          icon: byTrain ? TablerIcons.train : TablerIcons.plane_tilt,
          color: byTrain ? const Color(0xFF14B8A6) : const Color(0xFF0D99D8),
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
    );
  }
}

/// Time and date row
class _TimeAndDateRow extends StatelessWidget {
  final PostModel post;

  const _TimeAndDateRow({required this.post});

  @override
  Widget build(BuildContext context) {
    final String time = post.getTime();
    final String date = formatDate(post.getDate());

    return Row(
      children: [
        Icon(TablerIcons.clock, size: 16, color: OColor.gray500),
        const SizedBox(width: 4),
        Text(
          time,
          style: OTextStyle.labelMedium.copyWith(color: OColor.gray600),
        ),
        const SizedBox(width: OSpacing.m),
        Icon(TablerIcons.calendar, size: 16, color: OColor.gray500),
        const SizedBox(width: 4),
        Text(
          date,
          style: OTextStyle.labelMedium.copyWith(color: OColor.gray600),
        ),
      ],
    );
  }
}

/// Seats progress section with visual indicator
class _SeatsProgressSection extends StatelessWidget {
  final int filledSeats;
  final int totalSeats;

  const _SeatsProgressSection({
    required this.filledSeats,
    required this.totalSeats,
  });

  @override
  Widget build(BuildContext context) {
    if (totalSeats == 0) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$filledSeats / $totalSeats Seats',
          style: OTextStyle.headingSmall.copyWith(
            color: OColor.gray800,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: OSpacing.s),
        Row(
          children: List.generate(totalSeats, (index) {
            final bool isFilled = index < filledSeats;
            return Expanded(
              child: Container(
                height: 6,
                margin: EdgeInsets.only(
                  right: index < totalSeats - 1 ? OSpacing.xs : 0,
                ),
                decoration: BoxDecoration(
                  color: isFilled ? OColor.green600 : OColor.gray300,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}

/// Cab Co-riders section with contact list
class _CabCoRidersSection extends StatelessWidget {
  final List<BookingModel> coRiders;

  const _CabCoRidersSection({required this.coRiders});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cab Co-riders',
          style: OTextStyle.labelLarge.copyWith(
            color: OColor.gray800,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: OSpacing.s),
        if (coRiders.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: OSpacing.xs),
            child: Text(
              'No co-riders yet',
              style: OTextStyle.bodySmall.copyWith(color: OColor.gray500),
            ),
          )
        else
          ...coRiders.map((rider) => _CoRiderTile(rider: rider)),
      ],
    );
  }
}

/// Individual co-rider tile with avatar and contact actions
class _CoRiderTile extends StatelessWidget {
  final BookingModel rider;

  const _CoRiderTile({required this.rider});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: OSpacing.xs),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 24,
            backgroundColor: OColor.gray200,
            backgroundImage: NetworkImage(
              'https://ui-avatars.com/api/?name=${Uri.encodeComponent(rider.name)}&background=random&size=96',
            ),
          ),
          const SizedBox(width: OSpacing.s),

          // Name and Email
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  rider.name,
                  style: OTextStyle.labelLarge.copyWith(
                    color: OColor.gray800,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  rider.email,
                  style: OTextStyle.labelSmall.copyWith(color: OColor.gray500),
                ),
              ],
            ),
          ),

          // Contact Actions
          if (rider.phoneNumber != null)
            _ContactActionButton(
              icon: TablerIcons.phone,
              onPressed: () => launchPhoneURL(rider.phoneNumber!),
            ),
        ],
      ),
    );
  }
}

/// Circular contact action button
class _ContactActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _ContactActionButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(OSpacing.xs),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: OColor.green600, width: 1.5),
        ),
        child: Icon(icon, size: 20, color: OColor.green600),
      ),
    );
  }
}

/// Delete post history button
class _DeleteHistoryButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _DeleteHistoryButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(OSpacing.m),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(TablerIcons.trash, size: 18, color: OColor.red600),
            const SizedBox(width: OSpacing.xs),
            Text(
              'Delete Post History',
              style: OTextStyle.labelLarge.copyWith(
                color: OColor.red600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Icon badge for route display
class _IconBadge extends StatelessWidget {
  final IconData icon;
  final Color color;

  const _IconBadge({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Icon(icon, color: Colors.white, size: 14),
    );
  }
}
