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
  const PostDetailPage({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  final TextEditingController chatMessageController = TextEditingController();
  bool allowPostReply = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        backgroundColor: const Color(0xff1B1B1D),
        appBar: AppBar(
          backgroundColor: const Color(0xff1B1B1D),
          elevation: 0,
          leading: IconButton(
            onPressed: Navigator.of(context).pop,
            icon: const Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.white,
            ),
          ),
        ),
        body: SafeArea(
          child: LayoutBuilder(builder: (context, boxConstraints) {
            final viewInsets = EdgeInsets.fromWindowPadding(
                WidgetsBinding.instance.window.viewInsets,
                WidgetsBinding.instance.window.devicePixelRatio);
            var visibleHeight = boxConstraints.maxHeight;
            var bottomHeight = viewInsets.bottom;
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints:
                    BoxConstraints(maxHeight: visibleHeight + bottomHeight),
                child: Column(
                  children: [
                    //Upper Column
                    Container(
                      // width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.04,
                        horizontal: MediaQuery.of(context).size.width * 0.06,
                      ),
                      color: const Color(0xff273141),
                      child: Column(
                        children: [
                          //Info Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //Left Column
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //Name
                                  Text(
                                    widget.post.name,
                                    style: kiPostNameTextStyle,
                                  ),
                                  //Email
                                  Text(
                                    widget.post.email,
                                    style: kiPostEmailTextStyle,
                                  ),
                                  //Departure Time
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.02,
                                  ),
                                ],
                              ),
                              //Right Column
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    widget.post.getDate(),
                                    style: kiPostGetNoteTextStyle,
                                  ),
                                  //Time
                                  Text(
                                    widget.post.getTime(),
                                    style: kiPostTimeTextStyle,
                                  ),
                                  //Travel Mode Icon
                                  TravelIcons(
                                    from: widget.post.from,
                                    to: widget.post.to,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          //Info Box
                          Container(
                            alignment: Alignment.topLeft,
                            padding: const EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: MediaQuery.of(context).size.height * 0.1,
                            decoration: kContainerDecoration,
                            child: SingleChildScrollView(
                              child: Text(
                                'Note:- ${widget.post.note}',
                                style: kContainerTextStyle,
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
                          if (widget.post.phonenumber != null)
                            const SizedBox(
                              width: 20,
                            ),
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
                    ChatScreen(
                      post: widget.post,
                    ),
                    Container(
                      margin: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.75,
                            height: MediaQuery.of(context).size.width * 0.14,
                            decoration: receivedBoxDecoration,
                            padding: const EdgeInsets.all(8),
                            child: TextField(
                              style: chatTextStyle,
                              controller: chatMessageController,
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.14,
                            height: MediaQuery.of(context).size.width * 0.14,
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(35, 41, 52, 1),
                                borderRadius: BorderRadius.all(Radius.circular(
                                    MediaQuery.of(context).size.width * 0.07))),
                            child: IconButton(
                              alignment: Alignment.center,
                              onPressed: allowPostReply
                                  ? () async {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      var commonStore =
                                          context.read<CommonStore>();
                                      setState(() {
                                        allowPostReply = false;
                                      });
                                      var replySuccess =
                                          await APIService.postReply(
                                              commonStore.userName,
                                              chatMessageController.text,
                                              widget.post.chatId,
                                              commonStore.securityKey);
                                      if (replySuccess) {
                                        chatMessageController.clear();
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(getSnackBar(
                                                "An error occurred."));
                                      }
                                      setState(() {
                                        allowPostReply = true;
                                      });
                                    }
                                  : null,
                              icon: Icon(
                                Icons.send_outlined,
                                size: MediaQuery.of(context).size.width * 0.07,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
