import 'package:cab_sharing/decorations/campus_ola_five_style.dart';
import 'package:cab_sharing/models/post_model.dart';
import 'package:cab_sharing/widgets/post_detail/custom_button.dart';
import 'package:flutter/material.dart';
import '../decorations/home_screen_style.dart';

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
        title: Text(
          "Campus Ola",
          style: kAppBarTextStyle,
        ),
        backgroundColor: const Color.fromRGBO(39, 49, 65, 0.64),
      ),
      body: SafeArea(
        child: Column(
          children: [
            //Upper Column

            Container(
              height: MediaQuery.of(context).size.height * 0.30,
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
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          //Time
                          Text(
                            post.time,
                            style: kiPostTimeTextStyle,
                          ),
                          //Travel Mode Icon
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              post.mode == Post.airway
                                  ? Icons.airplanemode_active
                                  : Icons.train,
                              color: Colors.white,
                              size: 24,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  //Info Box
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.1,
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
                  CustomButton(
                    text: 'Call',
                    icon: Icons.call_outlined,
                  ),
                  SizedBox(
                    width : 20,
                  ),
                  CustomButton(
                    text: 'Mail',
                    icon: Icons.mail_outlined,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}