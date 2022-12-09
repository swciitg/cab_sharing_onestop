import 'package:cab_sharing/src/widgets/home/post_widget.dart';
import 'package:flutter/material.dart';
import '../../decorations/home_screen_style.dart';
import '../../models/post_model.dart';

class DateTile extends StatefulWidget {
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
  State<DateTile> createState() => _DateTileState();
}

class _DateTileState extends State<DateTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 14.0, left: 15.0, bottom: 10.0),
          child: Text(
            widget.date,
            style: kDateTextStyle,
          ),
        ),
        for (var post in widget.posts)
          PostWidget(post: post, context: widget.contexto, colorCategory: 'post', deleteCallback: () => setState((){}),),
      ],
    );
  }
}
