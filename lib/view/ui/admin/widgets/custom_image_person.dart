import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomImagePerson extends StatelessWidget {
  CustomImagePerson(this.url, this.size, {Key? key}) : super(key: key);
  String url;
  double size;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      margin: const EdgeInsets.only(right: 2),
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: url,
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) =>
              const Icon(Icons.person_outline),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
