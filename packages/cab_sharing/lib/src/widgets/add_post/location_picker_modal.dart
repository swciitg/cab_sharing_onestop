import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:onestop_ui/index.dart';

import '../ui/custom_modal.dart';

/// Location options for the picker
const List<String> locationOptions = [
  'Airport',
  'Campus',
  'Guwahati Railway Station',
  'Kamakhya Railway Station',
];

/// Returns appropriate icon for a location
IconData getLocationIcon(String location) {
  switch (location) {
    case 'Airport':
      return TablerIcons.plane;
    case 'Campus':
      return TablerIcons.school;
    case 'Guwahati Railway Station':
    case 'Kamakhya Railway Station':
      return TablerIcons.train;
    default:
      return TablerIcons.map_pin;
  }
}

/// Modal for selecting location (From/To)
class LocationPickerModal extends StatelessWidget {
  final String title;
  final String currentValue;
  final IconData headerIcon;

  const LocationPickerModal({
    super.key,
    required this.title,
    required this.currentValue,
    required this.headerIcon,
  });

  /// Shows the location picker modal and returns the selected location
  static Future<String?> show(
    BuildContext context, {
    required String title,
    required String currentValue,
    required IconData headerIcon,
  }) {
    return showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (modalContext) => LocationPickerModal(
            title: title,
            currentValue: currentValue,
            headerIcon: headerIcon,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String? selectedValue = currentValue;

    return StatefulBuilder(
      builder: (modalContext, setModalState) {
        return CustomModal(
          heading: title,
          headerIcon: headerIcon,
          headerButtonPressed: () => Navigator.pop(modalContext),
          body: Column(
            children:
                locationOptions
                    .map(
                      (location) => InkWell(
                        onTap: () {
                          setModalState(() => selectedValue = location);
                          Navigator.pop(modalContext, location);
                        },
                        borderRadius: BorderRadius.circular(OCornerRadius.m),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: OSpacing.s,
                            vertical: OSpacing.s,
                          ),
                          margin: const EdgeInsets.symmetric(
                            vertical: OSpacing.xxs,
                          ),
                          decoration: BoxDecoration(
                            color: OColor.white,
                            borderRadius: BorderRadius.circular(
                              OCornerRadius.m,
                            ),
                            border: Border.all(color: OColor.gray200),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                getLocationIcon(location),
                                color: OColor.gray600,
                                size: 20,
                              ),
                              const SizedBox(width: OSpacing.s),
                              Expanded(
                                child: Text(
                                  location,
                                  style: OTextStyle.bodyMedium.copyWith(
                                    color: OColor.gray800,
                                  ),
                                ),
                              ),
                              RadioButton(
                                onBorderColor: OColor.green600,
                                offBorderColor: OColor.gray200,
                                value: selectedValue == location,
                                onChanged: (_) {
                                  setModalState(() => selectedValue = location);
                                  Navigator.pop(modalContext, location);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
          ),
        );
      },
    );
  }
}
