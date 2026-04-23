import 'package:flutter/material.dart';
class PersonalizedIcon extends StatelessWidget {
  const PersonalizedIcon();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4),
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: const Color(0xFFE9E9E2),
          borderRadius: BorderRadius.circular(15),
        ),
        alignment: Alignment.center,
        child: const Icon(
          Icons.auto_awesome_outlined,
          size: 18,
          color: Colors.black,
        ),
      ),
    );
  }
}