import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileWidget extends ConsumerWidget {
  final String userName;
  final String location;
  final String imageUrl;

  const ProfileWidget({
    super.key,
    required this.userName,
    required this.location,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 15),
          UserPhotoWidget(
            imageUrl: imageUrl,
          ),
          const SizedBox(width: 15),
          UserInfoWidget(
            location: location,
            userName: userName,
          ),
          const Spacer(),
          SvgPicture.asset(
            'assets/svg/ellipsis-solid.svg',
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

/// user photo image
class UserPhotoWidget extends ConsumerWidget {
  final String imageUrl;

  const UserPhotoWidget({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: SizedBox(
        height: 50,
        width: 50,
        child: CachedNetworkImage(
            imageUrl: imageUrl,
            fadeInDuration: const Duration(milliseconds: 500),
            imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
      ),
    );
  }
}

/// user infomation
class UserInfoWidget extends ConsumerWidget {
  final String userName;
  final String location;

  const UserInfoWidget({
    super.key,
    required this.userName,
    required this.location,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          userName,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          location,
          style: const TextStyle(
            color: Colors.white60,
            fontSize: 13,
          ),
        )
      ],
    );
  }
}
