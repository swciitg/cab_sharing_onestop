import 'package:cab_sharing/src/services/api.dart';
import 'package:cab_sharing/src/widgets/home/date_tile.dart';
import 'package:cab_sharing/src/widgets/home/post_widget.dart';
import 'package:flutter/material.dart';
import '../models/posto_model.dart';
import '../screens/post_search_page.dart';
import '../decorations/home_screen_style.dart';

class CabSharingScreen extends StatefulWidget {
  final Map<String, String> userData;
  const CabSharingScreen({Key? key, required this.userData}) : super(key: key);

  @override
  State<CabSharingScreen> createState() => _CabSharingScreenState();
}

class _CabSharingScreenState extends State<CabSharingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
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
                        builder: (context) => PostSearchPage(
                              category: "search",
                              userData: widget.userData,
                            )),
                  );
                },
                child: const Icon(
                  Icons.search,
                  color: Colors.white,
                )),
          )
        ],
        backgroundColor: const Color.fromRGBO(39, 49, 65, 0.64),
      ),
      backgroundColor: const Color(0xFF1B1B1D),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            FutureBuilder(
                future: APIService.getMyPosts(widget.userData),
                builder: (BuildContext context,
                    AsyncSnapshot<List<PostModel>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
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
                          context: context,
                          colorCategory: 'mypost',
                          post: post,
                          userData: widget.userData,
                        )
                    ],
                  );
                }),
            FutureBuilder(
              future: APIService.getAllPosts(widget.userData),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Map<String, List<PostModel>>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.data == null) {
                  return const Center(
                    child: Text(
                      'No data found',
                    ),
                  );
                }

                if (snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text(
                      'No data found',
                    ),
                  );
                }

                return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      String date = snapshot.data![index].keys.toList().first;
                      return DateTile(
                        posts: snapshot.data![index][date]!,
                        date: date,
                        contexto: context,
                      );
                    });
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PostSearchPage(
                      category: "post",
                      userData: widget.userData,
                    )),
          );
        },
        label: const Text(
          "+",
          style: TextStyle(
              color: Colors.black, fontSize: 40, fontWeight: FontWeight.w300),
        ),
        backgroundColor: const Color(0xFF76ACFF),
      ),
    );
  }
}
