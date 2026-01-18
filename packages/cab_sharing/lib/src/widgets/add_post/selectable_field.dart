import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:onestop_ui/index.dart';

/// A selectable field that looks like OTextField but opens a modal on tap
class SelectableField extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final VoidCallback onTap;
  final bool showChevron;

  const SelectableField({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.onTap,
    this.showChevron = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: OTextStyle.labelSmall.copyWith(color: OColor.gray800),
        ),
        const SizedBox(height: OSpacing.xxs),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(OSpacing.m),
            decoration: BoxDecoration(
              color: OColor.gray100,
              borderRadius: BorderRadius.circular(OCornerRadius.m),
              border: Border.all(color: OColor.gray200),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    value,
                    style: OTextStyle.bodyMedium.copyWith(
                      color: OColor.green600,
                    ),
                  ),
                ),
                if (showChevron)
                  Icon(
                    TablerIcons.chevron_right,
                    color: OColor.gray500,
                    size: 20,
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
