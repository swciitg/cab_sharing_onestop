import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final IconData icon;
  const CustomButton({
    Key? key,
    required this.text,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 52,
      width: 328,
      decoration: BoxDecoration(
        color: const Color(0xff76ACFF),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          const SizedBox(
            width: 20,
          ),
          Text(
            text,
            style: GoogleFonts.montserrat(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
