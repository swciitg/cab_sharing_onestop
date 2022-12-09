import 'package:cab_sharing/src/widgets/home/post_widget.dart';
import 'package:flutter/material.dart';
import '../../decorations/home_screen_style.dart';
import '../../models/post_model.dart';

class DateTile extends StatelessWidget {
  final String date;
  final List<PostModel> posts;
  final BuildContext contexto;
  const DateTile(
      {Key? key,
      required this.posts,
      required this.date,
      required this.contexto})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 14.0, left: 15.0, bottom: 10.0),
          child: Text(
            date,
            style: kDateTextStyle,
          ),
        ),
        for (var post in posts)
          PostWidget(post: post, context: contexto, colorCategory: 'post'),
      ],
    );
  }
}
