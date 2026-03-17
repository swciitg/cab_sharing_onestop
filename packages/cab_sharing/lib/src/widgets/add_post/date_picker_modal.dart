import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../ui/custom_modal.dart';
import '../ui/date_time.dart';

/// Modal for selecting pickup date
class DatePickerModal extends StatelessWidget {
  final DateTime? initialDate;
  final ValueChanged<DateTime> onDateSelected;

  const DatePickerModal({
    super.key,
    this.initialDate,
    required this.onDateSelected,
  });

  /// Shows the date picker modal
  static Future<void> show(
    BuildContext context, {
    DateTime? initialDate,
    required ValueChanged<DateTime> onDateSelected,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (modalContext) => DatePickerModal(
            initialDate: initialDate,
            onDateSelected: onDateSelected,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    DateTime tempDate = initialDate ?? DateTime.now();

    return StatefulBuilder(
      builder: (modalContext, setModalState) {
        return CustomModal(
          heading: 'Select Pickup Date',
          headerIcon: TablerIcons.calendar,
          headerButtonPressed: () => Navigator.pop(modalContext),
          body: CabCalendar(
            dateSelected: (date) {
              tempDate = date;
            },
          ),
          buttonLabel: 'Select',
          buttonPressed: () {
            onDateSelected(tempDate);
            Navigator.pop(modalContext);
          },
        );
      },
    );
  }
}
