
import 'package:cab_sharing/decorations/post_widget_style.dart';
import 'package:cab_sharing/models/post_model.dart';
import 'package:cab_sharing/screens/post_detail_page.dart';
import 'package:flutter/material.dart';

class PostWidget extends StatefulWidget {
  final Post post;
  final BuildContext context;
  const PostWidget({Key? key, required this.post, required this.context}) : super(key: key);

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          widget.context,
          MaterialPageRoute(builder: (context) {
            return PostDetailPage(
                post: widget.post);
          }),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 4.0,
        ),
        child: Container(
          height: 96.0,
          width: double.infinity,
          decoration: kRowContainerDecoration,
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Text(
                          widget.post.name,
                          style: kPostNameTextStyle,
                        ),
                      ),
                      Text(
                        widget.post.email,
                        style: kPostEmailTextStyle,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          widget.post.getNote(),
                          style: kPostGetNoteTextStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 105.0,
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 16.0,
                          bottom: 4.0,
                        ),
                        child: Text(
                          widget.post.time,
                          style: kPostTimeTextStyle,
                        ),
                      ),
                      Image.asset(
                        widget.post.mode == Post.airway
                            ? "assets/airway.png"
                            : "assets/railway.png",
                        width: 16.0,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

