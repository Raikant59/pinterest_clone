import 'package:flutter/material.dart';
import '../../../utils/app_responsive.dart';

class PersonalizedIcon extends StatelessWidget {
  const PersonalizedIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final double rightPadding =
    AppResponsive.w(context, 4).clamp(2.0, 6.0);
    final double boxSize =
    AppResponsive.r(context, 38).clamp(34.0, 42.0);
    final double radius =
    AppResponsive.r(context, 15).clamp(12.0, 17.0);
    final double iconSize =
    AppResponsive.r(context, 18).clamp(16.0, 20.0);

    return Padding(
      padding: EdgeInsets.only(right: rightPadding),
      child: Container(
        width: boxSize,
        height: boxSize,
        decoration: BoxDecoration(
          color: const Color(0xFFE9E9E2),
          borderRadius: BorderRadius.circular(radius),
        ),
        alignment: Alignment.center,
        child: Icon(
          Icons.auto_awesome_outlined,
          size: iconSize,
          color: Colors.black,
        ),
      ),
    );
  }
}