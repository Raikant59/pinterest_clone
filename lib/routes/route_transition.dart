import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

CustomTransitionPage<void> buildAuthSlidePage({
  required LocalKey key,
  required Widget child,
}) {
  return CustomTransitionPage<void>(
    key: key,
    transitionDuration: const Duration(milliseconds: 280),
    reverseTransitionDuration: const Duration(milliseconds: 280),
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final primaryTween = Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero,
      ).chain(
        CurveTween(curve: Curves.easeOutCubic),
      );

      final secondaryTween = Tween<Offset>(
        begin: Offset.zero,
        end: const Offset(-0.08, 0),
      ).chain(
        CurveTween(curve: Curves.easeOutCubic),
      );

      return SlideTransition(
        position: secondaryAnimation.drive(secondaryTween),
        child: SlideTransition(
          position: animation.drive(primaryTween),
          child: child,
        ),
      );
    },
  );
}