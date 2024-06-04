import 'package:flutter/material.dart';
import 'package:onestop_kit/onestop_kit.dart';

class ErrorScreen extends StatelessWidget {
  final Function reloadCallback;

  const ErrorScreen({required this.reloadCallback, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: Text(
            "Oops!",
            style: OneStopStyles.fontStyle2,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            "Looks like you’ve run into an error. "
            "Please reload to resolve the issue.",
            style: OneStopStyles.bottomNavStyle1,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton.icon(
          onPressed: () {
            reloadCallback();
          },
          icon: const Icon(
            Icons.rotate_right,
            size: 16,
            color: OneStopColors.kBlack,
          ),
          label: const Text(
            "Try again",
            style: TextStyle(
              color: OneStopColors.kBlack,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(OneStopColors.kYellow),
          ),
        )
      ],
    );
  }
}
