import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tweet/common/common.dart';
import 'package:tweet/core/core.dart';
import 'package:tweet/features/auth/controller/auth_controller.dart';
import 'package:tweet/features/tweet/controller/tweet_controller.dart';
import 'package:tweet/theme/theme.dart';

class CreateTweetScreen extends ConsumerStatefulWidget {
  const CreateTweetScreen({super.key});

  static route() =>
      MaterialPageRoute(builder: (context) => const CreateTweetScreen());

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateTweetScreenState();
}

class _CreateTweetScreenState extends ConsumerState<CreateTweetScreen> {
  final tweetTextController = TextEditingController();
  List<File> images = [];
  @override
  void dispose() {
    super.dispose();
    tweetTextController.dispose();
  }

  void onPickImages() async {
    images = await pickImage();
    setState(() {});
  }

  void shareTweet() {
    ref.read(tweetControllerProvider.notifier).shareTweet(
        images: images, text: tweetTextController.text, context: context);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserDetailsProvider).value;
    final isLoading = ref.watch(tweetControllerProvider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.close,
            size: 30,
          ),
        ),
        actions: [
          RoundedSmallButton(
            onTap: shareTweet,
            label: 'Tweet',
            backgroundColor: Pallete.blueColor,
            textColor: Pallete.whiteColor,
          )
        ],
      ),
      body: isLoading || currentUser == null
          ? const Loader()
          : SafeArea(
              child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              NetworkImage(currentUser.profilePic)),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: TextField(
                          controller: tweetTextController,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                          decoration: const InputDecoration(
                              hintText: " What's happening?",
                              border: InputBorder.none),
                          maxLines: null,
                        ),
                      )
                    ],
                  ),
                  if (images.isNotEmpty)
                    CarouselSlider(
                        items: images.map((file) {
                          return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              width: MediaQuery.of(context).size.width,
                              child: Image.file(file));
                        }).toList(),
                        options: CarouselOptions(
                            height: 400, enableInfiniteScroll: true))
                ],
              ),
            )),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(bottom: 10),
        decoration: const BoxDecoration(
            border:
                Border(top: BorderSide(color: Pallete.greyColor, width: 0.3))),
        child: Row(
          children: [
            Padding(
                padding: const EdgeInsets.all(8).copyWith(left: 15, right: 15),
                child: GestureDetector(
                    onTap: onPickImages, child: const Icon(Icons.photo))),
            Padding(
                padding: const EdgeInsets.all(8).copyWith(left: 15, right: 15),
                child: const Icon(Icons.gif)),
            Padding(
                padding: const EdgeInsets.all(8).copyWith(left: 15, right: 15),
                child: const Icon(Icons.emoji_emotions))
          ],
        ),
      ),
    );
  }
}
