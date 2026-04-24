import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../model/search_board_item.dart';

class IdeaBoardCard extends StatelessWidget {
  final SearchBoardItem item;

  const IdeaBoardCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: CachedNetworkImage(
              imageUrl: item.imageUrl,
              width: double.infinity,
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
                  child: const Icon(Icons.broken_image_outlined),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          item.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.black,
            height: 1.2,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 3),
        Row(
          children: [
            Text(
              item.subtitle,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 6),
            const Icon(
              Icons.check_circle,
              size: 18,
              color: Colors.red,
            ),
          ],
        ),
        const SizedBox(height: 2),
        Text(
          item.meta,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: Color(0xFF6E6E69),
          ),
        ),
      ],
    );
  }
}