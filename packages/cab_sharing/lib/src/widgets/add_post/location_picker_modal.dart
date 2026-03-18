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
  'Other',
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
class LocationPickerModal extends StatefulWidget {
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
  State<LocationPickerModal> createState() => _LocationPickerModalState();
}

class _LocationPickerModalState extends State<LocationPickerModal> {
  late String? _selectedValue;
  late TextEditingController _customController;
  late bool _showCustomField;

  @override
  void initState() {
    super.initState();
    // Determine if current value is a custom (non-standard) location
    final isOtherSelected =
        widget.currentValue.isNotEmpty &&
        !locationOptions.contains(widget.currentValue) &&
        widget.currentValue != 'Other';

    _selectedValue = isOtherSelected ? 'Other' : widget.currentValue;
    _customController = TextEditingController(
      text: isOtherSelected ? widget.currentValue : '',
    );
    _showCustomField = isOtherSelected;
  }

  @override
  void dispose() {
    _customController.dispose();
    super.dispose();
  }

  void _selectLocation(String location) {
    if (location == 'Other') {
      setState(() {
        _selectedValue = 'Other';
        _showCustomField = true;
      });
    } else {
      setState(() => _selectedValue = location);
      Navigator.pop(context, location);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Push above keyboard when typing custom location
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: CustomModal(
        heading: widget.title,
        headerIcon: widget.headerIcon,
        headerButtonPressed: () => Navigator.pop(context),
        body: Column(
          children: [
            ...locationOptions.map(
              (location) => InkWell(
                onTap: () => _selectLocation(location),
                borderRadius: BorderRadius.circular(OCornerRadius.m),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: OSpacing.s,
                    vertical: OSpacing.s,
                  ),
                  margin: const EdgeInsets.symmetric(vertical: OSpacing.xxs),
                  decoration: BoxDecoration(
                    color: OColor.white,
                    borderRadius: BorderRadius.circular(OCornerRadius.m),
                    border: Border.all(
                      color: _selectedValue == location
                          ? OColor.green600
                          : OColor.gray200,
                      width: _selectedValue == location ? 1.5 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        getLocationIcon(location),
                        color: _selectedValue == location
                            ? OColor.green600
                            : OColor.gray600,
                        size: 20,
                      ),
                      const SizedBox(width: OSpacing.s),
                      Expanded(
                        child: Text(
                          location,
                          style: OTextStyle.bodyMedium.copyWith(
                            color: _selectedValue == location
                                ? OColor.green600
                                : OColor.gray800,
                          ),
                        ),
                      ),
                      RadioButton(
                        onBorderColor: OColor.green600,
                        offBorderColor: OColor.gray200,
                        value: _selectedValue == location,
                        onChanged: (_) => _selectLocation(location),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Custom location text field (shown when 'Other' is selected)
            if (_showCustomField) ...[
              const SizedBox(height: OSpacing.m),
              OTextField(
                maxLength: 50,
                label: 'Enter location',
                controller: _customController,
                hint: 'e.g. New Delhi Railway Station',
              ),
              const SizedBox(height: OSpacing.s),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final text = _customController.text.trim();
                    if (text.isNotEmpty) {
                      Navigator.pop(context, text);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: OColor.green600,
                    foregroundColor: OColor.white,
                    padding: const EdgeInsets.symmetric(vertical: OSpacing.s),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(OCornerRadius.m),
                    ),
                  ),
                  child: Text(
                    'Confirm',
                    style: OTextStyle.labelLarge.copyWith(
                      color: OColor.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
