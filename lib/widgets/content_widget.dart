import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_feed/providers/page_provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

/// image releated media contents
class MediaContentWidget extends ConsumerWidget {
  final List<String> imgList;
  final int row;

  const MediaContentWidget({
    super.key,
    required this.imgList,
    required this.row,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CarouselSlider(
      options: CarouselOptions(
        aspectRatio: 3.0 / 4.0,
        viewportFraction: 1.0,
        enableInfiniteScroll: false,
        onPageChanged: (page, reason) {
          ref.read(pageNotifierProvider(row).notifier).setPage(page);
        },
      ),
      items: imgList
          .map((item) => Center(
                child: CachedNetworkImage(
                    imageUrl: item,
                    fadeInDuration: const Duration(milliseconds: 500),
                    imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        )),
              ))
          .toList(),
    );
  }
}

/// bottom operation widget
class FeedOperationsWidget extends ConsumerWidget {
  final int pageCount;
  final int row;

  const FeedOperationsWidget({
    super.key,
    required this.pageCount,
    required this.row,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(pageNotifierProvider(row));
    return Container(
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 15),
          SvgPicture.asset(
            'assets/svg/heart-regular.svg',
            width: 50,
            height: 20,
            colorFilter:
                const ColorFilter.mode(Colors.white70, BlendMode.srcIn),
          ),
          const SizedBox(width: 15),
          SvgPicture.asset(
            'assets/svg/message-regular.svg',
            width: 50,
            height: 20,
            colorFilter:
                const ColorFilter.mode(Colors.white70, BlendMode.srcIn),
          ),
          const SizedBox(width: 15),
          SvgPicture.asset(
            'assets/svg/paper-plane-regular.svg',
            width: 50,
            height: 20,
            colorFilter:
                const ColorFilter.mode(Colors.white70, BlendMode.srcIn),
          ),
          const Spacer(),
          AnimatedSmoothIndicator(
            activeIndex: page,
            count: pageCount,
            effect: const ScrollingDotsEffect(
              dotHeight: 6,
              dotWidth: 6,
              maxVisibleDots: 5,
            ),
          ),
          const Spacer(),
          SvgPicture.asset(
            'assets/svg/bookmark-regular.svg',
            width: 50,
            height: 20,
            colorFilter:
                const ColorFilter.mode(Colors.white70, BlendMode.srcIn),
          ),
          const SizedBox(width: 15),
        ],
      ),
    );
  }
}

/// comments widget
class CommentsWidget extends ConsumerWidget {
  final String likedBy;
  final String momentsFrom;

  const CommentsWidget({
    super.key,
    required this.likedBy,
    required this.momentsFrom,
  });

  Widget likeImages() {
    return SizedBox(
        width: 60,
        height: 30,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              child: imageWithBorder('assets/png/photo1.png'),
            ),
            Positioned(
              left: 15,
              child: imageWithBorder('assets/png/photo2.png'),
            ),
            Positioned(
              left: 30,
              child: imageWithBorder('assets/png/photo3.png'),
            ),
          ],
        ));
  }

  Widget imageWithBorder(String imagePath) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.asset(
          imagePath,
          width: 30,
          height: 30,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget likes = likeImages();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              likes,
              const SizedBox(width: 5, height: 50),
              Text(
                likedBy,
                style: const TextStyle(color: Colors.white, fontSize: 14),
              )
            ],
          ),
          Text(
            momentsFrom,
            style: const TextStyle(color: Colors.white70, fontSize: 13),
          ),
          const SizedBox(height: 3),
          const Text(
            "View all 4 comments",
            style: TextStyle(color: Colors.white54, fontSize: 15),
          ),
          const SizedBox(height: 3),
          const Text(
            "3 days ago",
            style: TextStyle(color: Colors.white54, fontSize: 14),
          )
        ],
      ),
    );
  }
}
