import 'package:cab_sharing/src/decorations/post_widget_style.dart';
import 'package:cab_sharing/src/models/reply_model.dart';
import 'package:cab_sharing/src/services/api.dart';
import 'package:cab_sharing/src/widgets/post_detail/reply_widget.dart';
import 'package:flutter/material.dart';

import '../models/post_model.dart';

class ChatScreen extends StatefulWidget {
  final PostModel post;
  const ChatScreen({Key? key, required this.post}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    List<ReplyModel> replies = [
      ReplyModel(
          replyid: 'abc',
          name: widget.post.email,
          message: 'loreum ipsum dolor set amit',
          time: '10:30'),
      ReplyModel(
          replyid: 'abc',
          name: widget.post.email,
          message: 'loreum ipsum dolor set amit',
          time: '10:30'),
      ReplyModel(
          replyid: 'xyz',
          name: 'xyz@gmail.com',
          message: 'loreum ipsum dolor set amit',
          time: '10:30'),
      ReplyModel(
          replyid: 'abc',
          name: widget.post.email,
          message: 'loreum ipsum dolor set amit',
          time: '10:30'),
      ReplyModel(
          replyid: 'xyz',
          name: 'xyz@gmail.com',
          message: 'loreum ipsum dolor set amit',
          time: '10:30'),
    ];

    // return FutureBuilder<List<ReplyModel>>(
    //   future: APIService.getPostReplies(widget.post.chatId),
    //   builder: (context, snapshot) {
    //     print("CHAT SNAP = $snapshot");
    //     if (snapshot.hasData) {
    //       List<ReplyModel> replies = snapshot.data!;
    //       return Expanded(child: ListView.builder(
    //         itemCount: replies.length,
    //         itemBuilder: (context, index) {
    //           final item = replies[index];
    //           return ReplyWidget(
    //               reply: item, context: context, post: widget.post);
    //         },
    //       ));
    //     } else if (snapshot.hasError) {
    //       return Expanded(
    //         child: Center(
    //           child: Text(
    //             snapshot.error.toString().replaceAll("Exception:", ""),
    //             style: kPostGetNoteTextStyle,
    //           ),
    //         ),
    //       );
    //     }
    //     return Expanded(child: Center(child: CircularProgressIndicator(),));
    //   },
    // );
    // reply in replies
    return Expanded(
        child: ListView.builder(
            itemCount: replies.length,
            itemBuilder: (BuildContext context, index) {
              final item = replies[index];
              return ReplyWidget(
                  reply: item, context: context, post: widget.post);
            }));
  }
}
