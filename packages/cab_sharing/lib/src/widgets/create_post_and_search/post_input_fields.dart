import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../decorations/post_and_search_style.dart';

class PostFields extends StatefulWidget {
  final TextEditingController phoneController;
  final TextEditingController noteController;
  final GlobalKey formKey;
  const PostFields({
    super.key,
    required this.phoneController,
    required this.noteController,
    required this.formKey,
  });

  @override
  State<PostFields> createState() => _PostFieldsState();
}

class _PostFieldsState extends State<PostFields> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 24.0, left: 20.0),
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
            height: 75,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Optional',
                counterStyle: counterStyle,
                hintStyle: hintStyle,
              ),
              controller: widget.phoneController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              maxLength: 10,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              style: titleStyle,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 24.0, left: 20.0),
            child: Text(
              "Note",
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
            height: 110,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextFormField(
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 3,
              decoration: const InputDecoration(
                errorStyle: errorStyle,
                hintStyle: hintStyle,
                hintMaxLines: 3,
                hintText:
                    "Mention if your timings are flexible i.e you can leave a few mins early/late, if you have already booked a cab, etc.",
              ),
              controller: widget.noteController,
              style: titleStyle,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "This field can not be empty";
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}
