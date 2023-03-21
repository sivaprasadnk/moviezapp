import 'package:flutter/material.dart';
import 'package:moviezapp/provider/movies.provider.dart';
import 'package:moviezapp/views/common/region.select.screen.dart';
import 'package:provider/provider.dart';

class CountrySelectContainer extends StatelessWidget {
  const CountrySelectContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MoviesProvider>(
      builder: (_, provider, __) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return const RegionSelectScreenMobile();
                }));
              },
              child: const Icon(
                Icons.settings,
                size: 25,
              ),
            ),
            const SizedBox(width: 15),
          ],
        );
      },
    );
  }
}
