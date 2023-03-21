import 'package:flutter/material.dart';
import 'package:moviezapp/views/common/page.title.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        PageTitle(title: 'Activity'),
      ],
    );
  }
}
