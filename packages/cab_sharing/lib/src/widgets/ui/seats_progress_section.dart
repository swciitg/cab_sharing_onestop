import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:onestop_ui/index.dart';

/// Seats progress indicator section with discrete seat indicators
class SeatsProgressSection extends StatelessWidget {
  final int joinedCount;
  final int totalSeats;

  const SeatsProgressSection({
    super.key,
    required this.joinedCount,
    required this.totalSeats,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(TablerIcons.users, color: OColor.green600, size: 18),
            const SizedBox(width: OSpacing.xs),
            Text(
              '$joinedCount / $totalSeats Seats',
              style: OTextStyle.bodyMedium.copyWith(
                color: OColor.gray800,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: OSpacing.xs),
        // Discrete seat indicators
        Row(
          children: List.generate(
            totalSeats,
            (index) => Expanded(
              child: Container(
                height: 5,
                margin: EdgeInsets.only(right: index < totalSeats - 1 ? 4 : 0),
                decoration: BoxDecoration(
                  color: index < joinedCount ? OColor.green600 : OColor.gray200,
                  borderRadius: BorderRadius.circular(OCornerRadius.s),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
