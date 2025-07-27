import 'package:cab_sharing/src/decorations/post_and_search_style.dart';
import 'package:flutter/material.dart';

class TravelIcons extends StatelessWidget {
  final String from;
  final String to;
  final Color color;
  const TravelIcons(
      {super.key,
      required this.from,
      required this.to,
      this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(
          iconMap[from]!.icon,
          size: 20,
          color: color,
        ),
        Icon(
          Icons.arrow_right_alt,
          size: 20,
          color: color,
        ),
        Icon(
          iconMap[to]!.icon,
          size: 20,
          color: color,
        ),
      ],
    );
  }
}
