import 'package:campus_ola/decorations/post_and_search_style.dart';
import 'package:campus_ola/screens/create_post_and_search/post_and_search_main.dart';
import 'package:campus_ola/widgets/create_post_and_search/align_button.dart';
import 'package:flutter/material.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({Key? key}) : super(key: key);
  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
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
            builder:
            (BuildContext context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 45.0, left: 15.0,),
                        child: Text(
                          "Create a Post :  ",
                          style: titleStyle,
                        ),
                      ),
                      const MainPostSearch(),
                      Padding(
                        padding: const EdgeInsets.only(top: 24.0, left: 20.0),
                        child: Text(
                          "Note if any",
                          style: titleStyle,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 15, right: 15, top: 8,),
                        decoration: commonBoxDecoration,
                        height: 70,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: TextFormField(
                          style: titleStyle,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0, left: 30.0),
                        child: Text(
                          "Share your call details.",
                          style: secondStyle,
                        ),
                      ),
                      const AlignButton(text: "Create Post")
                    ],
                  ),
                ),
              );
            }
        ),
    );
  }
}