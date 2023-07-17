import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tweet/common/rounded_small_button.dart';
import 'package:tweet/features/auth/view/signup_view.dart';
import 'package:tweet/features/auth/widgets/auth_field.dart';
import 'package:tweet/theme/palette.dart';

import '../../../constants/constants.dart';
import '../controller/auth_controller.dart';

class LoginView extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const LoginView());
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final appbar = UIConstants.appBar();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void onLogin() {
    ref.read(authControllerProvider.notifier).login(
        email: emailController.text,
        password: passwordController.text,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: appbar,
      body: isLoading
          ? const CircularProgressIndicator()
          : Center(
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
                          onTap: onLogin,
                          label: 'Done',
                        ),
                      ),
                      const SizedBox(
                        height: 45,
                      ),
                      //textpan
                      RichText(
                        text:
                            TextSpan(text: "Dont't have an account", children: [
                          TextSpan(
                              text: ' Sign Up ',
                              style: const TextStyle(color: Pallete.blueColor),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(context, SignUpView.route());
                                })
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
