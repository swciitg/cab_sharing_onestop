import 'package:flutter/material.dart';

import '../../decorations/chat_screen_style.dart';
import '../../models/post_model.dart';
import '../../models/reply_model.dart';

class ReplyWidget extends StatefulWidget {
  final ReplyModel reply;
  final PostModel post;
  const ReplyWidget({
    Key? key,
    required this.reply,
    required BuildContext context,
    required this.post,
  }) : super(key: key);

  @override
  State<ReplyWidget> createState() => _ReplyWidgetState();
}

class _ReplyWidgetState extends State<ReplyWidget> {
  
  bool get isOthersReply {
    return widget.reply.name != widget.post.name;
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isOthersReply
          ? MainAxisAlignment.start
          : MainAxisAlignment.end,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.6,
          margin: const EdgeInsets.all(4),
          padding: const EdgeInsets.only(
            left: 10,
            right: 8,
            top: 8,
            bottom: 8,
          ),
          decoration: isOthersReply
              ? receivedBoxDecoration
              : sentBoxDecoration,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isOthersReply
                  ? Text(
                      widget.reply.name,
                      style: nameStyle,
                    )
                  : Text(
                      "You",
                      style: nameStyle,
                    ),
              Text(
                widget.reply.message,
                style: chatTextStyle,
              ),
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
