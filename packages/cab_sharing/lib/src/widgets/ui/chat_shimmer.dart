import 'package:flutter/cupertino.dart';

import 'package:shimmer/shimmer.dart';

import '../../decorations/chat_screen_style.dart';
import '../../decorations/colors.dart';

class ChatLoading extends StatelessWidget {
  const ChatLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Shimmer.fromColors(
        baseColor: kShimmerBase,
        highlightColor: kShimmerHighlight,
        child: const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                OthersReply(height: 50),
                YourReply(height: 60),
                YourReply(height: 50),
                OthersReply(height: 70),
                YourReply(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class YourReply extends StatelessWidget {
  final double height;
  const YourReply({Key? key, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          width: MediaQuery.of(context).size.width * 0.6,
          height: height,
          decoration: receivedBoxDecoration,
        )
      ],
    );
  }
}

class OthersReply extends StatelessWidget {
  final double height;
  const OthersReply({
    Key? key,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          width: MediaQuery.of(context).size.width * 0.6,
          height: height,
          decoration: receivedBoxDecoration,
        )
      ],
    );
  }
}
