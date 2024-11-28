import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCachedImageNetwork extends StatelessWidget {
  final String imageUrl;
  final double height, weight;
  final BoxFit? boxfit;
  final bool? errorWidget;
  const CustomCachedImageNetwork({super.key, required this.imageUrl, required this.height, required this.weight, this.boxfit, this.errorWidget});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        height: height,
        width: weight,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: imageProvider,
              fit: boxfit ?? BoxFit.fill,
              colorFilter:
              ColorFilter.mode(Colors.white, BlendMode.colorBurn),
          ),
        ),
      ),
      placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context, url, error) => errorWidget == true ? const SizedBox.shrink() : Icon(Icons.person, size: 50,),
    );
  }
}
