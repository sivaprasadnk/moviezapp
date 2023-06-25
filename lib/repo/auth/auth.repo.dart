import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:moviezapp/repo/user/user.repo.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/utils/notification.service.dart';
import 'package:moviezapp/utils/string.constants.dart';

class AuthRepo {
  static final auth = FirebaseAuth.instance;
  static FirebaseFunctions functions = FirebaseFunctions.instance;
  static final logger = Logger();

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
      // await sendSignOutNotification();
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
        return await updateUserData(userCredential);
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
    // debugPrint('@@@@@@@2@@1');

    if (context.isMobileApp) {
      // logger.d('is mobile app');

      // try {
      final GoogleSignIn googleSignIn = GoogleSignIn.standard(
        scopes: [
          'email',
        ],
      );
      // logger.d('@@1');
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        // logger.d('@@12');

        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        // logger.d('@@123');

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        // logger.d('@@1234');

        final UserCredential userCredential =
            await auth.signInWithCredential(credential);
        return await updateUserData(userCredential);
      } else {
        // logger.d('br return null @1');

        return null;
      }
      // } catch (err) {
      //   logger.d('error : $err');
      //   if (context.mounted) {
      //     context
      //         .showSnackbar('Error occurred using Google Sign In. Try again.');
      //   }
      // }
    } else {
      GoogleAuthProvider googleProvider = GoogleAuthProvider();

      googleProvider
          .addScope('https://www.googleapis.com/auth/userinfo.profile');
      final UserCredential userCredential =
          await auth.signInWithPopup(googleProvider);

      return await updateUserData(userCredential);
    }
  }

  static Future<User?> signInWithFacebook({
    required BuildContext context,
  }) async {
    // try {
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
    return await updateUserData(userCredential);
    // } else {}
    // } on FirebaseAuthException catch (e) {
    //   debugPrint('FirebaseAuthException :');
    //   debugPrint(e.message);
    //   return null;
    // } catch (e) {
    //   if (context.mounted) {
    //     context.showSnackbar('Error occurred using Fb Sign In. Try again.');
    //   }
    // debugPrint('error :');
    // debugPrint(e.toString());
    // return null;
  }

  static Future<User> signInAndUpdateData(UserCredential userCredential) async {
    var user = userCredential.user!;
    var token = "";
    if (kIsWeb) {
      token = (await NotificationService.messaging.getToken(
        vapidKey:
            'BDnvMdJROjgfgvj5HrOVLJ20191IbhNFQ9M1SGvsG-1u5XlYGf8t5lRdf9p2GniONDbQ6hdf7MqGAkxEILJio_Y',
      ))!;
    } else {
      token = (await NotificationService.messaging.getToken())!;
    }

    if (userCredential.additionalUserInfo != null &&
        userCredential.additionalUserInfo!.isNewUser) {
      await user.updateDisplayName(user.displayName);

      await sendWelcomeEmail(user.email!);
      await sendWelcomeNotification(token);

      await userColllection.doc(user.uid).set({
        kEmail: user.email,
        kRating: 0,
        kDisplayName: user.displayName,
        kFcmToken: token,
        kBookMarkedMovieIdList: [],
        kAccountType: AccountType.googleSignIn.value,
        kBookMarkedShowIdList: [],
        kCreatedDateTime: DateTime.now(),
      });
    } else {
      debugPrint('@@ b4 sending signin notif user $token');

      await sendSignInNotification(token);

      debugPrint('@@ $user.uid is existing user');
    }
    logger.d('b4 updating token :$token');
    await userColllection.doc(user.uid).update({
      kFcmToken: token,
    });
    logger.d('after updating token :$token');

    return user;
  }

  static Future<User> updateUserData(UserCredential userCredential) async {
    var user = userCredential.user!;
    var token = (await NotificationService.messaging.getToken(
      vapidKey:
          'BDnvMdJROjgfgvj5HrOVLJ20191IbhNFQ9M1SGvsG-1u5XlYGf8t5lRdf9p2GniONDbQ6hdf7MqGAkxEILJio_Y',
    ))!;

    logger.d('b4 updating userdata');

    ///
    ///
    ///
    ///
    ///

    var configCollection =
        await FirebaseFirestore.instance.collection('config').get();
    var url = configCollection.docs[0].data()['updateUserDataUrl'];
    var bodyParams = {};

    if (userCredential.additionalUserInfo != null &&
        userCredential.additionalUserInfo!.isNewUser) {
      await user.updateDisplayName(user.displayName);
    }
    bodyParams = {
      kEmail: user.email,
      // kRating: "0",
      kUserId: user.uid,
      kDisplayName: user.displayName,
      kFcmToken: token,
      // kBookMarkedMovieIdList: [],
      kAccountType: AccountType.googleSignIn.value,
      // kBookMarkedShowIdList: <String>[],
      kCreatedDateTimeString: DateTime.now().toString(),
      kCreatedDateTime: DateTime.now().millisecondsSinceEpoch.toString(),
      kIsNewUser: userCredential.additionalUserInfo != null &&
              userCredential.additionalUserInfo!.isNewUser
          ? "1"
          : "0",
      'isWeb': kIsWeb ? "1" : "0",
    };

    debugPrint("url : $url");
    debugPrint("bodyParams : $bodyParams");

    await http.post(Uri.parse(url), body: bodyParams);
    logger.d('after updating token :$token');

    return user;
  }

  static Future sendWelcomeEmail(String email) async {
    try {
      var configCollection =
          await FirebaseFirestore.instance.collection('config').get();
      var url = configCollection.docs[0].data()['welcomeMailUrl'];

      await http.post(Uri.parse(url), body: {"email": email});
    } catch (err) {
      logger.e(err);
    }

    // Map<String, dynamic> templateParams = {
    //   'to_name': displayName,
    // };
    // try {
    //   await EmailJS.send(
    //     'service_mi2e9pc',
    //     'template_g91uu7v',
    //     templateParams,
    //     const Options(
    //       publicKey: '1XO7RDB4dwuTLa5gM',
    //       privateKey: 'LPGmoWPc-8-U51a0PK-V1',
    //     ),
    //   );
    //   debugPrint('SUCCESS!');
    // } catch (error) {
    //   debugPrint("error :$error");
    // }
  }

  static Future sendWelcomeNotification(String token) async {
    try {
      var configCollection =
          await FirebaseFirestore.instance.collection('config').get();
      var url = configCollection.docs[0].data()['signUpNotificationUrl'];

      await http.post(Uri.parse(url), body: {"token": token});
    } catch (err) {
      logger.e(err);
    }
  }

  static Future sendSignInNotification(String token) async {
    try {
      var configCollection =
          await FirebaseFirestore.instance.collection('config').get();
      var url = configCollection.docs[0].data()['signInNotificationUrl'];

      await http.post(Uri.parse(url), body: {"token": token});

      logger.d('@@ @1 b4 sending signin notif user $token');
    } catch (err) {
      logger.e(err);
    }
  }

  static Future sendSignOutNotification() async {
    var token = await NotificationService.messaging.getToken();
    try {
      var configCollection =
          await FirebaseFirestore.instance.collection('config').get();
      var url = configCollection.docs[0].data()['signOutNotificationUrl'];

      await http.post(Uri.parse(url), body: {"token": token});
    } catch (err) {
      logger.e(err);
    }
  }
}
