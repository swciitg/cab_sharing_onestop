import 'package:cab_sharing/src/services/date.dart';
import 'package:cab_sharing/src/widgets/create_post_and_search/date_display.dart';
import 'package:flutter/material.dart';
import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:provider/provider.dart';
import '../../decorations/colors.dart';
import '../../decorations/post_and_search_style.dart';

class DateCalendar extends StatelessWidget {
  const DateCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    var today = DateTime.now();
    var aYearLater = DateTime(today.year + 1, today.month, today.day);
    return Consumer<DateController>(
      builder: (_, provider, __) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DateDisplay(),
            Container(
              decoration: commonBoxDecoration,
              margin: const EdgeInsets.only(left: 15, right: 15, top: 8),
              height: 350,
              child: DatePicker(
                minDate: today,
                maxDate: aYearLater,
                onDateSelected: (value) {
                  provider.setdate(value);
                },
                initialDate: today,
                selectedDate: today,
                currentDate: today,
                daysOfTheWeekTextStyle: dateTimeWheelStyle,
                enabledCellsTextStyle: dateTimeWheelStyle,
                disabledCellsTextStyle: dateTimeWheelStyle.copyWith(color: kHintTextColor),
                currentDateTextStyle: dateTimeWheelStyle,
                selectedCellTextStyle: dateTimeWheelStyle.copyWith(color: Colors.black),
                slidersColor: dateTimeWheelStyle.color,
                splashRadius: 0,
                currentDateDecoration: BoxDecoration(
                  border: Border.all(color: kFloatingButtonColor),
                  shape: BoxShape.circle,
                ),
                selectedCellDecoration: BoxDecoration(
                  color: dateTimeWheelStyle.color,
                  border: Border.all(color: dateTimeWheelStyle.color!),
                  shape: BoxShape.circle,
                ),
                leadingDateTextStyle: dateTimeWheelStyle,
              ),
            ),
          ],
        );
      },
    );
  }
}
