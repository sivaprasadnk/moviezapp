import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emailjs/emailjs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:moviezapp/repo/user/user.repo.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/utils/string.constants.dart';

class AuthRepo {
  static final auth = FirebaseAuth.instance;

  /// register
  static Future<void> register(
      String emailAddress, String password, String userName) async {
    var userDetails = await auth.createUserWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );
    await userDetails.user!.updateDisplayName(userName);
    await UserRepo.addUserDetails();
    return;
  }

  static Future logout() async {
    try {
      await auth.signOut();
      final GoogleSignIn googleSignIn = GoogleSignIn();

      if (await googleSignIn.isSignedIn()) {
        await googleSignIn.signOut();
      }
      // final AccessToken? accessToken = await FacebookAuth.instance.accessToken;
      // if (accessToken != null) {
      //   await FacebookAuth.instance.logOut();
      // }
    } catch (e) {
      debugPrint(e.toString());
    }
    return;
  }

  static Future<UserCredential?> signIn(
      String emailAddress, String password) async {
    UserCredential? user;
    user = await auth.signInWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );
    return user;
  }

  static Future<String> checkIfEmailIdRegistered(String email) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await userColllection.get();
    for (var doc in snapshot.docs) {
      if (doc.data()['email'] == email) {
        return doc.data()[kAccountType];
      }
    }
    return '';
  }

  static Future resetPassword(String emailAddress) async {
    await auth.sendPasswordResetEmail(
      email: emailAddress,
    );
    return;
  }

  static Future<User?> signInWithGoogleForApp(
      {required BuildContext context}) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn.standard(
        scopes: [
          'email',
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

        final UserCredential userCredential =
            await auth.signInWithCredential(credential);
        return await signInAndUpdateData(userCredential);
      } else {
        return null;
      }
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
    } catch (err) {
      if (context.mounted) {
        context.showSnackbar('Error occurred using Google Sign In. Try again.');
      }
    }
    return null;
  }

  static Future<User?> signInWithGoogle({required BuildContext context}) async {
debugPrint('@@@@@@@2@@1');
    {
      if (context.isMobileApp) {
debugPrint('@@@@@@@2@@12');

        try {
          final GoogleSignIn googleSignIn = GoogleSignIn.standard(
            scopes: [
              'email',
            ],
          );
debugPrint('@@1');
          final GoogleSignInAccount? googleSignInAccount =
              await googleSignIn.signIn();
          if (googleSignInAccount != null) {
debugPrint('@@12');

            final GoogleSignInAuthentication googleSignInAuthentication =
                await googleSignInAccount.authentication;
debugPrint('@@123');

            final AuthCredential credential = GoogleAuthProvider.credential(
              accessToken: googleSignInAuthentication.accessToken,
              idToken: googleSignInAuthentication.idToken,
            );
debugPrint('@@1234');

            final UserCredential userCredential =
                await auth.signInWithCredential(credential);
            return await signInAndUpdateData(userCredential);
          } else {
            return null;
          }
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
        } catch (err) {
          if (context.mounted) {
            context.showSnackbar(
                'Error occurred using Google Sign In. Try again.');
          }
        }
      } else {
debugPrint('@@@@@@@2@@13e232');

        GoogleAuthProvider googleProvider = GoogleAuthProvider();

        googleProvider
            .addScope('https://www.googleapis.com/auth/userinfo.profile');
        // googleProvider.setCustomParameters({'login_hint': 'user@example.com'});
        final UserCredential userCredential =
            await auth.signInWithPopup(googleProvider);

        return await signInAndUpdateData(userCredential);
      }
    }
    return null;
  }

  static Future<User?> signInWithFacebook({
    required BuildContext context,
  }) async {
    try {
      FacebookAuthProvider facebookProvider = FacebookAuthProvider();

      facebookProvider.addScope('email');
      facebookProvider.setCustomParameters({
        'display': 'popup',
        "consent": "select_account",
      });

      // Once signed in, return the UserCredential
      final UserCredential userCredential =
          await auth.signInWithPopup(facebookProvider);
      // final LoginResult result = await FacebookAuth.instance.login();
      // if (result.status == LoginStatus.success) {
      //   final AccessToken accessToken = result.accessToken!;
      //   final AuthCredential credential =
      //       FacebookAuthProvider.credential(accessToken.token);
      //   final UserCredential userCredential =
      //       await FirebaseAuth.instance.signInWithCredential(credential);
      return await signInAndUpdateData(userCredential);
      // } else {}
    } on FirebaseAuthException catch (e) {
      debugPrint('FirebaseAuthException :');
      debugPrint(e.message);
      return null;
    } catch (e) {
      if (context.mounted) {
        context.showSnackbar('Error occurred using Fb Sign In. Try again.');
      }
      debugPrint('error :');
      debugPrint(e.toString());
      return null;
    }
  }

  static Future<User?> signInAndUpdateData(
      UserCredential userCredential) async {
    var user = userCredential.user!;
    if (userCredential.additionalUserInfo != null &&
        userCredential.additionalUserInfo!.isNewUser) {
debugPrint('@@123456 is newuser');

      await user.updateDisplayName(user.displayName);

      await sendWelcomeEmail(user.displayName!);

      await userColllection.doc(user.uid).set({
        kEmail: user.email,
        kRating: 0,
        kDisplayName: user.displayName,
        kBookMarkedMovieIdList: [],
        kAccountType: AccountType.googleSignIn.value,
        kBookMarkedShowIdList: [],
        kCreatedDateTime: DateTime.now(),
      });
    }
    return user;
  }

  static Future sendWelcomeEmail(String displayName) async {
    Map<String, dynamic> templateParams = {
      'to_name': displayName,
    };
    try {
      await EmailJS.send(
        'service_mi2e9pc',
        'template_g91uu7v',
        templateParams,
        const Options(
          publicKey: '1XO7RDB4dwuTLa5gM',
          privateKey: 'LPGmoWPc-8-U51a0PK-V1',
        ),
      );
      debugPrint('SUCCESS!');
    } catch (error) {
      debugPrint("error :$error");
    }
  }
}
