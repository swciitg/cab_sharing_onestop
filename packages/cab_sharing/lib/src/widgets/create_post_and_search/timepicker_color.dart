import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TimePickerColor extends StatefulWidget {
  final Widget? childWidget;
  const TimePickerColor({Key? key,  required this.childWidget}) : super(key: key);

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
          dayPeriodColor: MaterialStateColor.resolveWith((states) =>
              states.contains(MaterialState.selected)
                  ? Color.fromRGBO(91, 146, 227, 1)
                  : const Color(0xff273141)),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          dayPeriodTextColor: MaterialStateColor.resolveWith((states) =>
              states.contains(MaterialState.selected)
                  ? Colors.white
                  : Colors.blueGrey.shade600),
          dayPeriodShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            side: BorderSide(width: 4),
          ),
          hourMinuteColor: MaterialStateColor.resolveWith((states) =>
              states.contains(MaterialState.selected)
                  ? Color.fromRGBO(91, 146, 227, 1)
                  : const Color(0xff2B3E5C)),
          hourMinuteTextColor: MaterialStateColor.resolveWith((states) =>
              states.contains(MaterialState.selected)
                  ? Colors.white
                  : Colors.white),
          dialHandColor: Color.fromRGBO(118, 172, 255, 1),
          dialBackgroundColor: const Color(0xff2B3E5C),
          hourMinuteTextStyle: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          dayPeriodTextStyle:
              GoogleFonts.montserrat(fontSize: 12, fontWeight: FontWeight.bold),
          helpTextStyle: GoogleFonts.montserrat(
              fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
          dialTextColor: MaterialStateColor.resolveWith((states) =>
              states.contains(MaterialState.selected)
                  ? Colors.black
                  : Colors.white),
          entryModeIconColor: Colors.blueGrey.shade600,
        ),
        textTheme: TextTheme(
          caption: GoogleFonts.montserrat(), // days
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              backgroundColor: const Color(0xff273141), // button
              foregroundColor: Color.fromRGBO(118, 172, 255, 1),
              elevation: 0,
              textStyle: GoogleFonts.montserrat()),
        ),
      ),
      child: MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          // If you want 24-Hour format, just change alwaysUse24HourFormat to true or remove all the builder argument
          child: widget.childWidget!),
    );
    ;
  }
}
