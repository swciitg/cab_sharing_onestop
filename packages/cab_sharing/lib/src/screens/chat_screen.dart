import 'dart:async';

import 'package:flutter/material.dart';

import '../decorations/colors.dart';
import '../decorations/post_widget_style.dart';
import '../models/post_model.dart';
import '../models/reply_model.dart';
import '../services/api.dart';
import '../widgets/post_detail/reply_widget.dart';
import '../widgets/ui/chat_shimmer.dart';

class ChatScreen extends StatefulWidget {
  final PostModel post;
  const ChatScreen({Key? key, required this.post}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final scrollController = ScrollController();
  bool showDown = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      showDownArrow();
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    showDownArrow();
    return FutureBuilder<List<ReplyModel>>(
      future: APIService().getPostReplies(widget.post.chatId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<ReplyModel> replies = snapshot.data!;
          return Expanded(
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                ListView.builder(
                  controller: scrollController,
                  itemCount: replies.length,
                  itemBuilder: (context, index) {
                    final item = replies[index];
                    return ReplyWidget(
                        reply: item, context: context, post: widget.post);
                  },
                ),
                if (showDown)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FloatingActionButton(
                      backgroundColor: kFloatingButtonColor,
                      onPressed: () {
                        scrollController.animateTo(
                            scrollController.position.maxScrollExtent,
                            duration: const Duration(seconds: 1),
                            curve: Curves.easeOut);
                      },
                      child: const Icon(
                        Icons.arrow_drop_down_circle_outlined,
                        color: Colors.black,
                      ),
                    ),
                  ),
              ],
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

  void showDownArrow() {
    if (scrollController.hasClients) {
      if (scrollController.position.pixels <
          scrollController.position.maxScrollExtent) {
        if (showDown == false) {
          setState(() {
            showDown = true;
          });
        }
      } else {
        if (showDown == true) {
          setState(() {
            showDown = false;
          });
        }
      }
    }
  }
}
