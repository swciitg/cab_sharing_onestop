import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../decorations/chat_screen_style.dart';
import '../../models/post_model.dart';
import '../../models/reply_model.dart';
import '../../services/user_store.dart';

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
    // print("Reply = ${widget.reply.message} and sent by ${widget.reply.name}");
    return widget.reply.email != context.read<CommonStore>().userEmail;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
      isOthersReply ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18,),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.6,
            margin: const EdgeInsets.all(4),
            padding: const EdgeInsets.only(
              left: 10,
              right: 8,
              top: 8,
              bottom: 8,
            ),
            decoration: isOthersReply ? receivedBoxDecoration : sentBoxDecoration,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isOthersReply
                    ? Text(
                  widget.reply.name,
                  style: nameStyle,
                )
                    : const Text(
                  "You",
                  style: nameStyle,
                ),
                Text(
                  widget.reply.message,
                  style: chatTextStyle,
                ),
                Row(
                  children: [
                    const Expanded(child: SizedBox()),
                    Expanded(
                        flex: 2,
                        child: Text(
                          widget.reply.email,
                          style: chatBoxEmailStyle,
                          textAlign: TextAlign.end,
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}