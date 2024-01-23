import 'package:flutter/material.dart';

Route createRoute(Widget a) {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => a,
      transitionDuration: Duration(seconds: 2),
      reverseTransitionDuration: Duration(seconds: 2),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // animation value between 0->1
        // print(animation);
        // this detect start and end of animation
        const begin = Offset(1, 0);
        const end = Offset(0, 0);
        // aniation type
        const curve = Curves.easeInCirc;
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: child,
        );
      });
}
