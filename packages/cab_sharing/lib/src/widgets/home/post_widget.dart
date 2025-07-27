import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../decorations/post_widget_style.dart';
import '../../functions/snackbar.dart';
import '../../models/post_model.dart';
import '../../screens/post_detail_page.dart';
import '../../services/api.dart';
import '../../services/user_store.dart';
import '../ui/travel_icons.dart';

class PostWidget extends StatefulWidget {
  final String colorCategory;
  final PostModel post;
  final Function deleteCallback;
  const PostWidget({
    super.key,
    required this.post,
    required this.colorCategory,
    required this.deleteCallback,
  });

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  bool allowDelete = true;
  @override
  Widget build(BuildContext context) {
    bool myPost = (widget.colorCategory == "mypost");
    var commonStore = context.read<CommonStore>();
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return Provider.value(value: commonStore, child: PostDetailPage(post: widget.post));
            },
          ),
        );
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
        decoration: myPost ? kRowContainerDecorationMyPost : kRowContainerDecoration,
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      myPost ? widget.post.getDate() : widget.post.name,
                      style: myPost ? kPostNameTextStyleMyPost : kPostNameTextStyle,
                      softWrap: true,
                    ),
                    Text(
                      widget.post.email,
                      style: myPost ? kPostEmailTextStyleMyPost : kPostEmailTextStyle,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.post.note.replaceAll("\n", " "),
                      style: myPost ? kPostGetNoteTextStyleMyPost : kPostGetNoteTextStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  myPost
                      ? GestureDetector(
                        onTap: allowDelete ? () => _delete(commonStore) : null,
                        child: const Icon(Icons.delete_outline, color: Colors.black),
                      )
                      : const SizedBox(height: 1),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                    child: Text(
                      widget.post.getTime(),
                      style: myPost ? kPostTimeTextStyleMyPost : kPostTimeTextStyle,
                    ),
                  ),
                  TravelIcons(
                    from: widget.post.from,
                    to: widget.post.to,
                    color: myPost ? Colors.black : Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _delete(CommonStore commonStore) async {
    Map<String, String> data = {};
    data['postId'] = widget.post.id;
    data['email'] = commonStore.userEmail;
    data['security-key'] = commonStore.securityKey;
    setState(() {
      allowDelete = false;
    });
    bool deleteSuccess = await APIService().deletePost(data);
    if (deleteSuccess) {
      widget.deleteCallback();
    } else {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        getSnackBar("An error occurred. Your post could not be deleted at this moment."),
      );
      setState(() {
        allowDelete = true;
      });
    }
  }
}
