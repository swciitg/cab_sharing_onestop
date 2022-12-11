import 'package:flutter/material.dart';

import '../../decorations/post_and_search_style.dart';
import 'scrollable.dart';

class DateField extends StatefulWidget {
  final FixedExtentScrollController date;
  final FixedExtentScrollController month;
  final FixedExtentScrollController year;

  const DateField({Key? key, required this.date, required this.month, required this.year}) : super(key: key);

  @override
  State<DateField> createState() => _DateFieldState();
}

class _DateFieldState extends State<DateField> {

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
                child: ListWheelScrollView.useDelegate(
                    itemExtent: 40,
                    controller: widget.date,
                    perspective: 0.005,
                    diameterRatio: 1.2,
                    physics: const FixedExtentScrollPhysics(),
                    childDelegate: ListWheelChildBuilderDelegate(
                        childCount: 31,
                        builder: (context, index) {
                          return (ScrollField(
                            data: index,
                            category: 'date',
                          ));
                        })),
              ),
              Container(
                width: 1,
                color: Colors.white,
              ),
              SizedBox(
                width: 35,
                child: ListWheelScrollView.useDelegate(
                    itemExtent: 40,
                    controller: widget.month,
                    perspective: 0.005,
                    diameterRatio: 1.2,
                    physics: const FixedExtentScrollPhysics(),
                    childDelegate: ListWheelChildBuilderDelegate(
                        childCount: 12,
                        builder: (context, index) {
                          return (ScrollField(
                            data: index,
                            category: 'month',
                          ));
                        })),
              ),
              Container(
                width: 1,
                color: Colors.white,
              ),
              SizedBox(
                width: 45,
                child: ListWheelScrollView.useDelegate(
                    itemExtent: 40,
                    controller: widget.year,
                    perspective: 0.005,
                    diameterRatio: 1.2,
                    physics: const FixedExtentScrollPhysics(),
                    childDelegate: ListWheelChildBuilderDelegate(
                        childCount: 10,
                        builder: (context, index) {
                          return (ScrollField(
                            data: index,
                            category: 'year',
                          ));
                        })),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
