import 'package:cab_sharing/src/widgets/create_post_and_search/scrollable.dart';
import 'package:flutter/material.dart';
import '../../decorations/post_and_search_style.dart';

class TimeField extends StatefulWidget {
  var timeController;
  TimeField({Key? key, required this.timeController}) : super(key: key);

  @override
  State<TimeField> createState() => _TimeFieldState();
}

class _TimeFieldState extends State<TimeField> {
  final FixedExtentScrollController _controller = FixedExtentScrollController();
  int minutesValue = 0;
  int hoursValue = 0;

  @override
  Widget build(BuildContext context) {
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
                width: 70,
                child: ListWheelScrollView.useDelegate(
                  itemExtent: 40,
                  controller: _controller,
                  perspective: 0.005,
                  diameterRatio: 1.2,
                  physics: const FixedExtentScrollPhysics(),
                  childDelegate: ListWheelChildBuilderDelegate(
                      childCount: 24,
                      builder: (context, index) {
                        return ScrollField(
                          data: index,
                          category: 'hour',
                        );
                      }),
                  onSelectedItemChanged: (index) => {
                    setState(() {
                      hoursValue = index;
                      widget.timeController(hoursValue, minutesValue);
                    })
                  },
                ),
              ),
              const Text(
                ":",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 70,
                child: ListWheelScrollView.useDelegate(
                  itemExtent: 40,
                  controller: _controller,
                  perspective: 0.005,
                  diameterRatio: 1.2,
                  physics: const FixedExtentScrollPhysics(),
                  childDelegate: ListWheelChildBuilderDelegate(
                      childCount: 60,
                      builder: (context, index) {
                        return ScrollField(
                          data: index,
                          category: 'minutes',
                        );
                      }),
                  onSelectedItemChanged: (index) => {
                    setState(() {
                      minutesValue = index;
                      widget.timeController(hoursValue, minutesValue);
                    })
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
