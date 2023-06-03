import 'package:flutter/material.dart';

class EditIcon extends StatelessWidget {
  const EditIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
    // return Consumer<AuthProvider>(builder: (_, provider, __) {
    //   var isGuest = provider.isGuestUser;

    //   return !isGuest
    //       ? CircleAvatar(
    //           radius: 13,
    //           backgroundColor: Colors.grey.withOpacity(0.4),
    //           child: const Icon(
    //             Icons.edit,
    //             size: 12,
    //             color: Colors.black,
    //           ),
    //         )
    //       : const SizedBox.shrink();
    // });
  }
}
