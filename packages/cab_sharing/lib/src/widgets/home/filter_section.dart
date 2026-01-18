import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:onestop_ui/index.dart';

import '../../functions/filter_helpers.dart';

/// Horizontally scrollable filter section with date picker and location filters
class FilterSection extends StatelessWidget {
  final CabFilter selectedFilter;
  final DateTime? selectedDate;
  final ValueChanged<CabFilter> onFilterChanged;
  final VoidCallback onDatePickerTap;
  final VoidCallback onClearDate;

  const FilterSection({
    super.key,
    required this.selectedFilter,
    required this.selectedDate,
    required this.onFilterChanged,
    required this.onDatePickerTap,
    required this.onClearDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: OSpacing.s),
      color: OColor.white,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: OSpacing.s),
        child: Row(
          children: [
            // Date picker button
            Padding(
              padding: const EdgeInsets.only(right: OSpacing.xs),
              child: DatePickerButton(
                selectedDate: selectedDate,
                onTap: onDatePickerTap,
                onClear: onClearDate,
              ),
            ),
            // Vertical divider
            Container(
              height: 32,
              width: 1,
              color: OColor.gray300,
              margin: const EdgeInsets.symmetric(horizontal: OSpacing.xs),
            ),
            // Filter buttons
            ...CabFilter.values.map((filter) {
              final isSelected = selectedFilter == filter;
              return Padding(
                padding: const EdgeInsets.only(right: OSpacing.xs),
                child: FilterButton(
                  filter: filter,
                  isSelected: isSelected,
                  onTap: () => onFilterChanged(filter),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

/// Date picker button with optional clear action
class DatePickerButton extends StatelessWidget {
  final DateTime? selectedDate;
  final VoidCallback onTap;
  final VoidCallback onClear;

  const DatePickerButton({
    super.key,
    required this.selectedDate,
    required this.onTap,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final hasDate = selectedDate != null;

    if (hasDate) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          PrimaryButton(
            label:
                '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
            onPressed: onTap,
            leadingIcon: TablerIcons.calendar,
            padding: const EdgeInsets.symmetric(
              horizontal: OSpacing.m,
              vertical: OSpacing.xs,
            ),
            labelStyle: OTextStyle.labelSmall.copyWith(color: OColor.white),
          ),
          const SizedBox(width: OSpacing.xxs),
          // Clear button
          GestureDetector(
            onTap: onClear,
            child: Container(
              padding: const EdgeInsets.all(OSpacing.xs),
              decoration: BoxDecoration(
                color: OColor.red600,
                borderRadius: BorderRadius.circular(OCornerRadius.l),
              ),
              child: Icon(TablerIcons.x, size: 16, color: OColor.white),
            ),
          ),
        ],
      );
    }

    return SecondaryButton(
      label: 'Select Date',
      onPressed: onTap,
      leadingIcon: TablerIcons.calendar,
      padding: const EdgeInsets.symmetric(
        horizontal: OSpacing.m,
        vertical: OSpacing.xs,
      ),
      labelStyle: OTextStyle.labelSmall,
    );
  }
}

/// Individual filter button for location filtering
class FilterButton extends StatelessWidget {
  final CabFilter filter;
  final bool isSelected;
  final VoidCallback onTap;

  const FilterButton({
    super.key,
    required this.filter,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final label = getFilterLabel(filter);

    if (isSelected) {
      return PrimaryButton(
        label: label,
        onPressed: onTap,
        padding: const EdgeInsets.symmetric(
          horizontal: OSpacing.m,
          vertical: OSpacing.xs,
        ),
        labelStyle: OTextStyle.labelSmall.copyWith(color: OColor.white),
      );
    }

    return SecondaryButton(
      label: label,
      onPressed: onTap,
      padding: const EdgeInsets.symmetric(
        horizontal: OSpacing.m,
        vertical: OSpacing.xs,
      ),
      labelStyle: OTextStyle.labelSmall,
    );
  }
}
