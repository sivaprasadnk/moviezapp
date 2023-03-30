import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:moviezapp/utils/dialogs.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/views/common/auth/sign.in/forgot.password.screen.dart';
import 'package:moviezapp/views/common/auth/sign.up/sign.up.screen.dart';
import 'package:moviezapp/views/common/auth/sign.up/widgets/custom.decoration.dart';
import 'package:moviezapp/views/common/auth/sign.up/widgets/password.decoration.dart';
import 'package:moviezapp/views/common/common.button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});
  static const routeName = '/signIn';
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<FocusNode> _focusNodes = [
    FocusNode(),
    FocusNode(),
  ];

  @override
  void initState() {
    for (var node in _focusNodes) {
      node.addListener(() {
        setState(() {});
      });
    }
    super.initState();
  }

  String email = "";
  String password = "";
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 80),
                  const Text(
                    'Sign In',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Enter your user information below or continue with one of your social accounts',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 50),
                  TextFormField(
                    focusNode: _focusNodes[0],
                    onSaved: (newValue) {
                      email = newValue!.trim();
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: customDecoration(
                      _focusNodes[0],
                      'Email Address',
                      Icons.email,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    focusNode: _focusNodes[1],
                    obscureText: !isVisible,
                    onSaved: (newValue) {
                      password = newValue!.trim();
                    },
                    decoration: passwordDecoration(
                      _focusNodes[1],
                      'Password',
                      Icons.lock,
                      () {
                        isVisible = !isVisible;
                        setState(() {});
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
                          //
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      const ForgotPasswordScreen()));
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
                  const SizedBox(height: 50),
                  CommonButton(callback: validateAndProceed, title: 'Sign In'),
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
                              Navigator.pushReplacementNamed(
                                  context, SignUpScreen.routeName);
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
          ),
        ),
      ),
    );
  }

  validateAndProceed() async {
    _formKey.currentState!.save();
    Dialogs.showLoader(context: context);

    await context.authProvider.signIn(
      email,
      password,
      // 'sp@sp.com',
      // '1234567890',
      context,
      context.appProvider.isMobileApp,
    );

    // context.authProvider.signInWithMobile(context, email);
  }
}
