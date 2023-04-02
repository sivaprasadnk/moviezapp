import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'edit.icon.dart';

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
        if (user!.photoURL != null && user.photoURL!.isNotEmpty)
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
              user.photoURL!,
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
          children: [
            !isGuest
                ? Text(
                    user.displayName != null
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
                user.email!,
                style: const TextStyle(
                    fontWeight: FontWeight.w200, color: Colors.grey),
              ),
            const SizedBox(height: 8),
            if (!isGuest)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.amber,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.person,
                      size: 12,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Premium',
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              )
          ],
        ),
        const Spacer(),
        const EditIcon(),
      ],
    );
  }
}
