import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moviezapp/repo/auth/auth.repo.dart';
import 'package:moviezapp/repo/user/user.repo.dart';
import 'package:moviezapp/utils/custom.exception.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/views/mobile/home/home.screen.dart';
import 'package:moviezapp/views/mobile/splash.screen/splash.screen.dart';
import 'package:moviezapp/views/web/home/home.screen.web.dart';

class AuthProvider extends ChangeNotifier {
  bool _isGuestUser = true;
  bool get isGuestUser => _isGuestUser;

  void updateGuestUser(bool value) {
    _isGuestUser = value;
    notifyListeners();
  }

  // UserCredential? _userCredential;
  // UserCredential? get userCredential => _userCredential;

  // void updateUser(UserCredential user) {
  //   _userCredential = user;
  //   notifyListeners();
  // }

  Future register(String emailAddress, String password, String confirmPassword,
      String userName, BuildContext context) async {
    try {
      context.unfocus();

      if (emailAddress.isEmpty) {
        throw CustomException('Email Address cannot be empty !');
      }
      if (password.isEmpty) {
        throw CustomException('Password cannot be empty !');
      }
      if (password != confirmPassword) {
        throw CustomException("Passwords doesn't match!");
      }
      if (userName.isEmpty) {
        throw CustomException("Username cannot be empty!");
      }
      updateGuestUser(false);

      await AuthRepo.register(emailAddress, password, userName);
      if (context.mounted) {
        context.pop();
        if (context.isMobileApp) {
          Navigator.pushReplacementNamed(context, HomeScreenMobile.routeName);
        } else {
          Navigator.pushReplacementNamed(context, HomeScreenWeb.routeName);
        }

      }
    } on CustomException catch (exc) {
      context.pop();
      context.showErrorToast(exc.message);
    } on FirebaseAuthException catch (e) {
      context.pop();

      var message = "";
      if (e.code == 'weak-password') {
        message = "The password provided is too weak.";
      } else if (e.code == 'email-already-in-use') {
        message = "The account already exists for that email.";
      } else {
        message = e.code;
      }
      context.showErrorToast(message);
    }
  }

  Future signIn(
    String emailAddress,
    String password,
    BuildContext context,
    bool isApp,
  ) async {
    try {
      context.unfocus();
      if (emailAddress.isEmpty) {
        throw CustomException('Email Address cannot be empty !');
      }
      if (password.isEmpty) {
        throw CustomException('Password cannot be empty !');
      }

      var accountType = await AuthRepo.checkIfEmailIdRegistered(emailAddress);
      if (accountType.isNotEmpty) {
        if (accountType == AccountType.emailPassword.value) {
          await AuthRepo.signIn(emailAddress, password).then((userCredential) {
            if (userCredential != null) {
              context.pop();
              updateGuestUser(false);
              if (isApp) {
                Navigator.pushReplacementNamed(
                    context, HomeScreenMobile.routeName);
              } else {
                Navigator.pushReplacementNamed(
                    context, HomeScreenWeb.routeName);
              }
            } else {
              context.pop();
            }
          });
        } else {
          if (context.mounted) {
            context.pop();
            var msg =
                "Account doesn't have a password. Try login via Google SignIn!";
            context.showErrorToast(msg);
          }
        }
      } else {
        if (context.mounted) {
          var msg = "Email address is not registered!";
          context.pop();
          context.showErrorToast(msg);
        }
      }
    } on CustomException catch (exc) {
      context.pop();

      context.showErrorToast(exc.message, autoDismiss: true);
    } on FirebaseAuthException catch (e) {
      context.pop();
      debugPrint(e.message);
      context.showErrorToast(e.message!);
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  Future logout(
    BuildContext context,
    bool isApp,
  ) async {
    await AuthRepo.logout().then((value) {
      if (isApp) {
        Navigator.pushNamedAndRemoveUntil(
            context, SplashScreenMobile.routeName, (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, HomeScreenWeb.routeName, (route) => false);
      }
    });
  }

  Future signInWithMobile(BuildContext context, String mobile) async {
    try {
      context.unfocus();

      // await AuthRepo.phoneSignIn(mobile);
      try {
        await FirebaseAuth.instance.verifyPhoneNumber(
          // phoneNumber: '+918086028340',
          phoneNumber: '+91$mobile',
          verificationCompleted: (phoneAuthCredential) {
            debugPrint('verificationCompleted :');
          },
          verificationFailed: (error) {
            debugPrint('verificationFailed :');
            debugPrint(error.toString());
            context.showSnackbar(error.toString());
          },
          codeSent: (verificationId, forceResendingToken) {
            debugPrint('codeSent : $verificationId');
            context.scaffoldMessenger.showSnackBar(
              SnackBar(content: Text('codeSent : $verificationId')),
            );
          },
          codeAutoRetrievalTimeout: (verificationId) {
            debugPrint('codeAutoRetrievalTimeout :');
          },
        );
        return;
      } on FirebaseAuthException catch (err) {
        debugPrint(err.message);
        debugPrint(err.code);
        debugPrint(err.toString());
      } catch (err) {
        debugPrint(err.toString());
      }
    } on CustomException catch (exc) {
      context.pop();

      final snackBar = SnackBar(
        content: Text(exc.message),
      );

      context.scaffoldMessenger.showSnackBar(snackBar);
    } on FirebaseAuthException catch (e) {
      context.pop();
      debugPrint(e.message);
      var message = "";
      if (e.code == 'weak-password') {
        message = "The password provided is too weak.";
      } else if (e.code == 'email-already-in-use') {
        message = "The account already exists for that email.";
      } else {
        message = e.code;
      }
      context.scaffoldMessenger.showSnackBar(
        SnackBar(content: Text(message)),
      );
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  Future resetPassword(
    String emailAddress,
    BuildContext context,
    bool isApp,
  ) async {
    try {
      context.unfocus();
      if (emailAddress.isEmpty) {
        throw CustomException('Email Address cannot be empty !');
      }

      var accountType = await AuthRepo.checkIfEmailIdRegistered(emailAddress);
      if (accountType.isNotEmpty) {
        if (accountType == AccountType.emailPassword.value) {
          await AuthRepo.resetPassword(emailAddress).then((_) {
            context.pop();
            context.showSnackbar('Link to reset password has been sent!');
          });
        } else {
          if (context.mounted) {
            context.pop();
            context.showSnackbar(
                "Account doesn't have a password. Try login via Google SignIn!");
          }
        }
      } else {
        if (context.mounted) {
          context.pop();
          context.showSnackbar('E-mail id not registered !');
        }
      }
    } on CustomException catch (exc) {
      context.pop();
      context.showSnackbar(exc.message);
    } on FirebaseAuthException catch (e) {
      context.pop();
      context.showSnackbar(e.message!);
    } catch (err) {
      context.pop();
      context.showSnackbar(err.toString());
    }
  }

  Future signInWithGoogle(bool isApp, BuildContext context) async {
    User? user = await AuthRepo.signInWithGoogle(context: context);
    if (user != null) {
      updateGuestUser(false);
      if (context.mounted) {
        if (isApp) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            HomeScreenMobile.routeName,
            (route) => false,
          );
        } else {
          Navigator.pushNamedAndRemoveUntil(
            context,
            HomeScreenWeb.routeName,
            (route) => false,
          );
        }
      }
    } else {
      if (context.mounted) {
        context.pop();
      }
    }
  }
}
