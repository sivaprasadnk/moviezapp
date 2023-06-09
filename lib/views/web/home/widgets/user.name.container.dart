import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserNameContainerWeb extends StatelessWidget {
  const UserNameContainerWeb({super.key});

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    var name = 'Username';
    if (user!.displayName != null) {
      name = user.displayName!;
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (user.photoURL != null && user.photoURL!.isNotEmpty)
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
              user.photoURL!,
              height: 45,
              width: 45,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.error);
              },
            ),
          ),
        const SizedBox(width: 10),
        Text("Hi, $name"),
      ],
    );
  }
}
