import 'package:flutter/material.dart';
import 'package:moviezapp/provider/movies.provider.dart';
import 'package:moviezapp/views/common/actors.list.dart';
import 'package:moviezapp/views/common/crew.list.dart';
import 'package:moviezapp/views/common/section.title.dart';
import 'package:provider/provider.dart';

class CreditDetails extends StatelessWidget {
  const CreditDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MoviesProvider>(
      builder: (_, provider, __) {
        debugPrint('crew length : ${provider.crewList.length}');
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!provider.actorsListLoading)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (provider.actorsList.isNotEmpty)
                    const SectionTitle(title: 'Cast'),
                  const SizedBox(height: 20),
                  AnimatedSwitcher(
                    duration: const Duration(
                      seconds: 1,
                    ),
                    child: !provider.actorsListLoading
                        ? const ActorsList()
                        : const SizedBox.shrink(),
                  ),
                  if (provider.crewList.isNotEmpty)
                    const SectionTitle(title: 'Crew'),
                  const SizedBox(height: 20),
                  AnimatedSwitcher(
                    duration: const Duration(
                      seconds: 1,
                    ),
                    child: !provider.actorsListLoading
                        ? const CrewList()
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
          ],
        );
      },
    );
  }
}
