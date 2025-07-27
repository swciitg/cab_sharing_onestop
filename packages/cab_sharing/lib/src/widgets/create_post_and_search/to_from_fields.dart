import 'package:flutter/material.dart';

import '../../decorations/colors.dart';
import '../../decorations/post_and_search_style.dart';

class ToFromField extends StatefulWidget {
  final TextEditingController to;
  final TextEditingController from;
  final GlobalKey formKey;
  const ToFromField(
      {super.key, required this.to, required this.from, required this.formKey});

  @override
  State<ToFromField> createState() => _ToFromFieldState();
}

class _ToFromFieldState extends State<ToFromField> {
  double fieldHeight = 70;
  String? dropValidator(value) {
    if (widget.from.text == value) {
      setState(() {
        fieldHeight = 90;
      });
      return "To and From can not be the same";
    }
    setState(() {
      fieldHeight = 70;
    });
    return null;
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      // autovalidateMode: AutovalidateMode.always,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 28.0, left: 20.0),
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
              return DropdownButtonFormField<String>(
                decoration: const InputDecoration(border: InputBorder.none),
                dropdownColor: kCommonBoxBackground,
                isExpanded: true,
                style: secondStyle,
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Colors.white,
                  size: 30,
                ),
                value: widget.from.text,
                items: <String>["Campus", "Airport", "Railway Station"]
                    .map((String val) {
                  return DropdownMenuItem<String>(
                    value: val,
                    child: IconRow(value: val),
                  );
                }).toList(),
                onChanged: (String? val) {
                  setState(() {});
                  widget.from.text = val!;
                },
              );
            }),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 28.0, left: 20.0),
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
            height: fieldHeight,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Builder(builder: (context) {
              return DropdownButtonFormField<String>(
                validator: dropValidator,
                decoration: const InputDecoration(border: InputBorder.none,errorStyle: errorStyle),
                dropdownColor: kCommonBoxBackground,
                isExpanded: true,
                style: secondStyle,
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Colors.white,
                  size: 30,
                ),
                value: widget.to.text,
                items: <String>["Campus", "Airport", "Railway Station"]
                    .map((String val) {
                  return DropdownMenuItem<String>(
                      value: val,
                      child: IconRow(
                        value: val,
                      ));
                }).toList(),
                onChanged: (String? val) {
                  setState(() {});
                  widget.to.text = val!;
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

class IconRow extends StatelessWidget {
  final String value;
  const IconRow({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        iconMap[value]!,
        const SizedBox(
          width: 10,
        ),
        Text(value),
      ],
    );
  }
}
