import 'package:cab_sharing/src/models/reply_model.dart';
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
    List<Reply> replies = [
      Reply(
          replyid: 'abc',
          email: widget.post.email,
          description: 'loreum ipsum dolor set amit',
          time: '10:30'),
      Reply(
          replyid: 'abc',
          email: widget.post.email,
          description: 'loreum ipsum dolor set amit',
          time: '10:30'),
      Reply(
          replyid: 'xyz',
          email: 'xyz@gmail.com',
          description: 'loreum ipsum dolor set amit',
          time: '10:30'),
      Reply(
          replyid: 'abc',
          email: widget.post.email,
          description: 'loreum ipsum dolor set amit',
          time: '10:30'),
      Reply(
          replyid: 'xyz',
          email: 'xyz@gmail.com',
          description: 'loreum ipsum dolor set amit',
          time: '10:30'),
    ];
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
