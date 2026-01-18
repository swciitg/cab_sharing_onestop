import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:onestop_ui/index.dart';
import 'package:onestop_ui/constants/spacing.dart';
// import '../utils/colors.dart';
// import '../utils/styles.dart';

class OCalendar extends StatefulWidget {
  final Function(DateTime)? dateSelected;

  const OCalendar({super.key, this.dateSelected});

  @override
  State<OCalendar> createState() => _OCalendarState();
}

class _OCalendarState extends State<OCalendar> {
  DateTime _focusedMonth = DateTime.now();
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }

  List<DateTime> _generateDaysForMonth(DateTime month) {
    final firstDay = DateTime(month.year, month.month, 1);
    final daysInMonth = DateUtils.getDaysInMonth(month.year, month.month);
    final startWeekday = firstDay.weekday;

    final prevMonth = DateTime(month.year, month.month - 1);
    final prevMonthDays = DateUtils.getDaysInMonth(
      prevMonth.year,
      prevMonth.month,
    );
    final leadingDays = List.generate(
      startWeekday - 1,
      (i) => DateTime(
        prevMonth.year,
        prevMonth.month,
        prevMonthDays - startWeekday + i + 2,
      ),
    );

    final currentDays = List.generate(
      daysInMonth,
      (i) => DateTime(month.year, month.month, i + 1),
    );

    final totalCells = 42;
    final remaining = totalCells - (leadingDays.length + currentDays.length);
    final nextMonth = DateTime(month.year, month.month + 1);
    final trailingDays = List.generate(
      remaining,
      (i) => DateTime(nextMonth.year, nextMonth.month, i + 1),
    );

    return [...leadingDays, ...currentDays, ...trailingDays];
  }

  @override
  Widget build(BuildContext context) {
    final days = _generateDaysForMonth(_focusedMonth);

    return Container(
      padding: const EdgeInsets.all(OSpacing.m),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: () {
                  setState(() {
                    _focusedMonth = DateTime(
                      _focusedMonth.year,
                      _focusedMonth.month - 1,
                    );
                  });
                },
              ),
              Text(
                DateFormat('MMMM yyyy').format(_focusedMonth),
                style: OTextStyle.labelMedium.copyWith(color: OColor.gray800),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: () {
                  setState(() {
                    _focusedMonth = DateTime(
                      _focusedMonth.year,
                      _focusedMonth.month + 1,
                    );
                  });
                },
              ),
            ],
          ),
          SizedBox(height: OSpacing.xs),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:
                ["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"]
                    .map(
                      (d) => Expanded(
                        child: Center(
                          child: Text(
                            d,
                            style: OTextStyle.headingXSmall.copyWith(
                              color: OColor.gray800,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
          ),
          SizedBox(height: OSpacing.xs),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: OSpacing.xxs,
              crossAxisSpacing: OSpacing.xxs,
            ),
            itemCount: days.length,
            itemBuilder: (context, index) {
              final day = days[index];
              final isCurrentMonth = day.month == _focusedMonth.month;
              final isSelected = DateUtils.isSameDay(day, _selectedDate);
              final today = DateTime.now();
              final isPastDate = day.isBefore(
                DateTime(today.year, today.month, today.day),
              );
              final isDisabled = !isCurrentMonth || isPastDate;

              return GestureDetector(
                onTap:
                    isDisabled
                        ? null
                        : () {
                          setState(() {
                            _selectedDate = day;
                            widget.dateSelected?.call(day);
                          });
                        },
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected ? OColor.green600 : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "${day.day}",
                    style: OTextStyle.headingXSmall.copyWith(
                      color:
                          isDisabled
                              ? OColor.gray400
                              : (isSelected ? OColor.white : OColor.gray800),
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: OSpacing.xs),
        ],
      ),
    );
  }
}

class ClockTime extends StatefulWidget {
  final int? initialHour;
  final int? initialMinute;
  final String? initialPeriod;
  final Function(int hour, int minute, String period)? onTimeChanged;

  const ClockTime({
    super.key,
    this.initialHour,
    this.initialMinute,
    this.initialPeriod,
    this.onTimeChanged,
  });

  @override
  State<ClockTime> createState() => _ClockTimeState();
}

class _ClockTimeState extends State<ClockTime> {
  late int hour;
  late int minute;
  late String period;

  late FixedExtentScrollController _hourController;
  late FixedExtentScrollController _minuteController;
  late FixedExtentScrollController _periodController;

  @override
  void initState() {
    super.initState();
    if (widget.initialHour != null &&
        widget.initialMinute != null &&
        widget.initialPeriod != null) {
      hour = widget.initialHour!;
      minute = widget.initialMinute!;
      period = widget.initialPeriod!;
    } else {
      final now = DateTime.now();
      hour = now.hour % 12 == 0 ? 12 : now.hour % 12;
      minute = now.minute;
      period = now.hour >= 12 ? 'PM' : 'AM';
    }

    _hourController = FixedExtentScrollController(initialItem: hour - 1);
    _minuteController = FixedExtentScrollController(initialItem: minute);
    _periodController = FixedExtentScrollController(
      initialItem: period == 'AM' ? 0 : 1,
    );
  }

  @override
  void dispose() {
    _hourController.dispose();
    _minuteController.dispose();
    _periodController.dispose();
    super.dispose();
  }

  void _notifyChange() {
    widget.onTimeChanged?.call(hour, minute, period);
  }

  Widget _buildLoopingScrollWheel({
    required FixedExtentScrollController controller,
    required List<String> items,
    required ValueChanged<int> onSelectedItemChanged,
    required int initialIndex,
    double width = 60,
  }) {
    return SizedBox(
      width: width,
      height: 150,
      child: StatefulBuilder(
        builder: (context, setLocalState) {
          return NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollUpdateNotification) {
                setLocalState(() {});
              }
              return false;
            },
            child: ListWheelScrollView.useDelegate(
              controller: controller,
              itemExtent: 50,
              perspective: 0.005,
              diameterRatio: 1.2,
              physics: const FixedExtentScrollPhysics(),
              onSelectedItemChanged: (index) {
                onSelectedItemChanged(index);
                setLocalState(() {});
              },
              childDelegate: ListWheelChildLoopingListDelegate(
                children:
                    items.asMap().entries.map((entry) {
                      int currentSelected;
                      try {
                        currentSelected =
                            controller.hasClients
                                ? (controller.selectedItem % items.length)
                                : initialIndex;
                      } catch (_) {
                        currentSelected = initialIndex;
                      }
                      final isSelected = currentSelected == entry.key;
                      return Center(
                        child: Text(
                          entry.value,
                          style:
                              isSelected
                                  ? OTextStyle.headingLarge.copyWith(
                                    color: OColor.gray800,
                                  )
                                  : OTextStyle.labelMedium.copyWith(
                                    color: OColor.gray400,
                                  ),
                        ),
                      );
                    }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildScrollWheel({
    required FixedExtentScrollController controller,
    required int itemCount,
    required String Function(int index) itemBuilder,
    required ValueChanged<int> onSelectedItemChanged,
    double width = 60,
  }) {
    return SizedBox(
      width: width,
      height: 150,
      child: ListWheelScrollView.useDelegate(
        controller: controller,
        itemExtent: 50,
        perspective: 0.005,
        diameterRatio: 1.2,
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: onSelectedItemChanged,
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: itemCount,
          builder: (context, index) {
            final isSelected =
                controller.hasClients
                    ? controller.selectedItem == index
                    : (controller.initialItem == index);
            return Center(
              child: Text(
                itemBuilder(index),
                style:
                    isSelected
                        ? OTextStyle.headingLarge.copyWith(
                          color: OColor.gray800,
                        )
                        : OTextStyle.labelMedium.copyWith(
                          color: OColor.gray400,
                        ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Generate hour items (1-12)
    final hourItems = List.generate(
      12,
      (i) => (i + 1).toString().padLeft(2, '0'),
    );
    // Generate minute items (0-59)
    final minuteItems = List.generate(60, (i) => i.toString().padLeft(2, '0'));

    return Container(
      padding: const EdgeInsets.all(OSpacing.m),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Hour wheel (1-12) - looping
          _buildLoopingScrollWheel(
            controller: _hourController,
            items: hourItems,
            initialIndex: hour - 1,
            onSelectedItemChanged: (index) {
              setState(() {
                hour = (index % 12) + 1;
                _notifyChange();
              });
            },
          ),
          Text(
            ':',
            style: OTextStyle.headingLarge.copyWith(color: OColor.gray800),
          ),
          // Minute wheel (0-59) - looping
          _buildLoopingScrollWheel(
            controller: _minuteController,
            items: minuteItems,
            initialIndex: minute,
            onSelectedItemChanged: (index) {
              setState(() {
                minute = index % 60;
                _notifyChange();
              });
            },
          ),
          const SizedBox(width: OSpacing.s),
          // AM/PM wheel - not looping (only 2 items)
          _buildScrollWheel(
            controller: _periodController,
            itemCount: 2,
            itemBuilder: (index) => index == 0 ? 'AM' : 'PM',
            onSelectedItemChanged: (index) {
              setState(() {
                period = index == 0 ? 'AM' : 'PM';
                _notifyChange();
              });
            },
            width: 70,
          ),
        ],
      ),
    );
  }
}

/// A number picker widget with scrollable wheel for selecting numeric values
class NumberPicker extends StatefulWidget {
  final int initialValue;
  final int minValue;
  final int maxValue;
  final Function(int)? onValueChanged;

  const NumberPicker({
    super.key,
    this.initialValue = 1,
    this.minValue = 1,
    this.maxValue = 6,
    this.onValueChanged,
  });

  @override
  State<NumberPicker> createState() => _NumberPickerState();
}

class _NumberPickerState extends State<NumberPicker> {
  late int _currentValue;
  late FixedExtentScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue.clamp(widget.minValue, widget.maxValue);
    _scrollController = FixedExtentScrollController(
      initialItem: _currentValue - widget.minValue,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  int get currentValue => _currentValue;

  @override
  Widget build(BuildContext context) {
    final itemCount = widget.maxValue - widget.minValue + 1;

    return Container(
      padding: const EdgeInsets.all(OSpacing.m),
      child: SizedBox(
        width: 80,
        height: 150,
        child: ListWheelScrollView.useDelegate(
          controller: _scrollController,
          itemExtent: 50,
          perspective: 0.005,
          diameterRatio: 1.2,
          physics: const FixedExtentScrollPhysics(),
          onSelectedItemChanged: (index) {
            setState(() {
              _currentValue = widget.minValue + index;
              widget.onValueChanged?.call(_currentValue);
            });
          },
          childDelegate: ListWheelChildBuilderDelegate(
            childCount: itemCount,
            builder: (context, index) {
              final value = widget.minValue + index;
              final isSelected =
                  _scrollController.hasClients
                      ? _scrollController.selectedItem == index
                      : (_scrollController.initialItem == index);
              return Center(
                child: Text(
                  value.toString(),
                  style:
                      isSelected
                          ? OTextStyle.headingLarge.copyWith(
                            color: OColor.gray800,
                          )
                          : OTextStyle.labelMedium.copyWith(
                            color: OColor.gray400,
                          ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
