import 'package:campus_ola/models/post_model.dart';
import 'package:campus_ola/widgets/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        title: const Text("Home Screen"),
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
                  style: GoogleFonts.montserrat(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                    color: const Color(0xFFBDC7DC),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  "Oct 21st, 2022",
                  style: GoogleFonts.montserrat(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                    color: const Color(0xFFBDC7DC),
                  ),
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
                time: "10.30 am"),
          ),
          PostWidget(
            post: Post(
                name: "Sanika S. Kamble",
                email: "sanika19@iitg.ac.in",
                note: Post.exact,
                mode: Post.railway,
                time: "10.30 am"),
          ),
          PostWidget(
            post: Post(
                name: "Sanika S. Kamble",
                email: "sanika19@iitg.ac.in",
                note: Post.twoHour,
                mode: Post.airway,
                time: "10.30 am"),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 14.0, left: 15.0, bottom: 10.0),
            child: Text(
              "Oct 22nd, 2022",
              style: GoogleFonts.montserrat(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.5,
                color: const Color(0xFFBDC7DC),
              ),
            ),
          ),
          PostWidget(
            post: Post(
                name: "Sanika S. Kamble",
                email: "sanika19@iitg.ac.in",
                note: Post.oneHour,
                mode: Post.airway,
                time: "10.30 am"),
          ),
          PostWidget(
            post: Post(
                name: "Sanika S. Kamble",
                email: "sanika19@iitg.ac.in",
                note: Post.twoHour,
                mode: Post.railway,
                time: "10.30 am"),
          ),
          PostWidget(
            post: Post(
                name: "Sanika S. Kamble",
                email: "sanika19@iitg.ac.in",
                note: Post.exact,
                mode: Post.airway,
                time: "10.30 am"),
          ),
        ],
      ),
    );
  }
}
