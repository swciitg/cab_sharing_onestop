import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/custom_button.dart';

class CampusOlaFive extends StatelessWidget {
  static const id = "/campus-ola-five";
  const CampusOlaFive({Key? key}) : super(key: key);

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
                            'Sanika S. Kamble',
                            style: GoogleFonts.montserrat(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                              color: Colors.white,
                            ),
                          ),

                          //Email

                          Text(
                            'sanika19@iitg.ac.in',
                            style: GoogleFonts.montserrat(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.5,
                              color: const Color(0xff76ACFF),
                            ),
                          ),

                          //Departure Time

                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),

                          Text(
                            'Can leave upto 1 hr early.',
                            style: GoogleFonts.montserrat(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.5,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),

                      //Right Column

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          //Time

                          Text(
                            '8:30 am',
                            style: GoogleFonts.montserrat(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                              color: Colors.white,
                            ),
                          ),

                          //Travel Mode Icon

                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.airplanemode_active,
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
                    decoration: BoxDecoration(
                      color: const Color(0xff1B1B1D),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Note : Lorem ipsum dolor sit amet, consect'
                      'etur adipiscing elit, sed do eiusmod tempor'
                      'incididunt ut labore et dolore magna aliqua.'
                      'Ut enim ad minim veniam, quis nostrud.',
                      style: GoogleFonts.montserrat(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                        color: Colors.white,
                      ),
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
                  //Chats Button

                  CustomButton(
                    text: 'Chat',
                    icon: Icons.chat_outlined,
                  ),

                  SizedBox(
                    height: 40,
                  ),

                  //Call Button
                  CustomButton(
                    text: 'Call',
                    icon: Icons.call_outlined,
                  ),

                  SizedBox(
                    height: 40,
                  ),

                  //Mail Button
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
