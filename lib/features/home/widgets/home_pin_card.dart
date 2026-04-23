import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../model/home_feed_item.dart';

class HomePinCard extends StatelessWidget {
  const HomePinCard({
    super.key,
    required this.item,
    required this.height,
  });

  final HomeFeedItem item;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: SizedBox(
            height: height,
            width: double.infinity,
            child: CachedNetworkImage(
              imageUrl: item.imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) {
                return Shimmer.fromColors(
                  baseColor: const Color(0xFFEAEAEA),
                  highlightColor: const Color(0xFFF7F7F7),
                  child: Container(color: Colors.white),
                );
              },
              errorWidget: (context, url, error) {
                return Container(
                  color: const Color(0xFFEAEAEA),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.image_not_supported_outlined,
                    color: Colors.grey,
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 2),
        const Padding(
          padding: EdgeInsets.only(right: 10),
          child: Icon(
            Icons.more_horiz,
            size: 20,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}