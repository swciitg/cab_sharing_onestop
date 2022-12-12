import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../decorations/post_and_search_style.dart';

class DateDisplay extends StatefulWidget {
  final DateRangePickerController dateController;

  const DateDisplay({
    Key? key,
    required this.dateController,
  }) : super(key: key);

  @override
  State<DateDisplay> createState() => _DateDisplayState();
}

class _DateDisplayState extends State<DateDisplay> {
  String date = "";
  String month = "";
  String year = "";
  final List<String> myMonths = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  @override
  void initState() {
    super.initState();
    widget.dateController.addPropertyChangedListener((p0) {
      if (p0 == "selectedDate") {
        DateTime? selectedDate = widget.dateController.selectedDate;
        setState(() {
          date = selectedDate?.day.toString() ?? "";
          int idx = (selectedDate?.month ?? 1) - 1;
          month = myMonths[idx];
          year = selectedDate?.year.toString() ?? "";
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15.0, left: 20.0),
          child: Text(
            "Date ",
            style: titleStyle,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
            left: 15,
            right: 15,
            top: 8,
          ),
          decoration: commonBoxDecoration,
          height: 70,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 35,
                child: Text(
                  date,
                  style: dateTimeWheelStyle,
                ),
              ),
              Container(
                width: 1,
                color: Colors.white,
              ),
              SizedBox(
                width: 35,
                height: 70,
                child: FittedBox(
                  child: Text(
                    month,
                    style: dateTimeWheelStyle,
                  ),
                ),
              ),
              Container(
                width: 1,
                color: Colors.white,
              ),
              SizedBox(
                width: 45,
                height: 70,
                child: FittedBox(
                  child: Text(
                    year,
                    style: dateTimeWheelStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
