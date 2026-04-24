import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../model/search_board_item.dart';

class SearchCollageSectionWidget extends StatelessWidget {
  final SearchCollageSection section;

  const SearchCollageSectionWidget({
    super.key,
    required this.section,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        section.smallTitle,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        section.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                          height: 1.08,
                          letterSpacing: -0.2,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8E8E2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.search,
                    size: 26,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 150,
            child: Row(
              children: List.generate(section.imageUrls.length, (index) {
                final imageUrl = section.imageUrls[index];
                BorderRadius radius = BorderRadius.zero;
                if (index == 0) {
                  radius = const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    bottomLeft: Radius.circular(24),
                  );
                } else if (index == section.imageUrls.length - 1) {
                  radius = const BorderRadius.only(
                    topRight: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  );
                }

                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: index == 0 ? 0 : 1,
                    ),
                    child: ClipRRect(
                      borderRadius: radius,
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.cover,
                        height: double.infinity,
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
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}