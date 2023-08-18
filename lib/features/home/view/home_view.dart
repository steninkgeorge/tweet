import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tweet/constants/constants.dart';
import 'package:tweet/features/tweet/views/create_tweet_views.dart';
import 'package:tweet/theme/theme.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  static route() => MaterialPageRoute(builder: (context) => const HomeView());

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final appbar = UIConstants.appBar();
  int pageIndex = 0;

  void onPageChange(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  onCreateTweet() {
    Navigator.push(context, CreateTweetScreen.route());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: IndexedStack(
          index: pageIndex, children: UIConstants.bottomTabBarPages),
      floatingActionButton: FloatingActionButton(
        onPressed: onCreateTweet,
        child: const Icon(
          Icons.add,
          color: Pallete.whiteColor,
          size: 28,
        ),
      ),
      bottomNavigationBar: CupertinoTabBar(
          currentIndex: pageIndex,
          onTap: onPageChange,
          backgroundColor: Pallete.backgroundColor,
          items: [
            BottomNavigationBarItem(
                icon: pageIndex == 0
                    ? const Icon(
                        Icons.home_filled,
                        color: Pallete.whiteColor,
                      )
                    : const Icon(Icons.home_outlined)),
            BottomNavigationBarItem(
                icon: pageIndex == 1
                    ? const Icon(
                        Icons.search,
                        color: Pallete.whiteColor,
                      )
                    : const Icon(Icons.search_outlined)),
            BottomNavigationBarItem(
                icon: pageIndex == 2
                    ? const Icon(
                        Icons.notifications,
                        color: Pallete.whiteColor,
                      )
                    : const Icon(Icons.notifications_outlined)),
          ]),
    );
  }
}
