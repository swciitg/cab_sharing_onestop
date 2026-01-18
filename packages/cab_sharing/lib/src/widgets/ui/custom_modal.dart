import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:onestop_ui/index.dart';

/// A custom modal header widget
class ModalHeader extends StatelessWidget {
  final String heading;
  final String? subheading;
  final IconData? icon;
  final Color? iconColor;
  final IconData buttonIcon;
  final Function()? onPressed;

  const ModalHeader({
    super.key,
    required this.heading,
    this.subheading,
    this.icon,
    this.iconColor,
    this.buttonIcon = TablerIcons.x,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: OSpacing.m,
        vertical: OSpacing.s,
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, color: iconColor ?? OColor.green600, size: 24),
            const SizedBox(width: OSpacing.s),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  heading,
                  style: OTextStyle.headingMedium.copyWith(
                    color: OColor.gray800,
                  ),
                ),
                if (subheading != null) ...[
                  const SizedBox(height: OSpacing.xxs),
                  Text(
                    subheading!,
                    style: OTextStyle.bodySmall.copyWith(color: OColor.gray600),
                  ),
                ],
              ],
            ),
          ),
          IconButton(
            onPressed: onPressed,
            icon: Icon(buttonIcon, color: OColor.gray600, size: 24),
          ),
        ],
      ),
    );
  }
}

/// A customizable modal widget that follows the OModal design pattern
/// but allows for custom body content instead of just a string.
class CustomModal extends StatelessWidget {
  final String heading;
  final String? subheading;
  final IconData? headerIcon;
  final IconData? headerButtonIcon;
  final Function()? headerButtonPressed;
  final Widget body;
  final String? buttonLabel;
  final Function()? buttonPressed;

  const CustomModal({
    super.key,
    required this.heading,
    this.subheading,
    this.headerIcon,
    this.headerButtonIcon,
    this.headerButtonPressed,
    required this.body,
    this.buttonLabel,
    this.buttonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: OColor.white,
        border: Border.all(color: OColor.gray200, width: 1),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(OCornerRadius.l),
          topRight: Radius.circular(OCornerRadius.l),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ModalHeader(
            heading: heading,
            subheading: subheading,
            icon: headerIcon,
            iconColor: OColor.green600,
            buttonIcon: headerButtonIcon ?? TablerIcons.x,
            onPressed: headerButtonPressed,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: OSpacing.s,
              vertical: OSpacing.xs,
            ),
            child: body,
          ),
          if (buttonLabel != null)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: OSpacing.s,
                vertical: OSpacing.xs,
              ),
              child: SizedBox(
                width: double.infinity,
                child: PrimaryButton(
                  label: buttonLabel!,
                  onPressed: buttonPressed,
                ),
              ),
            ),
          const SizedBox(height: OSpacing.m),
        ],
      ),
    );
  }
}

/// Helper function to show a custom modal bottom sheet
Future<T?> showCustomModal<T>({
  required BuildContext context,
  required String heading,
  String? subheading,
  IconData? headerIcon,
  required Widget body,
  String? buttonLabel,
  Function()? buttonPressed,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder:
        (context) => CustomModal(
          heading: heading,
          subheading: subheading,
          headerIcon: headerIcon,
          headerButtonIcon: TablerIcons.x,
          headerButtonPressed: () => Navigator.pop(context),
          body: body,
          buttonLabel: buttonLabel,
          buttonPressed: buttonPressed,
        ),
  );
}
