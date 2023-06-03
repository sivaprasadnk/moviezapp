import 'package:flutter/material.dart';
import 'package:moviezapp/utils/dialogs.dart';
import 'package:moviezapp/utils/extensions/build.context.extension.dart';
import 'package:moviezapp/views/common/auth/sign.up/widgets/custom.decoration.dart';
import 'package:moviezapp/views/common/common.button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _focusNode = FocusNode();
  String email = "";

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: context.bgColor,
            leading: GestureDetector(
              onTap: () {
                context.pop();
              },
              child: Icon(
                Icons.arrow_back_ios_rounded,
                color: context.highlightColor,
              ),
            ),
            // title: const Text('Forgot Password'),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    const Text(
                      'Forgot Password',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Enter email-id to receive password reset link',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 50),
                    TextFormField(
                      focusNode: _focusNode,
                      onSaved: (newValue) {
                        email = newValue!.trim();
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: customDecoration(
                        _focusNode,
                        'Email Address',
                        Icons.email,
                      ),
                    ),
                    SizedBox(height: context.height * 0.5),
                    CommonButton(
                        callback: validateAndProceed, title: 'Send link '),
                  ],
                ),
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

    // await context.authProvider.resetPassword(
    //   email,
    //   context,
    //   context.isMobileApp,
    // );
  }
}
