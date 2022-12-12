import 'package:cab_sharing/src/decorations/colors.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../decorations/home_screen_style.dart';
import '../models/post_model.dart';
import '../services/api.dart';
import '../services/user_store.dart';
import '../widgets/ui/corner_case.dart';
import '../widgets/home/date_tile.dart';
import '../widgets/home/post_widget.dart';
import '../widgets/ui/post_shimer.dart';
import 'post_search_page.dart';

class CabSharingScreen extends StatefulWidget {
  final Map<String, String> userData;
  const CabSharingScreen({Key? key, required this.userData}) : super(key: key);

  @override
  State<CabSharingScreen> createState() => _CabSharingScreenState();
}

class _CabSharingScreenState extends State<CabSharingScreen> {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => CommonStore(userData: widget.userData),
      builder: (context, _) {
        var commonStore = context.read<CommonStore>();
        return Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
              onTap: () {
                Navigator.popUntil(context, ModalRoute.withName("/home2"));
              },
              child: const Icon(
                Icons.arrow_back_sharp,
                color: Colors.white,
              ),
            ),
            title: Text(
              "Campus Ola",
              style: kAppBarTextStyle,
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Provider.value(
                                  value: commonStore,
                                  child: const PostSearchPage(
                                    category: "search",
                                  ),
                                )),
                      );
                    },
                    child: const Icon(
                      Icons.search,
                      color: Colors.white,
                    )),
              )
            ],
            backgroundColor: kCommonBoxBackground.withOpacity(0.64),
          ),
          backgroundColor: kBackground,
          body: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Column(
              children: [
                FutureBuilder(
                    future: APIService.getMyPosts(widget.userData),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<PostModel>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const LoadingScreen();
                      }
                      if (snapshot.data == null || snapshot.data!.isEmpty) {
                        return Container();
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 18.0, left: 15.0, bottom: 10.0),
                            child: Text(
                              "My Post",
                              style: kTodayTextStyle,
                            ),
                          ),
                          for (var post in snapshot.data!)
                            PostWidget(
                              colorCategory: 'mypost',
                              post: post,
                              deleteCallback: () => setState(() {}),
                            )
                        ],
                      );
                    }),
                FutureBuilder(
                  future: APIService.getAllPosts(widget.userData),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Map<String, List<PostModel>>>>
                          snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const LoadingScreen();
                    }
                    if (snapshot.data == null) {
                      return const CornerCase(
                          message: 'Some error occured, please try again');
                    }

                    if (snapshot.data!.isEmpty) {
                      return const CornerCase(message: 'No Posts Available');
                    }

                    return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          String date =
                              snapshot.data![index].keys.toList().first;
                          return DateTile(
                            posts: snapshot.data![index][date]!,
                            date: date,
                          );
                        });
                  },
                ),
              ],
            ),
          ),
          floatingActionButton: (widget.userData['email'] != CommonStore.kGuestEmail) ? FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Provider.value(
                      value: commonStore,
                      child: const PostSearchPage(
                        category: "post",
                      ),
                    )),
              );
            },
            label: const Text(
              "+",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                  fontWeight: FontWeight.w300),
            ),
            backgroundColor: kFloatingButtonColor,
          ): Container(),
        );
      },
    );
  }
}
