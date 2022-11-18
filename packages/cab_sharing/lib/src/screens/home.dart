import 'package:flutter/material.dart';
import '../models/post_model.dart';
import '../widgets/home/post_widget.dart';
import '../screens/post_search_page.dart';
import '../decorations/home_screen_style.dart';

class CabSharingScreen extends StatefulWidget {
  final Map<String,String> userData;
  const CabSharingScreen({Key? key, required this.userData}) : super(key: key);

  @override
  State<CabSharingScreen> createState() => _CabSharingScreenState();
}

class _CabSharingScreenState extends State<CabSharingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Campus Ola",
          style: kAppBarTextStyle,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PostSearchPage(category: "search", userData: widget.userData,)),
                  );
                },
                child: const Icon(
                  Icons.search,
                  color: Colors.white,
                )
            ),
          )
        ],
        backgroundColor: const Color.fromRGBO(39, 49, 65, 0.64),
      ),
      backgroundColor: const Color(0xFF1B1B1D),
      body: ListView(
        children: [
          Padding(
            padding:
            const EdgeInsets.only(top: 18.0, left: 15.0, bottom: 10.0),
            child: Text(
              "My Post",
              style: kTodayTextStyle,
            ),
          ),
          PostWidget(
            post: Post(
              note: 'Lorem ipsum dolor sit amet, consect'
                  'etur adipiscing elit, sed do eiusmod tempor'
                  'incididunt ut labore et dolore magna aliqua.'
                  'Ut enim ad minim veniam, quis nostrud.',
              name: "Oct 21st, 2022",
              email: "sanika19@iitg.ac.in",
              margin: Post.oneHour,
              mode: Post.airway,
              time: "10.30 am",
            ),
            context: context,
            colorCategory: 'mypost',
          ),
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
              note: 'Lorem ipsum dolor sit amet, consect'
                  'etur adipiscing elit, sed do eiusmod tempor'
                  'incididunt ut labore et dolore magna aliqua.'
                  'Ut enim ad minim veniam, quis nostrud.',
              name: "Sanika S. Kamble",
              email: "sanika19@iitg.ac.in",
              margin: Post.oneHour,
              mode: Post.airway,
              time: "10.30 am",
            ),
            context: context,
            colorCategory: "post",
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
                margin: Post.oneHour,
                note: 'Lorem ipsum dolor sit amet, consect'
                    'etur adipiscing elit, sed do eiusmod tempor'
                    'incididunt ut labore et dolore magna aliqua.'
                    'Ut enim ad minim veniam, quis nostrud.',
                mode: Post.airway,
                time: "10.30 am"),
            context: context,
            colorCategory: "post",
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PostSearchPage(category: "post", userData: widget.userData,)),
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