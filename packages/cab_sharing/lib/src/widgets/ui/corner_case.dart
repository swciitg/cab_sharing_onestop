import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onestop_ui/utils/colors.dart';
import 'package:onestop_ui/utils/styles.dart';

import '../../decorations/campus_ola_five_style.dart';
import '../../decorations/colors.dart';

class CornerCase extends StatelessWidget {
  final String message;
  const CornerCase({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 234,
            height: 173,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(21.0),
              ),
              color: OColor.gray100,
            ),
            child: Center(
              child: Text(message, style: OTextStyle.labelLarge),
            ),
          ),
        ],
      ),
    );
  }
}
