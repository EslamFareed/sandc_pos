import 'package:flutter/material.dart';

import '../utils/navigation_utility.dart';

class LogoIcon extends StatelessWidget {
  const LogoIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ImageIcon(
      AssetImage(
        "assets/images/logo.png",
      ),
      size: 130,
    );
  }
}

class BackIcon extends StatelessWidget {
  const BackIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.adaptive.arrow_back_outlined,
      ),
      onPressed: () {
        NavigationUtils.navigateBack(context: context);
      },
    );
  }
}
