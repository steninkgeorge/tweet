import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tweet/common/rounded_small_button.dart';
import 'package:tweet/constants/ui_constants.dart';
import 'package:tweet/features/auth/widgets/auth_field.dart';
import 'package:tweet/theme/palette.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final appbar = UIConstants.appBar();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                //textfield1
                AuthField(
                  controller: emailController,
                  hintText: 'Email',
                ),
                const SizedBox(
                  height: 25,
                ),
                //textfield2
                AuthField(
                  controller: passwordController,
                  hintText: 'Password',
                ),
                const SizedBox(
                  height: 35,
                ),
                //button
                Align(
                  alignment: Alignment.topRight,
                  child: RoundedSmallButton(
                    onTap: () {},
                    label: 'Done',
                  ),
                ),
                const SizedBox(
                  height: 45,
                ),
                //textpan
                RichText(
                  text: TextSpan(text: "Dont't have an account", children: [
                    TextSpan(
                        text: ' Sign Up ',
                        style: const TextStyle(color: Pallete.blueColor),
                        recognizer: TapGestureRecognizer()..onTap = () {})
                  ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
