import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../cab_sharing.dart';
import '../decorations/colors.dart';
import '../functions/helpers.dart';
import '../functions/snackbar.dart';
import '../services/api.dart';
import '../services/user_store.dart';
import '../widgets/create_post_and_search/align_button.dart';
import '../widgets/create_post_and_search/date_field.dart';
import '../widgets/create_post_and_search/post_input_fields.dart';
import '../widgets/create_post_and_search/time_field.dart';
import '../widgets/create_post_and_search/to_from_fields.dart';
import 'search_screen.dart';

class PostSearchPage extends StatefulWidget {
  final String category;
  const PostSearchPage({Key? key, required this.category}) : super(key: key);

  @override
  State<PostSearchPage> createState() => _PostSearchPageState();
}

class _PostSearchPageState extends State<PostSearchPage> {
  final TextEditingController phone = TextEditingController();
  final TextEditingController note = TextEditingController();
  final TextEditingController to = TextEditingController(text: "Airport");
  final TextEditingController from = TextEditingController(text: "Campus");
  final FixedExtentScrollController date = FixedExtentScrollController();
  final FixedExtentScrollController month = FixedExtentScrollController();
  final FixedExtentScrollController year = FixedExtentScrollController();
  final FixedExtentScrollController hours = FixedExtentScrollController();
  final FixedExtentScrollController min = FixedExtentScrollController();
  final noteFieldKey = GlobalKey<FormState>();
  bool allowPostSearch = true;
  @override
  Widget build(BuildContext context) {
    Map<String, String> userData = context.read<CommonStore>().userData;
    var commonStore = context.read<CommonStore>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackground,
        elevation: 0,
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: const Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: kBackground,
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(minHeight: viewportConstraints.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DateField(
                    year: year,
                    date: date,
                    month: month,
                  ),
                  (widget.category == "post")
                      ? TimeField(hour: hours, min: min)
                      : Container(),
                  ToFromField(to: to, from: from),
                  (widget.category == 'post')
                      ? PostFields(
                          phoneController: phone,
                          noteController: note,
                          formKey: noteFieldKey,
                        )
                      : Container(),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: allowPostSearch
                        ? () async {
                            setState(() {
                              allowPostSearch = false;
                            });
                            if (to.text == from.text) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  getSnackBar("To and From can't be same"));
                              setState(() {
                                allowPostSearch = true;
                              });
                              return;
                            }
                            var res = {};
                            Map<String, dynamic> data = {
                              'to': to.text,
                              'from': from.text,
                              'name': userData['name'],
                              'email': userData['email'],
                              'security-key': userData['security-key'],
                              'travelDateTime': timeHelper({
                                'date': date.selectedItem,
                                'month': month.selectedItem,
                                'year': year.selectedItem,
                                'hour':
                                    hours.hasClients ? hours.selectedItem : 0,
                                'min': min.hasClients ? min.selectedItem : 0,
                              })
                            };
                            try {
                              if (widget.category == 'post') {
                                bool noteFilled =
                                    noteFieldKey.currentState!.validate();
                                Map<String, dynamic> moreData = {
                                  'note': note.text,
                                  'margin': 0,
                                };
                                if (phone.text.isNotEmpty) {
                                  moreData['phonenumber'] = phone.text;
                                }
                                if (noteFilled) {
                                  res = await APIService.postTripData(
                                      {...data, ...moreData});
                                  if (res['success']) {
                                    if (!mounted) return;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        getSnackBar("Post Uploaded"));
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CabSharingScreen(
                                                userData: userData,
                                              )),
                                    );
                                  } else {
                                    if (!mounted) return;
                                    setState(() {
                                      allowPostSearch = true;
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        getSnackBar(
                                            "An error occurred. Check your connection and try again"));
                                  }
                                } else {
                                  setState(() {
                                    allowPostSearch = true;
                                  });
                                }
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Provider.value(
                                            value: commonStore,
                                            child: SearchScreen(
                                              userData: data,
                                            ),
                                          )),
                                );
                                setState(() {
                                  allowPostSearch = true;
                                });
                              }
                            } catch (e) {
                              setState(() {
                                allowPostSearch = true;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                  getSnackBar("An error occurred."));
                            }
                          }
                        : () {},
                    child: AlignButton(
                        text: (widget.category == "post")
                            ? "Create Post"
                            : "Search"),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
