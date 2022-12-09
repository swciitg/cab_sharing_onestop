import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AlignButton extends StatelessWidget {
  final String text;
  const AlignButton({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: FractionalOffset.bottomCenter,
      child: Container(
        margin: const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
        height: 55,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            color: Color.fromRGBO(118, 172, 255, 1),
            borderRadius: BorderRadius.all(Radius.circular(16))),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 17),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: GoogleFonts.montserrat(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}
