import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCacheImage extends StatelessWidget {
  const CustomCacheImage({
    super.key,
    required this.imageUrl,
    required this.height,
    required this.width,
    required this.cacheKey,
    required this.borderRadius,
  });

  final String imageUrl;
  final double height;
  final double width;
  final String cacheKey;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(borderRadius),
      ),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        cacheKey: cacheKey,
        height: height,
        width: width,
        fit: BoxFit.cover,
        errorWidget: (context, url, error) {
          return SizedBox(
            height: height,
            width: width,
            child: const Icon(Icons.error),
          );
        },
      ),
    );
  }
}

class CustomCacheImageWithoutSize extends StatelessWidget {
  const CustomCacheImageWithoutSize({
    super.key,
    required this.imageUrl,
    required this.cacheKey,
    required this.borderRadius,
  });

  final String imageUrl;
  final String cacheKey;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(borderRadius),
      ),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        cacheKey: cacheKey,
        fit: BoxFit.cover,
        errorWidget: (context, url, error) {
          return const SizedBox(
            height: 180,
            child: Center(
              child: Icon(Icons.error),
            ),
          );
        },
      ),
    );
  }
}
