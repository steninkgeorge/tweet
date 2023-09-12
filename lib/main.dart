import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tweet/common/common.dart';
import 'package:tweet/features/auth/controller/auth_controller.dart';
import 'package:tweet/features/auth/view/signup_view.dart';
import 'package:tweet/features/home/view/home_view.dart';
import 'package:tweet/theme/app_theme.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tweet',
        theme: AppTheme.theme,
        home: ref.watch(currentUserAccountProvider).when(
            data: (user) {
              if (user != null) {
                return const HomeView();
              }
              return const SignUpView();
            },
            error: (error, StackTrace) => ErrorPage(error: error.toString()),
            loading: () => const LoadingPage()));
  }
}
