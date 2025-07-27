import 'package:cab_sharing/src/services/date.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../decorations/colors.dart';
import '../functions/snackbar.dart';
import '../services/api.dart';
import '../services/user_store.dart';
import '../widgets/create_post_and_search/align_button.dart';
import '../widgets/create_post_and_search/date_calendar.dart';
import '../widgets/create_post_and_search/post_input_fields.dart';
import '../widgets/create_post_and_search/time_field.dart';
import '../widgets/create_post_and_search/to_from_fields.dart';
import './home.dart';
import 'search_screen.dart';

class PostSearchPage extends StatefulWidget {
  final String category;

  const PostSearchPage({super.key, required this.category});

  @override
  State<PostSearchPage> createState() => _PostSearchPageState();
}

class _PostSearchPageState extends State<PostSearchPage> {
  final TextEditingController phone = TextEditingController();
  final TextEditingController note = TextEditingController();
  final TextEditingController to = TextEditingController(text: "Airport");
  final TextEditingController from = TextEditingController(text: "Campus");
  final TextEditingController hours = TextEditingController(text: DateTime.now().hour.toString());
  final TextEditingController min = TextEditingController(text: DateTime.now().minute.toString());

  int get date => dateController?.day ?? 1;

  int get month => dateController?.month ?? 1;

  int get year => dateController?.year ?? 2024;

  DateTime get selectedDateTime =>
      DateTime(year, month, date, int.parse(hours.text), int.parse(min.text));
  DateTime? dateController;
  final noteFieldKey = GlobalKey<FormState>();
  final toFromKey = GlobalKey<FormState>();
  bool allowPostSearch = true;

  @override
  void initState() {
    super.initState();
    dateController = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> userData = context.read<CommonStore>().userData;
    var commonStore = context.read<CommonStore>();
    return Consumer<DateController>(
      builder: (_, provider, __) {
        dateController = provider.selectdatetime;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: kBackground,
            elevation: 0,
            leading: IconButton(
              onPressed: Navigator.of(context).pop,
              icon: const Icon(Icons.arrow_back_ios_outlined, color: Colors.white),
            ),
          ),
          backgroundColor: kBackground,
          body: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints viewportConstraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: viewportConstraints.maxHeight),
                    child: IntrinsicHeight(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const DateCalendar(),
                          (widget.category == "post")
                              ? TimeField(hourController: hours, minController: min)
                              : Container(),
                          ToFromField(to: to, from: from, formKey: toFromKey),
                          (widget.category == 'post')
                              ? PostFields(
                                phoneController: phone,
                                noteController: note,
                                formKey: noteFieldKey,
                              )
                              : Container(),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () async {
                              if (!allowPostSearch) return;
                              final nav = Navigator.of(context);
                              final messenger = ScaffoldMessenger.of(context);
                              setState(() {
                                allowPostSearch = false;
                              });
                              if (!toFromKey.currentState!.validate()) {
                                setState(() {
                                  allowPostSearch = true;
                                });
                                return;
                              }
                              bool res = false;
                              DateTime formatedDate = selectedDateTime.subtract(
                                Duration(
                                  hours: selectedDateTime.hour,
                                  minutes: selectedDateTime.minute,
                                  seconds: selectedDateTime.second,
                                  milliseconds: selectedDateTime.millisecond,
                                  microseconds: selectedDateTime.microsecond,
                                ),
                              );

                              Map<String, dynamic> data = {
                                'to': to.text,
                                'from': from.text,
                                'name': userData['name'],
                                'email': userData['email'],
                                'travelDateTime':
                                    widget.category == 'post'
                                        ? selectedDateTime.toIso8601String()
                                        : formatedDate.toIso8601String(),
                              };
                              if (widget.category != 'post') {
                                nav.push(
                                  MaterialPageRoute(
                                    builder:
                                        (context) => Provider.value(
                                          value: commonStore,
                                          child: SearchScreen(userData: data),
                                        ),
                                  ),
                                );
                                setState(() {
                                  allowPostSearch = true;
                                });
                                return;
                              }
                              try {
                                bool noteFilled = noteFieldKey.currentState!.validate();
                                if (!noteFilled) {
                                  setState(() {
                                    allowPostSearch = true;
                                  });
                                  return;
                                }
                                Map<String, dynamic> moreData = {'note': note.text, 'margin': 0};
                                if (phone.text.isNotEmpty) {
                                  moreData['phonenumber'] = phone.text;
                                }
                                res = await APIService().postTripData({...data, ...moreData});
                                if (res) {
                                  if (!mounted) return;
                                  messenger.showSnackBar(getSnackBar("Post Uploaded"));
                                  nav.pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const CabSharingScreen();
                                      },
                                    ),
                                  );
                                } else {
                                  if (!mounted) return;
                                  setState(() {
                                    allowPostSearch = true;
                                  });
                                  messenger.showSnackBar(getSnackBar("Some error occurred!"));
                                }
                              } catch (e) {
                                setState(() {
                                  allowPostSearch = true;
                                });
                                messenger.showSnackBar(getSnackBar("An error occurred. $e"));
                              }
                            },
                            child: AlignButton(
                              text: (widget.category == "post") ? "Create Post" : "Search",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
