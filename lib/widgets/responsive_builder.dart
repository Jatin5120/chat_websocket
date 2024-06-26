import 'package:chat_assignment/utils/utils.dart';
import 'package:flutter/material.dart';

class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
    this.desktopLarge,
  });

  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;
  final Widget? desktopLarge;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          final width = MediaQuery.of(context).size.width;
          var type = LayoutType.fromWidth(width);
          return switch (type) {
            LayoutType.mobile => mobile,
            LayoutType.tablet => tablet ?? mobile,
            LayoutType.desktop => desktop ?? tablet ?? mobile,
            LayoutType.desktopLarge => desktopLarge ?? desktop ?? tablet ?? mobile,
          };
        },
      );
}
