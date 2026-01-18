import 'package:cab_sharing/src/decorations/post_and_search_style.dart';
import 'package:flutter/material.dart';

class TravelIcons extends StatelessWidget {
  final String from;
  final String to;
  final Color color;
  const TravelIcons({
    super.key,
    required this.from,
    required this.to,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    // Default icon if location not found in iconMap
    const defaultIcon = Icon(Icons.location_on, color: Colors.white);

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(iconMap[from]?.icon ?? defaultIcon.icon, size: 20, color: color),
        Icon(Icons.arrow_right_alt, size: 20, color: color),
        Icon(iconMap[to]?.icon ?? defaultIcon.icon, size: 20, color: color),
      ],
    );
  }
}
