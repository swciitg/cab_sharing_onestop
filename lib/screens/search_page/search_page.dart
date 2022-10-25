import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../decorations/sign_in_style.dart';
import '../../widgets/scrollable/date_scroll.dart';
import '../../widgets/scrollable/hours_scroll.dart';
import '../../widgets/scrollable/minutes_scroll.dart';
import '../../widgets/scrollable/month_scroll.dart';
import '../../widgets/scrollable/year_scroll.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late FixedExtentScrollController _controller;
  int hoursValue = 0 ;
  int minutesValue = 59;
  String? marginValue ;
  String? whereValue ;
  List<String> myMonths = [ 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = FixedExtentScrollController();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color.fromRGBO(27, 27, 29, 1),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints ) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight
              ),
              child: Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 50.0, left: 20.0),
                      child: Text(
                        "Date",
                        style: GoogleFonts.montserrat(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                          color: const Color(0xFFBDC7DC),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15, right: 15, top: 8,),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 35,
                            child: ListWheelScrollView.useDelegate(
                                itemExtent: 40,
                                controller: _controller,
                                perspective: 0.005,
                                diameterRatio: 1.2,
                                physics: FixedExtentScrollPhysics(),
                                childDelegate: ListWheelChildBuilderDelegate(
                                    childCount: 31,
                                    builder: (context, index) {
                                      return (DateScroll(
                                        date: index,
                                      ));
                                    }
                                )),
                          ),
                          Container(width: 1, color: Colors.white,),
                          Container(
                            width: 35,
                            child: ListWheelScrollView.useDelegate(
                                itemExtent: 40,
                                controller: _controller,
                                perspective: 0.005,
                                diameterRatio: 1.2,
                                physics: FixedExtentScrollPhysics(),
                                childDelegate: ListWheelChildBuilderDelegate(
                                    childCount: 12,
                                    builder: (context, index) {
                                      return (MonthScroll(
                                        month: myMonths[index.toInt()],
                                      ));
                                    }
                                )),
                          ),
                          Container(width: 1, color: Colors.white,),
                          Container(
                            width: 45,
                            child: ListWheelScrollView.useDelegate(
                                itemExtent: 40,
                                controller: _controller,
                                perspective: 0.005,
                                diameterRatio: 1.2,
                                physics: FixedExtentScrollPhysics(),
                                childDelegate: ListWheelChildBuilderDelegate(
                                    childCount: 5,
                                    builder: (context, index) {
                                      return (YearScroll(
                                        year: index,
                                      ));
                                    }
                                )),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(39, 49, 65, 1),
                          borderRadius: BorderRadius.all(
                              Radius.circular(21)
                          )
                      ),
                      height: 70,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 28.0, left: 20.0),
                      child: Text(
                        "Time",
                        style: GoogleFonts.montserrat(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                          color: const Color(0xFFBDC7DC),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15, right: 15, top: 8,),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 70,
                            child: ListWheelScrollView.useDelegate(
                              itemExtent: 40,
                              controller: _controller,
                              perspective: 0.005,
                              diameterRatio: 1.2,
                              physics: FixedExtentScrollPhysics(),
                              childDelegate: ListWheelChildBuilderDelegate(
                                  childCount: 24,
                                  builder: (context, index) {
                                    return Hours(
                                      hours: index,
                                    );
                                  }),
                              onSelectedItemChanged: (index) =>
                              {
                                setState(() {
                                  marginValue = null;
                                  hoursValue = index;
                                  print(hoursValue);
                                })
                              },
                            ),
                          ),
                          Text(":", style: TextStyle(color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),),
                          Container(
                            width: 70,
                            child: ListWheelScrollView.useDelegate(
                              itemExtent: 40,
                              controller: _controller,
                              perspective: 0.005,
                              diameterRatio: 1.2,
                              physics: FixedExtentScrollPhysics(),
                              childDelegate: ListWheelChildBuilderDelegate(
                                  childCount: 60,
                                  builder: (context, index) {
                                    return Minutes(
                                      mins: index,
                                    );
                                  }),
                              onSelectedItemChanged: (index) =>
                              {
                                setState(() {
                                  marginValue = null;
                                  minutesValue = index;
                                  print(minutesValue);
                                })
                              },
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(39, 49, 65, 1),
                          borderRadius: BorderRadius.all(
                              Radius.circular(21)
                          )
                      ),
                      height: 70,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 28.0, left: 20.0),
                      child: Text(
                        "Where",
                        style: GoogleFonts.montserrat(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                          color: const Color(0xFFBDC7DC),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15, right: 15, top: 8,),
                      child: Builder(
                          builder: (context) {
                            return DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                dropdownColor: Color.fromRGBO(39, 49, 65, 1),
                                isExpanded: true,
                                style: GoogleFonts.montserrat(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.5,
                                  color: Colors.white,
                                ),
                                icon: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                value: whereValue,
                                items: <String>["Airport", "Railway Station"]
                                    .map((String val) {
                                  return DropdownMenuItem<String>(
                                    value: val,
                                    child: Text(val),
                                  );
                                }).toList(),
                                onChanged: (String? val) {
                                  whereValue = val!;
                                  setState(() {});
                                },
                              ),
                            );
                          }
                      ),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(39, 49, 65, 1),
                          borderRadius: BorderRadius.all(
                              Radius.circular(21)
                          )
                      ),
                      height: 70,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 28.0, left: 20.0),
                      child: Text(
                        "Margin",
                        style: GoogleFonts.montserrat(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                          color: const Color(0xFFBDC7DC),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15, right: 15, top: 8,),
                      child: Builder(
                          builder: (context) {
                            return DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                dropdownColor: Color.fromRGBO(39, 49, 65, 1),
                                isExpanded: true,
                                style: GoogleFonts.montserrat(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.5,
                                  color: Colors.white,
                                ),
                                icon: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                value: marginValue,
                                items: <String>[
                                  "${hoursValue.toString()}:${minutesValue
                                      .toString()} as it is",
                                  "${hoursValue.toString()}:${minutesValue
                                      .toString()} or 1 hr early",
                                  "${hoursValue.toString()}:${minutesValue
                                      .toString()} or 2 hrs early"
                                ].map((String val) {
                                  return DropdownMenuItem<String>(
                                    value: val,
                                    child: Text(val),
                                  );
                                }).toList(),
                                onChanged: (String? val) {
                                  marginValue = val!;
                                  setState(() {});
                                },
                              ),
                            );
                          }
                      ),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(39, 49, 65, 1),
                          borderRadius: BorderRadius.all(
                              Radius.circular(21)
                          )
                      ),
                      height: 70,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                    ),
                    Container(
                      child: Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: Container(
                          margin: EdgeInsets.only(
                              left: 15, right: 15, top: 60),
                          height: 55,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          decoration: kSignInContainerDecoration,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 17),
                          child: Text(
                            "Search",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}