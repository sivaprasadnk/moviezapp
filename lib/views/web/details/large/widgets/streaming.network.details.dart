import 'package:flutter/material.dart';
import 'package:moviezapp/views/common/custom.cache.image.dart';
import 'package:moviezapp/views/common/section.title.dart';

class StreamingNetworkDetails extends StatelessWidget {
  const StreamingNetworkDetails({
    super.key,
    required this.networks,
    required this.networkPath,
    required this.id,
  });

  final List networks;
  final String networkPath;
  final int id;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (networks.isNotEmpty && networkPath.isNotEmpty)
          const SectionTitle(title: 'Streaming on'),
        if (networks.isNotEmpty && networkPath.isNotEmpty)
          const SizedBox(height: 20),
        if (networks.isNotEmpty && networkPath.isNotEmpty)
          Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              height: 100,
              child: CustomCacheImageWithoutSize(
                imageUrl: networkPath,
                loadingHeight: 100,
                cacheKey: 'show_${id}network',
                borderRadius: 8,
                showPlaceHolder: false,
              ),
            ),
          ),
        if (networks.isNotEmpty && networkPath.isNotEmpty)
          Text(networks[0]['name']),
      ],
    );
  }
}
