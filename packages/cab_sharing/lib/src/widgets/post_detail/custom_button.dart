import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../decorations/colors.dart';
import '../../services/launcher.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final String value;
  const CustomButton({
    super.key,
    required this.text,
    required this.icon,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        try {
          if (text == 'Call') {
            await launchPhoneURL(value);
          } else {
            await launchEmailURL(value);
          }
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
        }
      },
      child: Container(
        alignment: Alignment.center,
        height: 52,
        decoration: BoxDecoration(
          color: kFloatingButtonColor,
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
              style: const TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
