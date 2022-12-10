import 'package:cab_sharing/src/decorations/post_and_search_style.dart';
import 'package:flutter/material.dart';

class ScrollField extends StatelessWidget {
  final String category;
  final int data;
  const ScrollField({Key? key, required this.category, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> myMonths = [
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
    String text;
    if (category == 'date') {
      text = (data + 1).toString();
    } else if (category == 'month') {
      text = myMonths[data];
    } else if (category == 'year') {
      text = (data + 2022).toString();
    } else if (category == 'hour') {
      text = data.toString();
    } else {
      text = data < 10 ? '0$data' : data.toString();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Center(
        child: Text(
          text,
          style: dateTimeWheelStyle,
        ),
      ),
    );
  }
}
