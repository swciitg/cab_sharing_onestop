import 'package:campus_ola/decorations/home_screen_style.dart';
import 'package:campus_ola/models/post_model.dart';
import 'package:campus_ola/screens/create_post/create_post.dart';
import 'package:campus_ola/screens/search_page/search_page.dart';
import 'package:campus_ola/widgets/home/post_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const id = "/home";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Campus Ola",
          style: kAppBarTextStyle,
        ),
        actions: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SearchPage()),
                  );
                },
                child: Image.asset(
                  "assets/search.png",
                  width: 15.00,
                  height: 15.00,
                ),
              ),
              Container(
                width: 14.00,
              ),
              Image.asset(
                "assets/message.png",
                width: 15.00,
                height: 15.00,
              ),
              Container(
                width: 14.00,
              ),
              Image.asset(
                "assets/profile.png",
                width: 15.00,
                height: 15.00,
              ),
              Container(
                width: 20.00,
              )
            ],
          )
        ],
        backgroundColor: const Color.fromRGBO(39, 49, 65, 0.64),
      ),
      backgroundColor: const Color(0xFF1B1B1D),
      body: ListView(
        children: [
          Row(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 18.0, left: 15.0, bottom: 10.0),
                child: Text(
                  "Today | ",
                  style: kTodayTextStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  "Oct 21st, 2022",
                  style: kDateTextStyle,
                ),
              ),
            ],
          ),
          PostWidget(
            post: Post(
              name: "Sanika S. Kamble",
              email: "sanika19@iitg.ac.in",
              note: Post.oneHour,
              mode: Post.airway,
              time: "10.30 am",
            ),
            context: context,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 14.0, left: 15.0, bottom: 10.0),
            child: Text(
              "Oct 22nd, 2022",
              style: kDateTextStyle,
            ),
          ),
          PostWidget(
            post: Post(
                name: "Sanika S. Kamble",
                email: "sanika19@iitg.ac.in",
                note: Post.oneHour,
                mode: Post.airway,
                time: "10.30 am"),
            context: context,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreatePost()),
          );
        },
        label: const Text(
          "+",
          style: TextStyle(
              color: Colors.black, fontSize: 40, fontWeight: FontWeight.w300),
        ),
        backgroundColor: const Color(0xFF76ACFF),
      ),
    );
  }
}
