import 'package:flutter/material.dart';

import '../../decorations/post_and_search_style.dart';

class ToFromField extends StatefulWidget {
  var toFromController;

  ToFromField({Key? key, required this.toFromController}) : super(key: key);

  @override
  State<ToFromField> createState() => _ToFromFieldState();
}

class _ToFromFieldState extends State<ToFromField> {
  String fromValue = "Campus";
  String toValue = "Airport";

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 28.0, left: 20.0),
          child: Text(
            "From",
            style: titleStyle,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
            left: 15,
            right: 15,
            top: 8,
          ),
          decoration: commonBoxDecoration,
          height: 70,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Builder(builder: (context) {
            return DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                dropdownColor: const Color.fromRGBO(39, 49, 65, 1),
                isExpanded: true,
                style: secondStyle,
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Colors.white,
                  size: 30,
                ),
                value: fromValue,
                items: <String>["Campus", "Airport", "Railway Station"]
                    .map((String val) {
                  return DropdownMenuItem<String>(
                    value: val,
                    child: Text(val),
                  );
                }).toList(),
                onChanged: (String? val) {
                  fromValue = val!;
                  setState(() {});
                },
              ),
            );
          }),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 28.0, left: 20.0),
          child: Text(
            "To",
            style: titleStyle,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
            left: 15,
            right: 15,
            top: 8,
          ),
          decoration: commonBoxDecoration,
          height: 70,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Builder(builder: (context) {
            return DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                dropdownColor: const Color.fromRGBO(39, 49, 65, 1),
                isExpanded: true,
                style: secondStyle,
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Colors.white,
                  size: 30,
                ),
                value: toValue,
                items: <String>["Campus", "Airport", "Railway Station"]
                    .map((String val) {
                  return DropdownMenuItem<String>(
                    value: val,
                    child: Text(val),
                  );
                }).toList(),
                onChanged: (String? val) {
                  toValue = val!;
                  setState(() {
                    widget.toFromController(toValue, fromValue);
                  });
                },
              ),
            );
          }),
        ),
      ],
    );
  }
}
