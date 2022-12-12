import 'package:cab_sharing/src/widgets/create_post_and_search/date_display.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../decorations/colors.dart';
import '../../decorations/post_and_search_style.dart';

class DateCalendar extends StatelessWidget {
  const DateCalendar({
    Key? key,
    required this.dateController,
  }) : super(key: key);

  final DateRangePickerController dateController;

  @override
  Widget build(BuildContext context) {
    var today = DateTime.now();
    var aYearLater = DateTime(today.year + 1, today.month, today.day);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DateDisplay(dateController: dateController),
        Container(
          decoration: commonBoxDecoration,
          margin: const EdgeInsets.only(
            left: 15,
            right: 15,
            top: 8,
          ),
          height: 350,
          child: SfDateRangePicker(
            showNavigationArrow: true,
            headerHeight: 50,
            view: DateRangePickerView.month,
            minDate: today,
            maxDate: aYearLater,
            enablePastDates: false,
            allowViewNavigation: true,
            controller: dateController,
            monthViewSettings: DateRangePickerMonthViewSettings(
              viewHeaderStyle: DateRangePickerViewHeaderStyle(
                textStyle:
                    dateTimeWheelStyle.copyWith(color: kFloatingButtonColor),
              ),
            ),
            headerStyle: DateRangePickerHeaderStyle(
                textStyle: dateTimeWheelStyle.copyWith(fontSize: 20),
                textAlign: TextAlign.center),
            monthCellStyle: DateRangePickerMonthCellStyle(
              disabledDatesTextStyle:
                  dateTimeWheelStyle.copyWith(color: kHintTextColor),
              textStyle: dateTimeWheelStyle,
              todayTextStyle: dateTimeWheelStyle,
              todayCellDecoration: BoxDecoration(
                border: Border.all(color: kFloatingButtonColor),
                shape: BoxShape.circle,
              ),
            ),
            selectionTextStyle:
                dateTimeWheelStyle.copyWith(color: Colors.black),
            selectionColor: kFloatingButtonColor,
            yearCellStyle: DateRangePickerYearCellStyle(
                leadingDatesTextStyle: dateTimeWheelStyle,
                textStyle: dateTimeWheelStyle,
                disabledDatesTextStyle:
                    dateTimeWheelStyle.copyWith(color: kHintTextColor),
                todayTextStyle: dateTimeWheelStyle,
                todayCellDecoration: BoxDecoration(
                  border: Border.all(color: kFloatingButtonColor),
                  borderRadius: BorderRadius.circular(200),
                  // color: kFloatingButtonColor,
                )),
          ),
        ),
      ],
    );
  }
}
