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
              decoration: BoxDecoration(
                color: kCommonBoxBackground,
                borderRadius: const BorderRadius.all(Radius.circular(21)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              margin: const EdgeInsets.only(left: 15, right: 15, top: 8),
              height: 350,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(21)),
                child: DatePicker(
                  minDate: today,
                  maxDate: aYearLater,
                  onDateSelected: (value) {
                    provider.setdate(value);
                  },
                  initialDate: today,
                  selectedDate: today,
                  currentDate: today,
                  daysOfTheWeekTextStyle: dateTimeWheelStyle.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                  enabledCellsTextStyle: dateTimeWheelStyle.copyWith(fontSize: 14),
                  disabledCellsTextStyle: dateTimeWheelStyle.copyWith(
                    color: kHintTextColor,
                    fontSize: 14,
                  ),
                  currentDateTextStyle: dateTimeWheelStyle.copyWith(
                    fontSize: 14,
                    color: Colors.blueAccent,
                  ),
                  selectedCellTextStyle: dateTimeWheelStyle.copyWith(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                  slidersColor: const Color.fromRGBO(118, 172, 255, 1),
                  splashRadius: 0,
                  currentDateDecoration: BoxDecoration(
                    border: Border.all(color: const Color.fromRGBO(118, 172, 255, 1), width: 2),
                    shape: BoxShape.circle,
                  ),
                  selectedCellDecoration: BoxDecoration(
                    color: const Color.fromRGBO(118, 172, 255, 1),
                    border: Border.all(color: const Color.fromRGBO(118, 172, 255, 1)),
                    shape: BoxShape.circle,
                  ),
                  leadingDateTextStyle: dateTimeWheelStyle.copyWith(fontSize: 13),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
