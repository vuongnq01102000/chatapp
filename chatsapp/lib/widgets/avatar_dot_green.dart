import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CircleAvatarDotGreen extends StatelessWidget {
  const CircleAvatarDotGreen({
    Key? key,
    required this.imgPath,
    this.isOnl = false,
  }) : super(key: key);
  final String imgPath;
  final bool isOnl;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          maxRadius: 25,
          minRadius: 10,
          backgroundImage: CachedNetworkImageProvider(imgPath),
        ),
        if (isOnl == true)
          const Positioned(
            bottom: 2,
            right: 3,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              maxRadius: 7,
              child: CircleAvatar(
                maxRadius: 5,
                backgroundColor: Colors.greenAccent,
              ),
            ),
          )
      ],
    );
  }
}
