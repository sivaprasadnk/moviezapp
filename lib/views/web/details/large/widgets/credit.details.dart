import 'package:flutter/material.dart';
import 'package:moviezapp/model/actors.model.dart';
import 'package:moviezapp/model/crew.model.dart';
import 'package:moviezapp/views/common/actors.list.dart';
import 'package:moviezapp/views/common/crew.list.dart';
import 'package:moviezapp/views/common/section.title.dart';

class CreditDetails extends StatelessWidget {
  const CreditDetails({
    super.key,
    required this.actorsList,
    required this.crewList,
  });

  final List<Actor> actorsList;
  final List<Crew> crewList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (actorsList.isNotEmpty) const SectionTitle(title: 'Cast'),
        const SizedBox(height: 20),
        AnimatedSwitcher(
          duration: const Duration(
            seconds: 1,
          ),
          child: ActorsList(
            actorsList: actorsList,
          ),
        ),
        if (crewList.isNotEmpty) const SectionTitle(title: 'Crew'),
        const SizedBox(height: 20),
        AnimatedSwitcher(
          duration: const Duration(
            seconds: 1,
          ),
          child: CrewList(
            crewList: crewList,
          ),
        ),
      ],
    );
    
  }
}
