import 'package:flutter/material.dart';


class TimePickerColor extends StatefulWidget {
  final Widget? childWidget;
  const TimePickerColor({super.key,  required this.childWidget});

  @override
  State<TimePickerColor> createState() => _TimePickerColorState();
}

class _TimePickerColorState extends State<TimePickerColor> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        timePickerTheme: TimePickerThemeData(
          backgroundColor: const Color(0xff273141),
          dayPeriodBorderSide: const BorderSide(
              color: Color.fromRGBO(91, 146, 227, 1), width: 2),
          dayPeriodColor: WidgetStateColor.resolveWith((states) =>
              states.contains(WidgetState.selected)
                  ? const Color.fromRGBO(91, 146, 227, 1)
                  : const Color(0xff273141)),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          dayPeriodTextColor: WidgetStateColor.resolveWith((states) =>
              states.contains(WidgetState.selected)
                  ? Colors.white
                  : Colors.blueGrey.shade600),
          dayPeriodShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            side: BorderSide(width: 4),
          ),
          hourMinuteColor: WidgetStateColor.resolveWith((states) =>
              states.contains(WidgetState.selected)
                  ? const Color.fromRGBO(91, 146, 227, 1)
                  : const Color(0xff2B3E5C)),
          hourMinuteTextColor: WidgetStateColor.resolveWith((states) =>
              states.contains(WidgetState.selected)
                  ? Colors.white
                  : Colors.white),
          dialHandColor: const Color.fromRGBO(118, 172, 255, 1),
          dialBackgroundColor: const Color(0xff2B3E5C),
          hourMinuteTextStyle: const TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          dayPeriodTextStyle:
              const TextStyle(fontFamily: 'Montserrat',fontSize: 12, fontWeight: FontWeight.bold),
          helpTextStyle: const TextStyle(
            fontFamily: 'Montserrat',
              fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
          dialTextColor: WidgetStateColor.resolveWith((states) =>
              states.contains(WidgetState.selected)
                  ? Colors.black
                  : Colors.white),
          entryModeIconColor: Colors.blueGrey.shade600,
        ),
        textTheme: const TextTheme(
          bodySmall: TextStyle(fontFamily: 'Montserrat',), // days
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              backgroundColor: const Color(0xff273141), // button
              foregroundColor: const Color.fromRGBO(118, 172, 255, 1),
              elevation: 0,
              textStyle: const TextStyle(fontFamily: 'Montserrat',)),
        ),
      ),
      child: MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          // If you want 24-Hour format, just change alwaysUse24HourFormat to true or remove all the builder argument
          child: widget.childWidget!),
    );
  }
}
