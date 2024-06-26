import 'dart:ui';

import 'package:flutter/material.dart';

class BlurredBackground extends StatelessWidget {
  const BlurredBackground({
    super.key,
    required this.child,
    this.blur = 5.0,
    this.radius,
  });

  final Widget child;
  final double blur;
  final double? radius;

  @override
  Widget build(BuildContext context) => Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(radius ?? 16),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          child,
        ],
      );
}
