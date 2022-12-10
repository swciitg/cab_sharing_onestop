import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../decorations/campus_ola_five_style.dart';

class CornerCase extends StatelessWidget {
  final String message;
  const CornerCase({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 234,
            height: 73,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(21.0),
              ),
              color: Color.fromRGBO(39, 49, 65, 1),
            ),
            child: Center(
              child: Text(
                message,
                style: kCornerStyle
              ),
            ),
          ),
        ],
      ),
    );
  }
}
