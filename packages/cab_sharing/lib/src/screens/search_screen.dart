import 'package:flutter/material.dart';

import '../decorations/home_screen_style.dart';
import '../models/post_model.dart';
import '../services/api.dart';
import '../widgets/home/corner_case.dart';
import '../widgets/home/date_tile.dart';

class SearchScreen extends StatefulWidget {
  final Map<String, dynamic> userData;
  const SearchScreen({Key? key, required this.userData}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(27, 27, 29, 1),
          elevation: 0,
          title: Text('Search Results', style: kAppBarTextStyle,),
          leading: IconButton(
            onPressed: Navigator.of(context).pop,
            icon: const Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: const Color.fromRGBO(27, 27, 29, 1),
        body: FutureBuilder(
            future: APIService.getSearchResults(widget.userData),
            builder: (BuildContext context,
                AsyncSnapshot<Map<String, List<PostModel>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.data == null) {
                return const CornerCase(
                    message: 'Some error occurred, please try again');
              } else if (snapshot.data!.isEmpty) {
                return const CornerCase(message: 'No Results Found :/');
              } else {
                String date = snapshot.data!.keys.toList().first;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DateTile(posts: snapshot.data![date]!, date: date)
                  ],
                );
              }
            }),
      ),
    );
  }
}
