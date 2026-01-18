import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../ui/custom_modal.dart';
import '../ui/date_time.dart';

/// Modal for selecting pickup time
class TimePickerModal extends StatelessWidget {
  final int initialHour;
  final int initialMinute;
  final String initialPeriod;
  final void Function(int hour, int minute, String period) onTimeSelected;

  const TimePickerModal({
    super.key,
    required this.initialHour,
    required this.initialMinute,
    required this.initialPeriod,
    required this.onTimeSelected,
  });

  /// Shows the time picker modal
  static Future<void> show(
    BuildContext context, {
    required int initialHour,
    required int initialMinute,
    required String initialPeriod,
    required void Function(int hour, int minute, String period) onTimeSelected,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (modalContext) => TimePickerModal(
            initialHour: initialHour,
            initialMinute: initialMinute,
            initialPeriod: initialPeriod,
            onTimeSelected: onTimeSelected,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int tempHour = initialHour;
    int tempMinute = initialMinute;
    String tempPeriod = initialPeriod;

    return StatefulBuilder(
      builder: (modalContext, setModalState) {
        return CustomModal(
          heading: 'Select Pickup Time',
          headerIcon: TablerIcons.clock,
          headerButtonPressed: () => Navigator.pop(modalContext),
          body: ClockTime(
            initialHour: tempHour,
            initialMinute: tempMinute,
            initialPeriod: tempPeriod,
            onTimeChanged: (hour, minute, period) {
              tempHour = hour;
              tempMinute = minute;
              tempPeriod = period;
            },
          ),
          buttonLabel: 'Select',
          buttonPressed: () {
            onTimeSelected(tempHour, tempMinute, tempPeriod);
            Navigator.pop(modalContext);
          },
        );
      },
    );
  }
}
