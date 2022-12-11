import 'package:flutter/material.dart';

class TravelIcons extends StatelessWidget {
  final String from;
  final String to;
  final Color color;
  const TravelIcons({
    Key? key,
    required this.from,
    required this.to,
    this.color = Colors.white
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(
          from == 'Airport'
              ? Icons.airplanemode_active_outlined
              : from == 'Railway Station'
              ? Icons.directions_railway
              : Icons.school,
          size: 20,
          color: color,
        ),
        Icon(
          Icons.arrow_right_alt,
          size: 20,
          color: color,
        ),
        Icon(
          to == 'Airport'
              ? Icons.airplanemode_active_outlined
              : to == 'Railway Station'
              ? Icons.directions_railway
              : Icons.school,
          size: 20,
          color: color,
        ),
      ],
    );
  }
}
