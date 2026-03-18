import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:onestop_ui/index.dart';

import '../../functions/formatters.dart';
import '../../models/post_model.dart';

/// Determines the icon for a location label
IconData _locationIcon(String location) {
  final l = location.toLowerCase();
  if (l.contains('campus') || l.contains('iit') || l.contains('college')) {
    return TablerIcons.school;
  }
  if (l.contains('airport')) return TablerIcons.plane_tilt;
  if (l.contains('railway') ||
      l.contains('station') ||
      l.contains('kamakhya')) {
    return TablerIcons.train;
  }
  return TablerIcons.map_pin;
}

/// Determines the background color for a location icon
Color _locationColor(String location) {
  final l = location.toLowerCase();
  if (l.contains('campus') || l.contains('iit') || l.contains('college')) {
    return const Color(0xFF4D51EF);
  }
  if (l.contains('airport')) return const Color(0xFF0D99D8);
  if (l.contains('railway') ||
      l.contains('station') ||
      l.contains('kamakhya')) {
    return const Color(0xFF14B8A6);
  }
  return const Color(0xFFEE2856);
}

/// Route information section using OCabSharingCard style
/// Displays origin -> destination with icons and time/date
class RouteInfoSection extends StatelessWidget {
  final PostModel post;

  const RouteInfoSection({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
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
                backgroundColor: _locationColor(post.from),
                radius: 15,
                child: Icon(_locationIcon(post.from), color: OColor.white, size: 16),
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
                backgroundColor: _locationColor(post.to),
                radius: 15,
                child: Icon(
                  _locationIcon(post.to),
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
