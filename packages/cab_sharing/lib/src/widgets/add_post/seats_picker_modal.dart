import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../ui/custom_modal.dart';
import '../ui/date_time.dart';

/// Modal for selecting available seats
class SeatsPickerModal extends StatelessWidget {
  final int initialValue;
  final int minValue;
  final int maxValue;
  final ValueChanged<int> onSeatsSelected;

  const SeatsPickerModal({
    super.key,
    required this.initialValue,
    this.minValue = 1,
    this.maxValue = 6,
    required this.onSeatsSelected,
  });

  /// Shows the seats picker modal
  static Future<void> show(
    BuildContext context, {
    required int initialValue,
    int minValue = 1,
    int maxValue = 6,
    required ValueChanged<int> onSeatsSelected,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (modalContext) => SeatsPickerModal(
            initialValue: initialValue,
            minValue: minValue,
            maxValue: maxValue,
            onSeatsSelected: onSeatsSelected,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int tempSeats = initialValue;

    return StatefulBuilder(
      builder: (modalContext, setModalState) {
        return CustomModal(
          heading: 'Select Available Seats',
          headerIcon: TablerIcons.users,
          headerButtonPressed: () => Navigator.pop(modalContext),
          body: NumberPicker(
            initialValue: tempSeats,
            minValue: minValue,
            maxValue: maxValue,
            onValueChanged: (value) {
              tempSeats = value;
            },
          ),
          buttonLabel: 'Select',
          buttonPressed: () {
            onSeatsSelected(tempSeats);
            Navigator.pop(modalContext);
          },
        );
      },
    );
  }
}
