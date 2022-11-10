import 'package:campus_ola/screens/create_post_and_search/post_and_search_main.dart';
import 'package:campus_ola/widgets/create_post_and_search/align_button.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late FixedExtentScrollController _controller;

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
                children: const [
                  MainPostSearch(),
                  AlignButton(text: "Search")
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}