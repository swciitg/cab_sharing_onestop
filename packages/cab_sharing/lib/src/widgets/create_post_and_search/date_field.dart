import 'package:cab_sharing/src/widgets/create_post_and_search/scrollable.dart';
import 'package:flutter/material.dart';
import '../../decorations/post_and_search_style.dart';

class DateField extends StatefulWidget {
  var dateController;
  DateField({Key? key, required this.dateController}) : super(key: key);

  @override
  State<DateField> createState() => _DateFieldState();
}

class _DateFieldState extends State<DateField> {
  final FixedExtentScrollController _controller = FixedExtentScrollController();
  int date = 0;
  int month = 0;
  int year = 0;

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
                    controller: _controller,
                    perspective: 0.005,
                    diameterRatio: 1.2,
                    physics: const FixedExtentScrollPhysics(),
                    onSelectedItemChanged: (index) => {
                          setState(() {
                            date = index;
                            widget.dateController(date, month, year);
                          })
                        },
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
                    controller: _controller,
                    perspective: 0.005,
                    diameterRatio: 1.2,
                    physics: const FixedExtentScrollPhysics(),
                    onSelectedItemChanged: (index) => {
                          setState(() {
                            month = index;
                            widget.dateController(date, month, year);
                          })
                        },
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
                    controller: _controller,
                    perspective: 0.005,
                    diameterRatio: 1.2,
                    physics: const FixedExtentScrollPhysics(),
                    onSelectedItemChanged: (index) => {
                          setState(() {
                            year = index;
                            widget.dateController(date, month, year);
                          })
                        },
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
