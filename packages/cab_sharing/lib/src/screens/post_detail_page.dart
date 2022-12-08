// import 'package:cab_sharing/src/decorations/chat_screen_style.dart';
// import 'package:cab_sharing/src/models/reply_model.dart';
// import 'package:cab_sharing/src/widgets/post_detail/reply_widget.dart';
import 'package:flutter/material.dart';
import '../widgets/post_detail/custom_button.dart';
import '../decorations/campus_ola_five_style.dart';
import '../models/post_model.dart';

class PostDetailPage extends StatelessWidget {
  final Post post;
  const PostDetailPage({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Column(
          children: [
            //Upper Column
            Container(
              width: MediaQuery.of(context).size.width,
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
                            post.name,
                            style: kiPostNameTextStyle,
                          ),
                          //Email
                          Text(
                            post.email,
                            style: kiPostEmailTextStyle,
                          ),
                          //Departure Time
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          Text(
                            post.getNote(),
                            style: kiPostGetNoteTextStyle,
                          ),
                        ],
                      ),
                      //Right Column
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          //Time
                          Text(
                            post.time,
                            style: kiPostTimeTextStyle,
                          ),
                          //Travel Mode Icon
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                post.from == Post.airway
                                    ? Icons.airplanemode_active_outlined
                                    : post.from == Post.railway
                                    ? Icons.directions_railway
                                    : Icons.school,
                                size: 20,
                                color: Colors.white,
                              ),
                              Icon(
                                Icons.arrow_right_alt,
                                size: 20,
                                color: Colors.white,
                              ),
                              Icon(
                               post.to == Post.airway
                                    ? Icons.airplanemode_active_outlined
                                    : post.to == Post.railway
                                    ? Icons.directions_railway
                                    : Icons.school,
                                size: 20,
                                color: Colors.white,
                              ),
                            ],
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
                    alignment: Alignment.topRight,
                    padding: const EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.15,
                    decoration: kContainerDecoration,
                    child: Text(
                      'Note:- ${post.note}',
                      style: kContainerTextStyle,
                    ),
                  ),
                ],
              ),
            ),
            //Buttons Column
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.04,
                horizontal: MediaQuery.of(context).size.width * 0.06,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Expanded(
                    child: CustomButton(
                      text: 'Call',
                      icon: Icons.call_outlined,
                      value: '8888888888',
                    ),
                  ),
                  SizedBox(
                    width : 20,
                  ),
                  Expanded(
                    child: CustomButton(
                      text: 'Mail',
                      icon: Icons.mail_outlined,
                      value: 'abcd@gmail.com',
                    ),
                  ),
                ],
              ),
            ),
            // ReplyWidget(
            //     reply: Reply(
            //         replyid: 'xyz',
            //         email: post.email,
            //         description: 'hellob',
            //         time: '10:30'
            //     ),
            //     context: context,
            //     post: post
            // ),
            // ReplyWidget(
            //     reply: Reply(
            //         replyid: 'xyz',
            //         email: "b",
            //         description: 'hellob',
            //         time: '10:30'
            //     ),
            //     context: context,
            //     post: post
            // ),
            // Positioned(
            //   bottom: 0,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: [
            //       Container(
            //         width: MediaQuery.of(context).size.width*0.75,
            //         height: MediaQuery.of(context).size.width*0.15,
            //         margin: const EdgeInsets.all(4),
            //         padding: const EdgeInsets.only(
            //           left: 10,
            //           right: 8,
            //           top: 8,
            //           bottom: 8,
            //         ),
            //         decoration: BoxDecoration(
            //             color: Color.fromRGBO(35, 41, 52, 1),
            //             borderRadius: BorderRadius.all(
            //                 Radius.circular(16)
            //             )
            //         ),
            //         child: TextFormField(
            //           style: chatTextStyle,
            //         ),
            //       ),
            //       Container(
            //         width: MediaQuery.of(context).size.width*0.15,
            //         height: MediaQuery.of(context).size.width*0.15,
            //         decoration: BoxDecoration(
            //             color: Color.fromRGBO(35, 41, 52, 1),
            //             borderRadius: BorderRadius.all(
            //                 Radius.circular(MediaQuery.of(context).size.width*0.15),
            //             )
            //         ),
            //         child: IconButton(
            //           onPressed: () {  },
            //           icon: Icon(Icons.send_outlined),
            //           color: Colors.white,
            //           iconSize: MediaQuery.of(context).size.width*0.075,
            //         ),
            //       )
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}