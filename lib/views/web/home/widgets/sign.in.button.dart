import 'package:flutter/material.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/utils/extensions/widget.extensions.dart';
import 'package:moviezapp/views/common/common.button.dart';

import '../../../common/section.title.dart';

class SigninButton extends StatelessWidget {
  const SigninButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showSignInDialog(context);
      },
      child: const Text("Sign In"),
    ).addMousePointer;
  }

  showSignInDialog(BuildContext context) async {
    await showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (context) {
        return AlertDialog(
          title: const SectionTitle(title: 'Sign In'),
          content: StatefulBuilder(builder: (_, setState) {
            return Container(
              width: context.width * 0.3,
              color: context.bgColor,
              height: context.height * 0.2,
              child: Column(
                children: [
                  CommonButton(
                    callback: () {
                      googleSignin(context);
                    },
                    title: 'Sign In with Google',
                  ),
                ],
              ),
            );
          }),
          actions: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: GestureDetector(
                onTap: () {
                  context.pop();
                },
                child: const Text(
                  'Close',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ).addMousePointer,
            ),
            const SizedBox(width: 10),
          ],
        );
      },
    );
  }

  googleSignin(BuildContext context) async {
    // Dialogs.showLoader(context: context);

    context.authProvider.signInWithGoogle(
      false,
      context,
    );
  }
}
