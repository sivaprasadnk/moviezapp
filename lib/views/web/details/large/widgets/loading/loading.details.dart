import 'package:flutter/material.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/views/common/loading.shimmer.dart';
import 'package:moviezapp/views/common/section.title.dart';

class LoadingDetails extends StatelessWidget {
  const LoadingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.width * 0.1),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            const SectionTitle(title: 'Story'),
            const SizedBox(height: 20),
            LoadingShimmer(
              child: Container(
                height: 20,
                width: context.width * 0.7,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            LoadingShimmer(
              child: Container(
                height: 20,
                width: context.width * 0.7,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            const SectionTitle(title: 'Cast'),
            const SizedBox(height: 20),
            SizedBox(
              height: 270,
              width: double.infinity,
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) {
                  return const SizedBox(width: 30);
                },
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      LoadingShimmer(
                        child: Container(
                          height: 170,
                          width: 170,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      LoadingShimmer(
                        child: Container(
                          width: 100,
                          height: 10,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      LoadingShimmer(
                        child: Container(
                          width: 100,
                          height: 10,
                          color: Colors.black,
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            const SectionTitle(title: 'Crew'),
            const SizedBox(height: 20),
            SizedBox(
              height: 270,
              width: double.infinity,
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) {
                  return const SizedBox(width: 30);
                },
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      LoadingShimmer(
                        child: Container(
                          height: 170,
                          width: 170,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      LoadingShimmer(
                        child: Container(
                          width: 100,
                          height: 10,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      LoadingShimmer(
                        child: Container(
                          width: 100,
                          height: 10,
                          color: Colors.black,
                        ),
                      )
                    ],
                  );
                },
              ),
            ),

            // const SectionTitle(title: 'Cast'),
            // const SizedBox(height: 20),
            // SizedBox(
            //   height: 270,
            //   width: double.infinity,
            //   child: ListView.separated(
            //     shrinkWrap: true,
            //     scrollDirection: Axis.horizontal,
            //     separatorBuilder: (context, index) {
            //       return const SizedBox(width: 30);
            //     },
            //     itemCount: 5,
            //     itemBuilder: (context, index) {
            //       return Column(
            //         mainAxisSize: MainAxisSize.min,
            //         children: [
            //           LoadingShimmer(
            //             child: Container(
            //               height: 170,
            //               width: 170,
            //               decoration: const BoxDecoration(
            //                 shape: BoxShape.circle,
            //                 color: Colors.grey,
            //               ),
            //             ),
            //           ),
            //           const SizedBox(height: 8),
            //           const LoadingShimmer(
            //             child: SizedBox(
            //               width: 160,
            //               height: 20,
            //             ),
            //           ),
            //           const SizedBox(height: 8),
            //         ],
            //       );
            //     },
            //   ),
            // ),
            // const SectionTitle(title: 'Crew'),
            // const SizedBox(height: 20),
            // SizedBox(
            //   height: 270,
            //   width: double.infinity,
            //   child: ListView.separated(
            //     shrinkWrap: true,
            //     scrollDirection: Axis.horizontal,
            //     separatorBuilder: (context, index) {
            //       return const SizedBox(width: 30);
            //     },
            //     itemCount: 5,
            //     itemBuilder: (context, index) {
            //       return Column(
            //         mainAxisSize: MainAxisSize.min,
            //         children: [
            //           LoadingShimmer(
            //             child: Container(
            //               height: 170,
            //               width: 170,
            //               decoration: const BoxDecoration(
            //                 shape: BoxShape.circle,
            //                 color: Colors.grey,
            //               ),
            //             ),
            //           ),
            //           const SizedBox(height: 8),
            //           const LoadingShimmer(
            //             child: SizedBox(
            //               width: 160,
            //               height: 20,
            //             ),
            //           ),
            //           const SizedBox(height: 8),
            //         ],
            //       );
            //     },
            //   ),
            // ),
            // SizedBox(height: 40),
            // SizedBox(height: 40),
            // CopyrightText(),
          ],
        ),
      ),
    );
  }
}
