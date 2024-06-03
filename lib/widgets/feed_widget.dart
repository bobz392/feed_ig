import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_feed/widgets/content_widget.dart';
import 'package:instagram_feed/widgets/profile_widget.dart';

class FeedWidget extends ConsumerWidget {
  final String userName;
  final String location;
  final String imageUrl;
  final int row;
  final List<String> imgList;

  const FeedWidget({
    super.key,
    required this.userName,
    required this.location,
    required this.imageUrl,
    required this.row,
    required this.imgList,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 25),
          ProfileWidget(
            userName: userName,
            location: location,
            imageUrl: imageUrl,
          ),
          const SizedBox(height: 5),
          MediaContentWidget(
            imgList: imgList,
            row: row,
          ),
          const SizedBox(height: 15),
          FeedOperationsWidget(
            pageCount: imgList.length,
            row: row,
          ),
          const SizedBox(height: 15),
          const CommentsWidget(
            likedBy: "Liked by zenxu2000 and 35 others",
            momentsFrom: "lukascz1 Moments from Shanghai.",
          ),
        ],
      ),
    );
  }
}
