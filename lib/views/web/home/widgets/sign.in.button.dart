import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:moviezapp/utils/dialogs.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/utils/extensions/widget.extensions.dart';
import 'package:moviezapp/views/common/auth/sign.up/widgets/custom.decoration.dart';
import 'package:moviezapp/views/common/auth/sign.up/widgets/password.decoration.dart';
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
      // barrierColor: Colors.black87,
      builder: (context) {
        final formKey = GlobalKey<FormState>();

        String email = "";
        String password = "";
        bool isVisible = false;
        final List<FocusNode> focusNodes = [
          FocusNode(),
          FocusNode(),
        ];
        return AlertDialog(
          title: const SectionTitle(title: 'Sign In'),
          content: StatefulBuilder(
            builder: (_, setStatee) {
              for (var node in focusNodes) {
                node.addListener(() {
                  setStatee(() {});
                });
              }
              return Form(
                key: formKey,
                child: Container(
                  width: context.width * 0.3,
                  color: context.bgColor,
                  height: context.height * 0.49,
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      TextFormField(
                        focusNode: focusNodes[0],
                        onSaved: (newValue) {
                          email = newValue!.trim();
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: customDecoration(
                          focusNodes[0],
                          'Email Address',
                          Icons.email,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        focusNode: focusNodes[1],
                        obscureText: !isVisible,
                        onSaved: (newValue) {
                          password = newValue!.trim();
                        },
                        decoration: passwordDecoration(
                          focusNodes[1],
                          'Password',
                          Icons.lock,
                          () {
                            isVisible = !isVisible;
                            setStatee(() {});
                          },
                          isVisible,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              // _formKey.currentState!.save();
                              // context.authProvider
                              //     .signInWithMobile(context, email.trim());

                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (_) =>
                              //             const ForgotPasswordScreen()));
                            },
                            child: const Text(
                              "Forgot password ?  ",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 15,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      CommonButton(
                        callback: () async {
                          formKey.currentState!.save();
                          Dialogs.showLoader(context: context);

                          await context.authProvider.signIn(
                            email,
                            password,
                            context,
                            context.appProvider.isMobileApp,
                          );
                        },
                        title: 'Sign In',
                      ),
                      const SizedBox(height: 25),
                      CommonButton(
                        callback: () {
                          googleSignin(context);
                        },
                        title: 'Sign In with Google',
                      ),
                      const SizedBox(height: 20),
                      RichText(
                        text: TextSpan(
                          text: "Don't have an account ? ",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.normal,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Sign up',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.pop();
                                  showSignUpDialog(context);
                                  // Navigator.pushReplacementNamed(
                                  //     context, SignUpScreen.routeName);
                                },
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: context.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
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

  showSignUpDialog(BuildContext context) async {
    await showDialog(
      context: context,
      // barrierColor: Colors.black87,
      builder: (context) {
        final formKey = GlobalKey<FormState>();

        String email = "";
        String password = "";
        String confirmPassword = "";
        String userName = "";

        bool isVisible = false;
        bool isConfirmVisible = false;
        final List<FocusNode> focusNodes = [
          FocusNode(),
          FocusNode(),
          FocusNode(),
          FocusNode(),
        ];

        return AlertDialog(
          title: const SectionTitle(title: 'Sign Up'),
          content: StatefulBuilder(
            builder: (_, setStatee) {
              for (var node in focusNodes) {
                node.addListener(() {
                  setStatee(() {});
                });
              }
              return Form(
                key: formKey,
                child: Container(
                  width: context.width * 0.34,
                  color: context.bgColor,
                  height: context.height * 0.52,
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      Row(
                        children: [
                          SizedBox(
                            width: context.width * 0.17,
                            child: TextFormField(
                              focusNode: focusNodes[0],
                              onSaved: (newValue) {
                                userName = newValue!.trim();
                              },
                              decoration: customDecoration(
                                  focusNodes[0], 'Name', Icons.person),
                            ),
                          ),
                          const SizedBox(width: 20),
                          SizedBox(
                            width: context.width * 0.17 - 20,
                            child: TextFormField(
                              focusNode: focusNodes[1],
                              onSaved: (newValue) {
                                email = newValue!.trim();
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: customDecoration(
                                focusNodes[1],
                                'Email Address',
                                Icons.email,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        focusNode: focusNodes[2],
                        obscureText: !isVisible,
                        onSaved: (newValue) {
                          password = newValue!.trim();
                        },
                        decoration: passwordDecoration(
                          focusNodes[2],
                          'Password',
                          Icons.lock,
                          () {
                            isVisible = !isVisible;
                            setStatee(() {});
                          },
                          isVisible,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        focusNode: focusNodes[3],
                        onSaved: (newValue) {
                          confirmPassword = newValue!.trim();
                        },
                        obscureText: !isConfirmVisible,
                        decoration: passwordDecoration(
                          focusNodes[3],
                          'Confirm Password',
                          Icons.lock,
                          () {
                            isConfirmVisible = !isConfirmVisible;
                            setStatee(() {});
                          },
                          isConfirmVisible,
                        ),
                      ),
                      const SizedBox(height: 20),
                      CommonButton(
                        callback: () async {
                          formKey.currentState!.save();
                          Dialogs.showLoader(context: context);
                          await context.authProvider.register(
                            email,
                            password,
                            confirmPassword,
                            userName,
                            context,
                          );
                        },
                        title: 'Sign Up',
                      ),
                      const SizedBox(height: 20),
                      RichText(
                        text: TextSpan(
                          text: "Don't have an account ? ",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.normal,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Sign In',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.pop();
                                  showSignInDialog(context);
                                  // Navigator.pushReplacementNamed(
                                  //     context, SignUpScreen.routeName);
                                },
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: context.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
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
    context.authProvider.signInWithGoogle(
      false,
      context,
    );
  }
}
