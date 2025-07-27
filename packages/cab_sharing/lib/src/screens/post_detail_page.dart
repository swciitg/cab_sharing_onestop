import 'package:cab_sharing/src/decorations/colors.dart';
import 'package:cab_sharing/src/decorations/post_and_search_style.dart';
import 'package:cab_sharing/src/stores/login_store.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../decorations/campus_ola_five_style.dart';
import '../decorations/chat_screen_style.dart';
import '../functions/snackbar.dart';
import '../models/post_model.dart';
import '../services/api.dart';
import '../services/user_store.dart';
import '../widgets/post_detail/custom_button.dart';
import '../widgets/ui/travel_icons.dart';
import 'chat_screen.dart';

class PostDetailPage extends StatefulWidget {
  final PostModel post;
  const PostDetailPage({super.key, required this.post});

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  final TextEditingController chatMessageController = TextEditingController();
  bool allowPostReply = true;
  final double textFieldHeight = 50.0;
  final double textFieldPadding = 8.0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: kBackground,
          appBar: AppBar(
            backgroundColor: kBackground,
            elevation: 0,
            leading: IconButton(
              onPressed: Navigator.of(context).pop,
              icon: const Icon(Icons.arrow_back_ios_outlined, color: Colors.white),
            ),
          ),
          body: SafeArea(
            child: LayoutBuilder(
              builder: (context, boxConstraints) {
                final viewInsets = EdgeInsets.fromViewPadding(
                  View.of(context).viewInsets,
                  View.of(context).devicePixelRatio,
                );
                var visibleHeight = boxConstraints.maxHeight;
                var bottomHeight = viewInsets.bottom;
                var totalHeight = visibleHeight + bottomHeight;
                return SizedBox(
                  height: totalHeight - textFieldHeight - 2 * textFieldPadding,
                  child: Column(
                    children: [
                      //Upper Column
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.04,
                          horizontal: MediaQuery.of(context).size.width * 0.06,
                        ),
                        color: kCommonBoxBackground,
                        child: Column(
                          children: [
                            //Info Row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //Left Column
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      //Name
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width * 0.5,
                                            child: Text(
                                              widget.post.name,
                                              overflow: TextOverflow.ellipsis,
                                              style: kiPostNameTextStyle,
                                            ),
                                          ),
                                          Text(widget.post.getDate(), style: kiPostTimeTextStyle),
                                        ],
                                      ),
                                      //Email
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            widget.post.email,
                                            style: kiPostEmailTextStyle,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          //Time
                                          Text(widget.post.getTime(), style: kiPostTimeTextStyle),
                                        ],
                                      ),
                                      //Travel Mode Icon
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          TravelIcons(from: widget.post.from, to: widget.post.to),
                                        ],
                                      ),
                                      //Departure Time
                                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            //Info Box
                            Container(
                              alignment: Alignment.topLeft,
                              padding: const EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: MediaQuery.of(context).size.height * 0.1,
                              decoration: kContainerDecoration,
                              child: SingleChildScrollView(
                                child: RichText(
                                  text: TextSpan(
                                    text: 'Note: ',
                                    children: [
                                      TextSpan(text: widget.post.note, style: kContainerTextStyle),
                                    ],
                                    style: kContainerBoldTextStyle,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //Buttons Column
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.02,
                          horizontal: MediaQuery.of(context).size.width * 0.06,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (widget.post.phonenumber != null)
                              Expanded(
                                child: CustomButton(
                                  text: 'Call',
                                  icon: Icons.call_outlined,
                                  value: widget.post.phonenumber!,
                                ),
                              ),
                            if (widget.post.phonenumber != null) const SizedBox(width: 20),
                            Expanded(
                              child: CustomButton(
                                text: 'Mail',
                                icon: Icons.mail_outlined,
                                value: widget.post.email,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ChatScreen(post: widget.post),
                    ],
                  ),
                );
              },
            ),
          ),
          bottomSheet: SafeArea(
            child: Container(
              color: kBackground,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: textFieldPadding),
                child: Container(
                  color: kBackground,
                  child: Builder(
                    builder: (context) {
                      bool isGuest = LoginStore.isGuest;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.75,
                            height: textFieldHeight,
                            decoration: receivedBoxDecoration,
                            padding: EdgeInsets.all(textFieldPadding),
                            child: TextField(
                              enabled: !isGuest,
                              maxLines: 1,
                              decoration: InputDecoration(
                                isDense: true,
                                hintText: isGuest ? "Login to reply to posts" : "Comment",
                                hintStyle: hintStyle,
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: kReceiveBoxColor),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: kReceiveBoxColor),
                                ),
                                border: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: kReceiveBoxColor),
                                ),
                              ),
                              style: chatTextStyle,
                              controller: chatMessageController,
                            ),
                          ),
                          Container(
                            height: textFieldHeight,
                            decoration: BoxDecoration(
                              color: kReceiveBoxColor,
                              borderRadius: BorderRadius.all(Radius.circular(textFieldHeight)),
                            ),
                            child: IconButton(
                              alignment: Alignment.center,
                              onPressed: () => onSubmit(isGuest),
                              icon: const Icon(Icons.send_outlined, color: Colors.white),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          // extendBody: true,
        ),
      ),
    );
  }

  void onSubmit(bool isGuest) async {
    bool allowed = allowPostReply && !isGuest;
    if (!allowed) return;
    FocusScope.of(context).requestFocus(FocusNode());
    var commonStore = context.read<CommonStore>();
    setState(() {
      allowPostReply = false;
    });
    var replySuccess = await APIService().postReply(
      commonStore.userName,
      commonStore.userEmail,
      chatMessageController.text,
      widget.post.chatId,
      commonStore.securityKey,
    );
    if (replySuccess) {
      chatMessageController.clear();
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(getSnackBar("An error occurred."));
    }
    setState(() {
      allowPostReply = true;
    });
  }
}
