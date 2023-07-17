import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tweet/features/auth/controller/auth_controller.dart';
import 'package:tweet/features/auth/view/login_view.dart';
import '../../../common/common.dart';
import '../../../constants/constants.dart';
import '../../../theme/theme.dart';
import '../widgets/auth_field.dart';

class SignUpView extends ConsumerStatefulWidget {
  const SignUpView({super.key});
  static route() => MaterialPageRoute(builder: (context) => const SignUpView());

  @override
  ConsumerState<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
  final appbar = UIConstants.appBar();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void onSignUp() {
    ref.read(authControllerProvider.notifier).signUp(
        email: emailController.text,
        password: passwordController.text,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
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
                    onTap: onSignUp,
                    label: 'Done',
                  ),
                ),
                const SizedBox(
                  height: 45,
                ),
                //textpan
                RichText(
                  text: TextSpan(text: "Already have an account", children: [
                    TextSpan(
                        text: ' Login ',
                        style: const TextStyle(color: Pallete.blueColor),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(context, LoginView.route());
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
