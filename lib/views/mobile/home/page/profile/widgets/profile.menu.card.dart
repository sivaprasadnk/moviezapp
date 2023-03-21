import 'package:flutter/material.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';

class ProfileMenuCard extends StatelessWidget {
  const ProfileMenuCard({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
    this.showtrailing = true,
    this.isCountItem = false,
    this.count = 0,
    this.isImplemented = false,
  });

  final String title;
  final IconData icon;
  final bool showtrailing;
  final bool isCountItem;
  final int count;
  final VoidCallback? onTap;
  final bool isImplemented;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (isImplemented) {
          onTap!.call();
        } else {
          context.scaffoldMessenger.showSnackBar(
            const SnackBar(
              content: Text("Not Implemented"),
            ),
          );
        }
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
          color: Colors.grey.withOpacity(0.2),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 12),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.black45,
              size: 18,
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(
                color: Colors.black45,
                fontSize: 12,
              ),
            ),
            const Spacer(),
            if (showtrailing)
              if (isCountItem)
                Text(
                  count.toString(),
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                )
              else
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.grey,
                  size: 15,
                ),
          ],
        ),
      ),
    );
  }
}
