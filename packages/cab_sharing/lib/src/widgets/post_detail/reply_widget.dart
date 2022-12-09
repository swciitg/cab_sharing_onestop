import 'package:cab_sharing/src/decorations/chat_screen_style.dart';
import 'package:flutter/material.dart';
import '../../models/post_model.dart';
import '../../models/reply_model.dart';

class ReplyWidget extends StatefulWidget {
  final Reply reply;
  final PostModel post;
  const ReplyWidget({Key? key, required this.reply, required BuildContext context, required this.post,}) : super(key: key);

  @override
  State<ReplyWidget> createState() => _ReplyWidgetState();
}

class _ReplyWidgetState extends State<ReplyWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
      widget.reply.email == widget.post.email
        ? MainAxisAlignment.start
        : MainAxisAlignment.end,
      children: [
        Container(
          width: MediaQuery.of(context).size.width*0.6,
          margin: const EdgeInsets.all(4),
          padding: const EdgeInsets.only(
            left: 10,
            right: 8,
            top: 8,
            bottom: 8,
          ),
          decoration:
          widget.reply.email == widget.post.email
              ? receivedBoxDecoration
              : sentBoxDecoration,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.reply.email == widget.post.email
              ? Text(widget.post.name, style: nameStyle,)
              : Text("You", style: nameStyle,),
              Text(widget.reply.description, style: chatTextStyle,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(widget.reply.time, style: chatTextStyle),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
