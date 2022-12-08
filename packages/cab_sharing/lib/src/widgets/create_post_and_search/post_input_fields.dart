import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../decorations/post_and_search_style.dart';

class PostFields extends StatefulWidget {
  final TextEditingController phoneController;
  final TextEditingController noteController;
  const PostFields(
      {Key? key, required this.phoneController, required this.noteController})
      : super(key: key);

  @override
  State<PostFields> createState() => _PostFieldsState();
}

class _PostFieldsState extends State<PostFields> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24.0, left: 20.0),
          child: Text(
            "Phone Number",
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
          child: TextField(
            controller: widget.phoneController,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            maxLength: 10,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            style: titleStyle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 24.0, left: 20.0),
          child: Text(
            "Note if any",
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
          child: TextFormField(
            controller: widget.noteController,
            style: titleStyle,
          ),
        ),
      ],
    );
  }
}
