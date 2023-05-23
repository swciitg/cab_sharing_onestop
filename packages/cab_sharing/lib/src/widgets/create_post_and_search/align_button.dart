import 'package:cab_sharing/src/decorations/colors.dart';
import 'package:flutter/material.dart';

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
            color: kFloatingButtonColor,
            borderRadius: BorderRadius.all(Radius.circular(16))),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 17),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}
