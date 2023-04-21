import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class RatingProgressContainer extends StatelessWidget {
  const RatingProgressContainer(
      {super.key, required this.vote, required this.isWeb});

  final double vote;
  final bool isWeb;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        if (vote > 0)
          Container(
            height: 28,
            width: 28,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromRGBO(8, 28, 34, 1),
            ),
            child: Center(
              child: Text(
                ((vote * 10).ceilToDouble()).toInt().toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isWeb ? 12 : 12,
                ),
              ),
            ),
          ),
        if (vote > 0)
          CircularPercentIndicator(
            radius: 18.0,
            lineWidth: 5.0,
            animation: true,
            backgroundColor: const Color.fromRGBO(8, 28, 34, 0.9),
            circularStrokeCap: CircularStrokeCap.round,
            percent: (vote / 10),
            progressColor: Colors.green,
          )
      ],
    );
  }
}
