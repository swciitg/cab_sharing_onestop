import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:onestop_ui/index.dart';

/// Bottom floating action buttons for home screen
class HomeBottomActions extends StatelessWidget {
  final VoidCallback onMyPostsPressed;
  final VoidCallback onShareCabPressed;

  const HomeBottomActions({
    super.key,
    required this.onMyPostsPressed,
    required this.onShareCabPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // My Posts Button
        SecondaryButton(
          bgColor: OColor.white,
          label: 'My Posts',
          leadingIcon: TablerIcons.list,
          onPressed: onMyPostsPressed,
        ),
        const SizedBox(height: OSpacing.xs),
        // Share Cab Button
        PrimaryButton(
          label: 'Share Cab',
          leadingIcon: TablerIcons.plus,
          onPressed: onShareCabPressed,
        ),
      ],
    );
  }
}
