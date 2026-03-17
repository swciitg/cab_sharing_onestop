import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:onestop_ui/index.dart';

import '../../widgets/ui/date_time.dart';

/// Modal bottom sheet for selecting a date
class HomeDatePickerModal extends StatelessWidget {
  final ValueChanged<DateTime> onDateSelected;

  const HomeDatePickerModal({super.key, required this.onDateSelected});

  static Future<void> show(
    BuildContext context, {
    required ValueChanged<DateTime> onDateSelected,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: OColor.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(OCornerRadius.l),
        ),
      ),
      builder: (context) => HomeDatePickerModal(onDateSelected: onDateSelected),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(OSpacing.m),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OText(
                text: 'Select Date',
                style: OTextStyle.headingMedium.copyWith(color: OColor.gray800),
              ),
              IconButton(
                icon: Icon(TablerIcons.x, color: OColor.gray800),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: OSpacing.s),
          SizedBox(
            height: 420,
            child: SingleChildScrollView(
              child: CabCalendar(
                dateSelected: (date) {
                  Navigator.pop(context);
                  onDateSelected(date);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
