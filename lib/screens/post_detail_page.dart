import 'package:campus_ola/decorations/campus_ola_five_style.dart';
import 'package:campus_ola/models/post_model.dart';
import 'package:campus_ola/widgets/post_detail/custom_button.dart';
import 'package:flutter/material.dart';

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
                      'Note : Lorem ipsum dolor sit amet, consect'
                      'etur adipiscing elit, sed do eiusmod tempor'
                      'incididunt ut labore et dolore magna aliqua.'
                      'Ut enim ad minim veniam, quis nostrud.',
                      style: kContainerTextStyle,
                    ),
                  ),
                ],
              ),
            ),
            //Buttons Column
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.04,
                horizontal: MediaQuery.of(context).size.width * 0.06,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  CustomButton(
                    text: 'Chat',
                    icon: Icons.chat_outlined,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  CustomButton(
                    text: 'Call',
                    icon: Icons.call_outlined,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  CustomButton(
                    text: 'Mail',
                    icon: Icons.email_outlined,
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
