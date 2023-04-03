import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/oauth2/v2.dart' as oath;
import 'package:moviezapp/repo/user/user.repo.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/utils/string.constants.dart';
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

    final GoogleSignIn googleSignIn = GoogleSignIn.standard(
        // scopes: [drive.DriveApi.driveFileScope],
      scopes: [
        'email',
        oath.Oauth2Api.userinfoEmailScope,
      ],
    );

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
        // if (userCredential.additionalUserInfo != null &&
        //     userCredential.additionalUserInfo!.isNewUser) {
        //   var user = userCredential.user!;
        //   // await user.updateDisplayName(user.displayName);
        //   // await UserRepo.addUserDetails();
        //   // var user = FirebaseAuth.instance.currentUser!;

        //   userColllection.doc(user.uid).set({
        //     kEmail: user.email,
        //     kDisplayName: user.displayName,
        //     kBookMarkedMovieIdList: [],
        //     kBookMarkedShowIdList: [],
        //     kCreatedDateTime: DateTime.now(),
        //   });
        //   return user;
        // } else {
        //   return userCredential.user;
        // }
        var user = userCredential.user!;
        // await user.updateDisplayName(user.displayName);
        // await UserRepo.addUserDetails();
        // var user = FirebaseAuth.instance.currentUser!;
        //     userCredential.additionalUserInfo!.isNewUser))
        if (userCredential.additionalUserInfo != null &&
            userCredential.additionalUserInfo!.isNewUser) {
          await user.updateDisplayName(user.displayName);

          userColllection.doc(user.uid).set({
            kEmail: user.email,
            kDisplayName: user.displayName,
            kBookMarkedMovieIdList: [],
            kBookMarkedShowIdList: [],
            kCreatedDateTime: DateTime.now(),
          });
        }
        return user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          if (context.mounted) {
            context.showSnackbar(
                'The account already exists with a different credential');
          }
        } else if (e.code == 'invalid-credential') {
          if (context.mounted) {
            context.showSnackbar(
                'Error occurred while accessing credentials. Try again.');
          }
        }
        return null;
      } catch (e) {
        if (context.mounted) {
          context
              .showSnackbar('Error occurred using Google Sign In. Try again.');
        }
        return null;
      }
    } else {
      return null;
    }
  }
}
