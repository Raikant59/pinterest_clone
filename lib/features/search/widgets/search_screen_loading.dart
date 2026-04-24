import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SearchScreenLoading extends StatelessWidget {
  const SearchScreenLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFFE9E9E9),
      highlightColor: const Color(0xFFF8F8F8),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 10, 18, 0),
        child: Column(
          children: [
            Container(
              height: 72,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(26),
              ),
            ),
            const SizedBox(height: 18),
            Container(
              height: 640,
              color: Colors.white,
            ),
            const SizedBox(height: 20),
            Container(
              width: 200,
              height: 18,
              color: Colors.white,
            ),
            const SizedBox(height: 12),
            Container(
              width: 260,
              height: 34,
              color: Colors.white,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Container(color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}