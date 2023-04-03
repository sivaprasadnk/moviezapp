import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';


class ProfileDetails extends StatelessWidget {
  const ProfileDetails({
    super.key,
    required this.isGuest,
  });
  final bool isGuest;

  @override
  Widget build(BuildContext context) {
    User? user;
    if (!isGuest) {
      user = FirebaseAuth.instance.currentUser!;
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (user != null && user.photoURL != null && user.photoURL!.isNotEmpty)
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
              user.photoURL!,
              height: 80,
              width: 80,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.error);
              },
            ),
          )
        else
        const CircleAvatar(
          radius: 35,
          child: Icon(
            Icons.person,
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 12),

            !isGuest
                ? Text(
                    user != null && user.displayName != null
                        ? user.displayName!
                        : "(no displayname)",
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  )
                : const Text(
                    'Guest',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
            const SizedBox(height: 5),
            if (!isGuest)
              Text(
                user!.email!,
                style: TextStyle(
                  fontWeight: FontWeight.w200,
                  color: context.highlightColor.withOpacity(0.85),
                ),
              ),
            const SizedBox(height: 8),
              
          ],
        ),
        const Spacer(),
      ],
    );
  }
}
