import 'package:flutter/material.dart';

import '../../../res/themes/app_mode.dart';

class DrawerHeaderWidget extends StatelessWidget {
  final String drawerHeaderImageUrl;
  final String drawerHeaderText;
  const DrawerHeaderWidget({
    super.key,
    required this.drawerHeaderImageUrl,
    required this.drawerHeaderText,
  });

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: BoxDecoration(
          color: lightMode.scaffoldBackgroundColor,
          image: DecorationImage(
              opacity: 0.4,
              image: AssetImage(drawerHeaderImageUrl),
              fit: BoxFit.cover)),
      child: Center(
          child: Text(
        drawerHeaderText,
        style: const TextStyle(
          fontSize: 28,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      )),
    );
  }
}
