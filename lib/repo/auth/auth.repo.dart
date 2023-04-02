import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:moviezapp/repo/user/user.repo.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';

class AuthRepo {
  /// register
  static Future<void> register(
      String emailAddress, String password, String userName) async {
    var userDetails =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );
    await userDetails.user!.updateDisplayName(userName);
    await UserRepo.addUserDetails();
    return;
  }

  static Future logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      final GoogleSignIn googleSignIn = GoogleSignIn();

      if (await googleSignIn.isSignedIn()) {
        // await googleSignIn.disconnect();
        await googleSignIn.signOut();
      } else {}
    } catch (e) {
      debugPrint(e.toString());
    }
    return;
  }

  static Future<UserCredential?> signIn(
      String emailAddress, String password) async {
    UserCredential? user;
    user = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );
    return user;
  }

  static Future resetPassword(String emailAddress) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(
      email: emailAddress,
    );
    return;
  }

  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);
        if (userCredential.additionalUserInfo!.isNewUser) {
          debugPrint('is new user');
          await userCredential.user!
              .updateDisplayName(userCredential.user!.displayName);
          await UserRepo.addUserDetails();
          return userCredential.user;
        } else {
          debugPrint('is existing user');
          return userCredential.user;
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          if (context.mounted) {
            context.scaffoldMessenger.showSnackBar(const SnackBar(
                content: Text(
                    'The account already exists with a different credential')));
          }
        } else if (e.code == 'invalid-credential') {
          if (context.mounted) {
            context.scaffoldMessenger.showSnackBar(const SnackBar(
                content: Text(
                    'Error occurred while accessing credentials. Try again.')));
          }
        }
        return null;
      } catch (e) {
        if (context.mounted) {
          context.scaffoldMessenger.showSnackBar(const SnackBar(
              content:
                  Text('Error occurred using Google Sign In. Try again.')));
        }
        return null;
      }
    } else {
      return null;
    }
  }
}
