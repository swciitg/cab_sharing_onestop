import 'package:campus_ola/decorations/custom_button_style.dart';
import 'package:flutter/material.dart';

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
      decoration: kCustomButtonContainerDecoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          const SizedBox(
            width: 20,
          ),
          Text(
            text,
            style: kCustomButtonTextStyle,
          ),
        ],
      ),
    );
  }
}
