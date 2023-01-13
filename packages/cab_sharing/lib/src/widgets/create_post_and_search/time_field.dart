
import 'package:flutter/material.dart';

import '../../decorations/post_and_search_style.dart';
import 'timepicker_color.dart';

class TimeField extends StatelessWidget {
  final TextEditingController hourController;
  final TextEditingController minController;
  const TimeField({
    Key? key,
    required this.hourController,
    required this.minController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int hour24 = int.parse(hourController.text);
    int hour12 = hour24 % 12 == 0 ? 12 : hour24 % 12;
    String period = hour24 >= 12 ? "PM" : "AM";
    String hour = hour12.toString();
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 28.0, left: 20.0),
          child: Text(
            "Time",
            style: titleStyle,
          ),
        ),
        GestureDetector(
          onTap: () async {
            FocusScope.of(context).requestFocus(FocusNode());
            TimeOfDay? pickedTime = await showTimePicker(
              builder: (context, childWidget) {
                return TimePickerColor(
                  childWidget: childWidget,
                );
              },
              initialTime: TimeOfDay(hour: int.parse(hourController.text), minute: int.parse(minController.text)),
              context: context,
              //context of current state
            );
            if (pickedTime != null) {
              hourController.value =
                  TextEditingValue(text: '${pickedTime.hour}');
              minController.value =
                  TextEditingValue(text: '${pickedTime.minute}');
            }
          },
          child: Container(
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
                Text(
                  hour,
                  style: dateTimeWheelStyle,
                ),
                const Text(
                  ":",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  minController.text.padLeft(2,'0'),
                  style: dateTimeWheelStyle,
                ),
                Text(
                  period,
                  style: timePeriodStyle,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
