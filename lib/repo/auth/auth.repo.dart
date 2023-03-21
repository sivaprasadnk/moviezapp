import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moviezapp/repo/user/user.repo.dart';

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
}
