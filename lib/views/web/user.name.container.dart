import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';

class UserDetailsContainer extends StatelessWidget {
  const UserDetailsContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var isGuest = context.authProvider.isGuestUser;
    User? user;
    if (!isGuest) {
      user = FirebaseAuth.instance.currentUser!;
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(
              radius: 20,
              child: Icon(
                Icons.person,
              ),
            ),
            const SizedBox(width: 10),
            !isGuest
                ? Text(
                    user!.displayName!,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  )
                : const Text(
                    'Hi, Guest',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
          ],
        ),
      ],
    );
  }
}
