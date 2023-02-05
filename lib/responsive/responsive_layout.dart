import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/dimension.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget webLayout;
  final Widget mobileLayout;
  const ResponsiveLayout(
      {super.key, required this.webLayout, required this.mobileLayout});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (p0, p1) {
        if (p1.maxWidth > webScreenSize) {
          return webLayout;
        }
        return mobileLayout;
      },
    );
  }
}
