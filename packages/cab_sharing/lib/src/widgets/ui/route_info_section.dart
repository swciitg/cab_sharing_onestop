import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:onestop_ui/index.dart';

import '../../functions/formatters.dart';
import '../../models/post_model.dart';

/// Route information section using OCabSharingCard style
/// Displays origin -> destination with icons and time/date
class RouteInfoSection extends StatelessWidget {
  final PostModel post;

  const RouteInfoSection({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final byTrain = isTravelByTrain(post.to);
    final origin = formatLocationShort(post.from);
    final destination = formatLocationShort(post.to);
    final time = post.getTime();
    final date = post.getDate();

    return Container(
      decoration: BoxDecoration(color: OColor.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Origin -> Destination row
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: const Color(0xFF4D51EF),
                radius: 15,
                child: Icon(TablerIcons.school, color: OColor.white, size: 16),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: OSpacing.xxs),
                child: OText(
                  text: origin,
                  style: OTextStyle.labelLarge.copyWith(color: OColor.gray800),
                ),
              ),
              Icon(
                TablerIcons.arrow_narrow_right,
                color: OColor.gray500,
                size: 24,
              ),
              CircleAvatar(
                backgroundColor:
                    byTrain ? const Color(0xFF14B8A6) : const Color(0xFF0D99D8),
                radius: 15,
                child: Icon(
                  byTrain ? TablerIcons.train : TablerIcons.plane_tilt,
                  color: OColor.white,
                  size: 16,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: OSpacing.xxs),
                child: OText(
                  text: destination,
                  style: OTextStyle.labelLarge.copyWith(color: OColor.gray800),
                ),
              ),
            ],
          ),
          const SizedBox(height: OSpacing.s),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(TablerIcons.clock_pin, size: 16, color: OColor.gray600),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: OSpacing.xxs),
                child: OText(
                  text: time,
                  style: OTextStyle.labelSmall.copyWith(color: OColor.gray600),
                ),
              ),
              const SizedBox(width: OSpacing.xs),
              Icon(TablerIcons.calendar_pin, size: 16, color: OColor.gray600),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: OSpacing.xxs),
                child: OText(
                  text: date,
                  style: OTextStyle.labelSmall.copyWith(color: OColor.gray600),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
