import 'package:campus_ola/decorations/post_and_search_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/create_post_and_search/align_button.dart';
import '../widgets/scrollable/date_scroll.dart';
import '../widgets/scrollable/hours_scroll.dart';
import '../widgets/scrollable/minutes_scroll.dart';
import '../widgets/scrollable/month_scroll.dart';
import '../widgets/scrollable/year_scroll.dart';

class PostSearchPage extends StatefulWidget {
  final String category;
  const PostSearchPage({Key? key, required this.category}) : super(key: key);

  @override
  State<PostSearchPage> createState() => _PostSearchPageState();
}

class _PostSearchPageState extends State<PostSearchPage> {

  late FixedExtentScrollController _controller;
  int hoursValue = 0;
  int minutesValue = 00;
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
      backgroundColor: const Color.fromRGBO(27, 27, 29, 1),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints ) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                  constraints: BoxConstraints(
                      minHeight: viewportConstraints.maxHeight
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 40,),
                      Padding(
                      padding: const EdgeInsets.only(top: 15.0, left: 20.0),
                      child: Text(
                        "Date ",
                        style: titleStyle,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 15, right: 15, top: 8,),
                      decoration: commonBoxDecoration,
                      height: 70,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
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
                                childDelegate: ListWheelChildBuilderDelegate(
                                    childCount: 31,
                                    builder: (context, index) {
                                      return (DateScroll(
                                        date: index,
                                      ));
                                    }
                                )
                            ),
                          ),
                          Container(width: 1, color: Colors.white,),
                          SizedBox(
                            width: 35,
                            child: ListWheelScrollView.useDelegate(
                                itemExtent: 40,
                                controller: _controller,
                                perspective: 0.005,
                                diameterRatio: 1.2,
                                physics: const FixedExtentScrollPhysics(),
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
                          SizedBox(
                            width: 45,
                            child: ListWheelScrollView.useDelegate(
                                itemExtent: 40,
                                controller: _controller,
                                perspective: 0.005,
                                diameterRatio: 1.2,
                                physics: const FixedExtentScrollPhysics(),
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 28.0, left: 20.0),
                      child: Text(
                        "Time",
                        style: titleStyle,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 15, right: 15, top: 8,),
                      decoration: commonBoxDecoration,
                      height: 70,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
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
                                    return Hours(
                                      hours: index,
                                    );
                                  }),
                              onSelectedItemChanged: (index) =>
                              {
                                setState(() {
                                  marginValue = null;
                                  hoursValue = index;
                                  //print(minutesValue);
                                })
                              },
                            ),
                          ),
                          const Text(":", style: TextStyle(color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),),
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
                                    return Minutes(
                                      mins: index,
                                    );
                                  }),
                              onSelectedItemChanged: (index) =>
                              {
                                setState(() {
                                  marginValue = null;
                                  minutesValue = index;
                                  //print(minutesValue);
                                })
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 28.0, left: 20.0),
                      child: Text(
                        "Where",
                        style: titleStyle,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 15, right: 15, top: 8,),
                      decoration: commonBoxDecoration,
                      height: 70,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Builder(
                          builder: (context) {
                            return DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                dropdownColor: const Color.fromRGBO(39, 49, 65, 1),
                                isExpanded: true,
                                style: secondStyle,
                                icon: const Icon(
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 24.0, left: 20.0),
                      child: Text(
                        "Margin",
                        style: titleStyle,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 15, right: 15, top: 8,),
                      decoration: commonBoxDecoration,
                      height: 70,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Builder(
                          builder: (context) {
                            return DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                dropdownColor: const Color.fromRGBO(39, 49, 65, 1),
                                isExpanded: true,
                                style: secondStyle,
                                icon: const Icon(
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
                    ),
                      (widget.category == "post")
                      ? Padding(
                        padding: const EdgeInsets.only(top: 24.0, left: 20.0),
                        child: Text(
                          "Phone Number",
                          style: titleStyle,
                        ),
                      )
                      : Container(),
                      (widget.category == "post") ? Container(
                        margin: const EdgeInsets.only(left: 15, right: 15, top: 8,),
                        decoration: commonBoxDecoration,
                        height: 70,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          maxLength: 10,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          style: titleStyle,
                        ),
                      )
                      : Container(),
                      (widget.category == "post")
                      ? Padding(
                        padding: const EdgeInsets.only(top: 24.0, left: 20.0),
                        child: Text(
                          "Note if any",
                          style: titleStyle,
                        ),
                      )
                      : Container(),
                      (widget.category == "post")
                      ? Container(
                        margin: const EdgeInsets.only(left: 15, right: 15, top: 8,),
                        decoration: commonBoxDecoration,
                        height: 70,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: TextFormField(
                          style: titleStyle,
                        ),
                      )
                      : Container(),
                    SizedBox(height: 20,),
                    AlignButton(
                      text: (widget.category == "post") ? "Create Post" : "Search"
                    )
              ],
            ),
            ),
            );
          }
      ),
    );
  }
}

