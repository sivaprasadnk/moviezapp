import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:moviezapp/utils/dialogs.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/views/common/auth/sign.in/sign.in.screen.dart';
import 'package:moviezapp/views/common/auth/sign.up/widgets/custom.decoration.dart';
import 'package:moviezapp/views/common/auth/sign.up/widgets/password.decoration.dart';
import 'package:moviezapp/views/common/common.button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static const routeName = '/signUp';
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<FocusNode> _focusNodes = [
    FocusNode(),
    FocusNode(),
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
  String confirmPassword = "";
  String userName = "";

  bool isVisible = false;
  bool isConfirmVisible = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 80),
                const Text(
                  'Sign Up',
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
                    userName = newValue!.trim();
                  },
                  decoration:
                      customDecoration(_focusNodes[0], 'Name', Icons.person),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  focusNode: _focusNodes[1],
                  onSaved: (newValue) {
                    email = newValue!.trim();
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: customDecoration(
                    _focusNodes[1],
                    'Email Address',
                    Icons.email,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  focusNode: _focusNodes[2],
                  onSaved: (newValue) {
                    password = newValue!.trim();
                  },
                  obscureText: !isVisible,
                  decoration: passwordDecoration(
                    _focusNodes[2],
                    'Password',
                    Icons.lock,
                    () {
                      isVisible = !isVisible;
                      setState(() {});
                    },
                    isVisible,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  focusNode: _focusNodes[3],
                  onSaved: (newValue) {
                    confirmPassword = newValue!.trim();
                  },
                  obscureText: !isConfirmVisible,
                  decoration: passwordDecoration(
                    _focusNodes[3],
                    'Confirm Password',
                    Icons.lock,
                    () {
                      isConfirmVisible = !isConfirmVisible;
                      setState(() {});
                    },
                    isConfirmVisible,
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  "By signing up, you accept Privacy Policy & Terms of Service",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 30),
                CommonButton(callback: validateAndProceed, title: 'Sign Up'),
                const SizedBox(height: 20),
                RichText(
                  text: TextSpan(
                    text: "Already have an account ? ",
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Sign in',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacementNamed(
                                context, SignInScreen.routeName);
                          },
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: context.theme.primaryColor,
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
    );
  }

  validateAndProceed() async {
    _formKey.currentState!.save();
    Dialogs.showLoader(context: context);
    await context.authProvider.register(
      email,
      password,
      confirmPassword,
      userName,
      context,
    );
    // await context.authProvider.register(
    //   'sivaprasadnk123@gmail.com',
    //   '123456789',
    //   '123456789',
    //   'userName',
    //   context,
    // );
  }
}
