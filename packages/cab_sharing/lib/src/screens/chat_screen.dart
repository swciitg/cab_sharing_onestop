import 'package:flutter/material.dart';

import '../decorations/post_widget_style.dart';
import '../models/post_model.dart';
import '../models/reply_model.dart';
import '../services/api.dart';
import '../widgets/post_detail/reply_widget.dart';
import '../widgets/shimmers/chat_shimmer.dart';

class ChatScreen extends StatefulWidget {
  final PostModel post;
  const ChatScreen({Key? key, required this.post}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ReplyModel>>(
      future: APIService.getPostReplies(widget.post.chatId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<ReplyModel> replies = snapshot.data!;
          return Expanded(
            child: ListView.builder(
              itemCount: replies.length,
              itemBuilder: (context, index) {
                final item = replies[index];
                return ReplyWidget(
                    reply: item, context: context, post: widget.post);
              },
            ),
          );
        } else if (snapshot.hasError) {
          return Expanded(
            child: Center(
              child: Text(
                snapshot.error.toString().replaceAll("Exception:", ""),
                style: kPostGetNoteTextStyle,
              ),
            ),
          );
        }
        return const ChatLoading();
      },
    );
  }
}


