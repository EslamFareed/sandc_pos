import 'package:flutter/material.dart';

class DefaultFadeInNetworkImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit? boxFit;
  const DefaultFadeInNetworkImage({
    Key? key,
    required this.imageUrl,
    this.boxFit = BoxFit.contain,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInImage(
      image: NetworkImage(
        imageUrl,
      ),
      fit: boxFit,
      placeholderFit: boxFit,
      placeholderErrorBuilder:
          (BuildContext context, obj, StackTrace? stackTrace) {
        return const Icon(
          Icons.error,
          color: Colors.red,
        );
      },
      placeholder: const AssetImage(
        "assets/images/placeholder.png",
      ),
    );
  }
}
