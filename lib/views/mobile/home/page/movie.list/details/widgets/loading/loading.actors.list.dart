import 'package:flutter/material.dart';
import 'package:moviezapp/views/common/loading.shimmer.dart';

class LoadingActorsList extends StatelessWidget {
  const LoadingActorsList({super.key});

  @override
  Widget build(BuildContext context) {
    var size = 120;
    double height = 150;
    return SizedBox(
      height: height,
      width: double.infinity,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) {
          return const SizedBox(width: 30);
        },
        itemCount: 5,
        itemBuilder: (context, index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LoadingShimmer(
                child: Container(
                  height: size - 10,
                  width: size - 10,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              LoadingShimmer(
                child: Container(
                  height: 7,
                  width: 20,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
            ],
          );
        },
      ),
    );
  }
}
