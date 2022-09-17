import 'package:cached_network_image/cached_network_image.dart';
import '../../models/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class PostItem extends StatelessWidget {
  final Post post;
  final Function onDeleteItem;
  const PostItem({
    Key? key,
    required this.post,
    required this.onDeleteItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: post.imageUrl != null ? null : 60,
      margin: const EdgeInsets.only(top: 20),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: const [
            BoxShadow(
              blurRadius: 8,
              spreadRadius: 3,
              color: Colors.grey,
            )
          ]),
      child: Row(
        children: <Widget>[
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // If the image is not null load the imageURL
                post.imageUrl != null
                    ? SizedBox(
                        height: 250,
                        child: CachedNetworkImage(
                          imageUrl: post.imageUrl!,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      )
                    // If the image is null show nothing
                    : Container(),
                Text(post.title),
              ],
            ),
          )),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              onDeleteItem();
            },
          ),
        ],
      ),
    );
  }
}
