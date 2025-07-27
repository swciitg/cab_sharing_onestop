import 'package:cab_sharing/src/services/date.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../decorations/post_and_search_style.dart';

class DateDisplay extends StatefulWidget {
  const DateDisplay({super.key});

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
    'Dec',
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<DateController>(
      builder: (_, provider, __) {
        DateTime? selectedDate = provider.dateController;
        DateTime initialise = DateTime.now();
        date = selectedDate?.day.toString() ?? initialise.day.toString();
        int idx = (selectedDate?.month ?? initialise.month) - 1;
        month = myMonths[idx];
        year = selectedDate?.year.toString() ?? initialise.year.toString();
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 15.0, left: 20.0),
              child: Text("Date ", style: titleStyle),
            ),
            Container(
              margin: const EdgeInsets.only(left: 15, right: 15, top: 8),
              decoration: commonBoxDecoration,
              height: 70,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(width: 35, child: Text(date, style: dateTimeWheelStyle)),
                  Container(width: 1, color: Colors.white),
                  SizedBox(
                    width: 35,
                    height: 70,
                    child: FittedBox(child: Text(month, style: dateTimeWheelStyle)),
                  ),
                  Container(width: 1, color: Colors.white),
                  SizedBox(
                    width: 45,
                    height: 70,
                    child: FittedBox(child: Text(year, style: dateTimeWheelStyle)),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
