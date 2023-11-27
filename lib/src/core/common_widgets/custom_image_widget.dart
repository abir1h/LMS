import 'package:cached_network_image/cached_network_image.dart';
import '../constants/image_assets.dart';
import 'package:flutter/material.dart';

class CustomImageWidget extends StatelessWidget {
  final String image;
  final double? height;
  final double? width;
  final bool fromNetwork;
  final BoxFit boxFit;
  const CustomImageWidget(
      {super.key,
      required this.image,
      this.height,
      this.width,
      this.fromNetwork = true,
      this.boxFit = BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    if (fromNetwork == true) {
      return CachedNetworkImage(
        imageUrl: image,
        height: height,
        width: width,
        // imageBuilder: (context, imageProvider) => Container(
        //   decoration: BoxDecoration(
        //     image: DecorationImage(
        //       image: imageProvider,
        //       fit: BoxFit.fill,
        //     ),
        //   ),
        // ),
        placeholder: (context, url) =>
            Image.asset(ImageAssets.imgPlaceholder),
        errorWidget: (context, url, error) =>
            Image.asset(ImageAssets.imgPlaceholder),
        fit: boxFit,
      );
    } else {
      return Image.asset(
        image,
        height: height,
        width: width,
        fit: boxFit,
      );
    }
  }
}
