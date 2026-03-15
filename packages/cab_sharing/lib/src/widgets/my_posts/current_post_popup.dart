import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:onestop_ui/index.dart';

import '../../functions/formatters.dart';
import '../../models/booking_model.dart';
import '../../models/post_model.dart';
import '../../services/api.dart';

/// Shows the Current Post Popup as a bottom sheet
void showCurrentPostPopup(BuildContext context, PostModel post) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => CurrentPostBottomSheet(post: post),
  );
}

/// Current Post Bottom Sheet showing cab sharing post details
/// with share list, requests, and action buttons
class CurrentPostBottomSheet extends StatefulWidget {
  final PostModel post;

  const CurrentPostBottomSheet({super.key, required this.post});

  @override
  State<CurrentPostBottomSheet> createState() => _CurrentPostBottomSheetState();
}

class _CurrentPostBottomSheetState extends State<CurrentPostBottomSheet> {
  late Future<List<BookingModel>> _bookingsFuture;

  @override
  void initState() {
    super.initState();
    _bookingsFuture = APIService().getPostBookings(widget.post.id);
  }

  void _refresh() {
    setState(() {
      _bookingsFuture = APIService().getPostBookings(widget.post.id);
    });
  }

  Future<void> _acceptBooking(String bookingId) async {
    final success = await APIService().acceptBooking(
      postId: widget.post.id,
      bookingId: bookingId,
    );
    if (success && mounted) {
      _refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: OColor.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: DraggableScrollableSheet(
        initialChildSize: 0.85,
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

              // Scrollable Content
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Shortened Cab Card Section
                      _ShortenedCabCard(post: widget.post),

                      const SizedBox(height: OSpacing.m),

                      // Seats Progress Bar
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: OSpacing.m,
                        ),
                        child: _SeatsProgressSection(
                          filledSeats:
                              widget.post.totalSeats -
                              widget.post.availableSeats,
                          totalSeats: widget.post.totalSeats,
                        ),
                      ),

                      const SizedBox(height: OSpacing.m),

                      // Bookings lists
                      FutureBuilder<List<BookingModel>>(
                        future: _bookingsFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Padding(
                              padding: EdgeInsets.all(OSpacing.m),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }

                          final bookings = snapshot.data ?? [];
                          final approved =
                              bookings.where((b) => b.isApproved).toList();
                          final pending =
                              bookings.where((b) => b.isPending).toList();

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (approved.isNotEmpty) ...[
                                _SectionHeader(
                                  title: 'Current Share List',
                                  count: approved.length,
                                ),
                                ...approved.map(
                                  (booking) => _ContactTile(
                                    contact: _ContactData.fromBooking(booking),
                                    actionType: _ContactActionType.call,
                                  ),
                                ),
                                const SizedBox(height: OSpacing.m),
                              ],
                              if (pending.isNotEmpty) ...[
                                _SectionHeader(
                                  title: 'Requests',
                                  count: pending.length,
                                ),
                                ...pending.map(
                                  (booking) => _ContactTile(
                                    contact: _ContactData.fromBooking(booking),
                                    actionType: _ContactActionType.accept,
                                    onAccept: () => _acceptBooking(booking.id),
                                  ),
                                ),
                              ],
                            ],
                          );
                        },
                      ),

                      const SizedBox(height: OSpacing.m),
                    ],
                  ),
                ),
              ),

              // Bottom Action Buttons
              _BottomActionButtons(
                onEditPressed: () {
                  // TODO: Edit post
                  Navigator.pop(context);
                },
                onDeletePressed: () {
                  // TODO: Delete post
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

/// Shortened cab card showing route, time, date
class _ShortenedCabCard extends StatelessWidget {
  final PostModel post;

  const _ShortenedCabCard({required this.post});

  @override
  Widget build(BuildContext context) {
    final bool byTrain = isTravelByTrain(post.to);
    final String origin = formatLocationShort(post.from);
    final String destination = formatLocationShort(post.to);
    final String time = post.getTime();
    final String date = formatDate(post.getDate());

    return Padding(
      padding: const EdgeInsets.all(OSpacing.m),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row with title and close button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(TablerIcons.car, color: OColor.green600, size: 24),
                  const SizedBox(width: OSpacing.xs),
                  Text(
                    'Current Post',
                    style: OTextStyle.headingSmall.copyWith(
                      color: OColor.gray800,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(TablerIcons.x, color: OColor.gray500, size: 24),
              ),
            ],
          ),

          const SizedBox(height: OSpacing.m),

          // Route Row
          Row(
            children: [
              _IconBadge(
                icon: TablerIcons.school,
                color: const Color(0xFF4D51EF),
              ),
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
                color:
                    byTrain ? const Color(0xFF14B8A6) : const Color(0xFF0D99D8),
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

          const SizedBox(height: OSpacing.s),

          // Time and Date Row
          Row(
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
          ),
        ],
      ),
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
    final bool isFull = filledSeats >= totalSeats;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$filledSeats / $totalSeats Seats',
              style: OTextStyle.headingSmall.copyWith(
                color: OColor.gray800,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (isFull)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: OSpacing.s,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: OColor.green600,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(TablerIcons.lock, size: 12, color: OColor.white),
                    const SizedBox(width: 4),
                    Text(
                      'FULL',
                      style: OTextStyle.labelSmall.copyWith(
                        color: OColor.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
          ],
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

/// Section header with title and count badge
class _SectionHeader extends StatelessWidget {
  final String title;
  final int count;

  const _SectionHeader({required this.title, required this.count});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: OSpacing.m,
        vertical: OSpacing.xs,
      ),
      child: Row(
        children: [
          Text(
            title,
            style: OTextStyle.labelLarge.copyWith(
              color: OColor.gray800,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: OSpacing.xs),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: OSpacing.xs,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              color: OColor.green600,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '$count',
              style: OTextStyle.labelSmall.copyWith(
                color: OColor.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Shows a contact profile dialog
void _showContactDialog(
  BuildContext context,
  _ContactData contact, {
  bool showAcceptButton = false,
  VoidCallback? onAccept,
}) {
  showDialog(
    context: context,
    builder:
        (context) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: const EdgeInsets.all(OSpacing.m),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          TablerIcons.user,
                          color: OColor.green600,
                          size: 20,
                        ),
                        const SizedBox(width: OSpacing.xs),
                        Text(
                          'Profile',
                          style: OTextStyle.headingSmall.copyWith(
                            color: OColor.gray800,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        TablerIcons.x,
                        color: OColor.gray500,
                        size: 20,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: OSpacing.m),

                // Profile Info
                Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: OColor.gray200,
                      backgroundImage: NetworkImage(
                        'https://ui-avatars.com/api/?name=${Uri.encodeComponent(contact.name)}&background=random&size=96',
                      ),
                    ),
                    const SizedBox(width: OSpacing.s),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          contact.name,
                          style: OTextStyle.labelLarge.copyWith(
                            color: OColor.gray800,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          contact.email,
                          style: OTextStyle.labelSmall.copyWith(
                            color: OColor.gray500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: OSpacing.m),

                // Important Warning
                Container(
                  padding: const EdgeInsets.all(OSpacing.s),
                  decoration: BoxDecoration(
                    color: const Color(0xFFECFDF5), // Light green
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Important',
                        style: OTextStyle.labelMedium.copyWith(
                          color: OColor.green600,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'You cannot remove a rider once the ride is confirmed. Only the rider can cancel the ride from their phone.',
                        style: OTextStyle.bodySmall.copyWith(
                          color: OColor.gray600,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: OSpacing.m),

                // Action Buttons Row
                Row(
                  children: [
                    Expanded(
                      child: _DialogActionButton(
                        icon: TablerIcons.phone,
                        label: 'Call',
                        onPressed: () {
                          // TODO: Call action
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    const SizedBox(width: OSpacing.xs),
                    Expanded(
                      child: _DialogActionButton(
                        icon: TablerIcons.message,
                        label: 'Text',
                        onPressed: () {
                          // TODO: Text action
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    const SizedBox(width: OSpacing.xs),
                    Expanded(
                      child: _DialogActionButton(
                        icon: TablerIcons.mail,
                        label: 'Mail',
                        onPressed: () {
                          // TODO: Mail action
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),

                // Accept Button (only for requests)
                if (showAcceptButton) ...[
                  const SizedBox(height: OSpacing.m),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        onAccept?.call();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: OColor.green600,
                        foregroundColor: OColor.white,
                        padding: const EdgeInsets.symmetric(
                          vertical: OSpacing.s,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Accept',
                        style: OTextStyle.labelLarge.copyWith(
                          color: OColor.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
  );
}

/// Dialog action button (Call, Text, Mail)
class _DialogActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const _DialogActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: OColor.gray300),
        padding: const EdgeInsets.symmetric(vertical: OSpacing.s),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 16, color: OColor.gray600),
          const SizedBox(width: 4),
          Text(
            label,
            style: OTextStyle.labelSmall.copyWith(color: OColor.gray700),
          ),
        ],
      ),
    );
  }
}

enum _ContactActionType { call, accept }

/// Contact tile with avatar, name, email, and action button
class _ContactTile extends StatelessWidget {
  final _ContactData contact;
  final _ContactActionType actionType;
  final VoidCallback? onAccept;

  const _ContactTile({
    required this.contact,
    required this.actionType,
    this.onAccept,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:
          () => _showContactDialog(
            context,
            contact,
            showAcceptButton: actionType == _ContactActionType.accept,
            onAccept: onAccept,
          ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: OSpacing.m,
          vertical: OSpacing.xs,
        ),
        child: Row(
          children: [
            // Avatar
            CircleAvatar(
              radius: 24,
              backgroundColor: OColor.gray200,
              backgroundImage: NetworkImage(
                'https://ui-avatars.com/api/?name=${Uri.encodeComponent(contact.name)}&background=random&size=96',
              ),
            ),
            const SizedBox(width: OSpacing.s),

            // Name and Email
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contact.name,
                    style: OTextStyle.labelLarge.copyWith(
                      color: OColor.gray800,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    contact.email,
                    style: OTextStyle.labelSmall.copyWith(
                      color: OColor.gray500,
                    ),
                  ),
                ],
              ),
            ),

            // Action Button
            _ContactActionButton(
              icon:
                  actionType == _ContactActionType.call
                      ? TablerIcons.phone
                      : TablerIcons.check,
              onPressed:
                  () => _showContactDialog(
                    context,
                    contact,
                    showAcceptButton: actionType == _ContactActionType.accept,
                    onAccept: onAccept,
                  ),
            ),
          ],
        ),
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

/// Bottom action buttons (Edit Post, Delete Post)
class _BottomActionButtons extends StatelessWidget {
  final VoidCallback onEditPressed;
  final VoidCallback onDeletePressed;

  const _BottomActionButtons({
    required this.onEditPressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(OSpacing.m),
      decoration: BoxDecoration(
        color: OColor.white,
        border: Border(top: BorderSide(color: OColor.gray200)),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: SecondaryButton(
                label: 'Edit Post',
                leadingIcon: TablerIcons.edit,
                onPressed: onEditPressed,
              ),
            ),
            const SizedBox(width: OSpacing.m),
            Expanded(
              child: SecondaryButton(
                label: 'Delete Post',
                leadingIcon: TablerIcons.trash,
                onPressed: onDeletePressed,
                bgColor: OColor.red100,
                opColor: OColor.red200,
                iconColor: OColor.red600,
                labelStyle: OTextStyle.labelMedium.copyWith(
                  color: OColor.red600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Contact data model for the lists
class _ContactData {
  final String name;
  final String email;
  final String? phoneNumber;
  final String? bookingId;

  _ContactData({
    required this.name,
    required this.email,
    this.phoneNumber,
    this.bookingId,
  });

  factory _ContactData.fromBooking(BookingModel booking) => _ContactData(
    name: booking.name,
    email: booking.email,
    phoneNumber: booking.phoneNumber,
    bookingId: booking.id,
  );
}
