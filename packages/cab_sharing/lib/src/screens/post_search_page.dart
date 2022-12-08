import 'package:cab_sharing/src/services/api.dart';
import 'package:cab_sharing/src/widgets/create_post_and_search/date_field.dart';
import 'package:cab_sharing/src/widgets/create_post_and_search/post_input_fields.dart';
import 'package:cab_sharing/src/widgets/create_post_and_search/time_field.dart';
import 'package:cab_sharing/src/widgets/create_post_and_search/to_from_fields.dart';
import 'package:flutter/material.dart';
import '../decorations/post_and_search_style.dart';
import '../functions/helpers.dart';
import '../widgets/create_post_and_search/align_button.dart';

class PostSearchPage extends StatefulWidget {
  final String category;
  final Map<String, String> userData;
  const PostSearchPage(
      {Key? key, required this.category, required this.userData})
      : super(key: key);

  @override
  State<PostSearchPage> createState() => _PostSearchPageState();
}

class _PostSearchPageState extends State<PostSearchPage> {
  final TextEditingController phone = TextEditingController();
  final TextEditingController note = TextEditingController();
  int hoursValue = 0;
  int minutesValue = 00;
  int date = 0;
  int month = 0;
  int year = 0;
  String? marginValue;
  String? fromValue;
  String? toValue;

  toFromControl(String? to, String? from) {
    setState(() {
      toValue = to;
      fromValue = from;
    });
  }

  dateControl(int dateValue, int monthValue, int yearValue) {
    setState(() {
      date = dateValue;
      month = monthValue;
      year = yearValue;
    });
  }

  timeControl(int hour, int min) {
    setState(() {
      hoursValue = hour;
      minutesValue = min;
      marginValue = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(27, 27, 29, 1),
        elevation: 0,
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: const Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: const Color.fromRGBO(27, 27, 29, 1),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(minHeight: viewportConstraints.maxHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DateField(dateController: dateControl),
                (widget.category == "post")
                    ? TimeField(timeController: timeControl)
                    : Container(),
                ToFromField(toFromController: toFromControl),
                Padding(
                  padding: const EdgeInsets.only(top: 24.0, left: 20.0),
                  child: Text(
                    "Margin",
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Builder(builder: (context) {
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
                          (hoursValue > 9)
                              ? (minutesValue > 9)
                                  ? "${hoursValue.toString()} : ${minutesValue.toString()} as it is"
                                  : "${hoursValue.toString()} : 0${minutesValue.toString()} as it is"
                              : (minutesValue > 9)
                                  ? "0${hoursValue.toString()} : ${minutesValue.toString()} as it is"
                                  : "0${hoursValue.toString()} : 0${minutesValue.toString()} as it is",
                          (hoursValue > 9)
                              ? (minutesValue > 9)
                                  ? "${hoursValue.toString()} : ${minutesValue.toString()} or 1 hour early"
                                  : "${hoursValue.toString()} : 0${minutesValue.toString()} or 1 hour early"
                              : (minutesValue > 9)
                                  ? "0${hoursValue.toString()} : ${minutesValue.toString()} or 1 hour early"
                                  : "0${hoursValue.toString()} : 0${minutesValue.toString()} or 1 hour early",
                          (hoursValue > 9)
                              ? (minutesValue > 9)
                                  ? "${hoursValue.toString()} : ${minutesValue.toString()} or 2 hours early"
                                  : "${hoursValue.toString()} : 0${minutesValue.toString()} or 2 hours early"
                              : (minutesValue > 9)
                                  ? "0${hoursValue.toString()} : ${minutesValue.toString()} or 2 hours early"
                                  : "0${hoursValue.toString()} : 0${minutesValue.toString()} or 2 hours early",
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
                  }),
                ),
                (widget.category == 'post')
                    ? PostFields(phoneController: phone, noteController: note)
                    : Container(),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () async {
                    var res = {};
                    Map<String, dynamic> data = {
                      'to': toValue,
                      'from': fromValue,
                      'security-key': widget.userData['security-key'],
                      'travelDateTime': timeHelper({
                        'date': date,
                        'month': month,
                        'year': year,
                        'hour': hoursValue,
                        'min': minutesValue,
                      })
                    };
                    try {
                      if (widget.category == 'post') {
                        Map<String, dynamic> moreData = {
                          'name': widget.userData['name'],
                          'email': widget.userData['email'],
                          'note': note.text,
                          'margin': marginHelper(marginValue),
                        };
                        if(phone.text.isNotEmpty)
                          {
                            moreData['phonenumber'] = phone.text;
                          }
                        res = await APIService.postTripData(
                            {...data, ...moreData});
                      } else {
                        res = await APIService.getSearchResults(data);
                      }
                    } catch (e) {
                      print(e);
                    }

                    print(res);
                  },
                  child: AlignButton(
                      text: (widget.category == "post")
                          ? "Create Post"
                          : "Search"),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
