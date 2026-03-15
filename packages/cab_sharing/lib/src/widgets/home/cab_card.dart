import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:onestop_ui/index.dart';

import '../../functions/formatters.dart';
import '../../models/post_model.dart';
//import '../../services/user_store.dart';

/// Individual cab sharing card widget
class CabCard extends StatelessWidget {
  final PostModel post;
  final String userName;
  final VoidCallback onTap;
  final VoidCallback onJoinPressed;

  const CabCard({
    super.key,
    required this.post,
    required this.userName,
    required this.onTap,
    required this.onJoinPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: OSpacing.xs,
        vertical: OSpacing.xxs,
      ),
      child: OCabSharingCard(
        userName: userName,
        isEnabled: true,
        isUserAvailable: true,
        byTrain: isTravelByTrain(post.to),
        origin: formatLocationShort(post.from),
        destination: formatLocationShort(post.to),
        time: post.getTime(),
        date: formatDate(post.getDate()),
        status: '${post.availableSeats} Left',
        statusIcon: TablerIcons.chair_director,
        subHeading: formatNote(post.note),
        imageURl:
            'https://ui-avatars.com/api/?name=${Uri.encodeComponent(userName)}&background=random',
        onArrowPressed: onTap,
        buttonIcon2: TablerIcons.user_plus,
        buttonLabel2: 'Join',
        pressedButton2: onJoinPressed,
      ),
    );
  }
}

/// Date header for post grouping
class DateHeader extends StatelessWidget {
  final String date;

  const DateHeader({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: OSpacing.m,
        left: OSpacing.m,
        right: OSpacing.m,
        bottom: OSpacing.xxs,
      ),
      child: OText(
        text: date,
        style: OTextStyle.headingSmall.copyWith(color: OColor.gray800),
      ),
    );
  }
}
