import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tweet/common/common.dart';
import 'package:tweet/features/tweet/controller/tweet_controller.dart';
import 'package:tweet/features/tweet/widgets/tweet_cards.dart';
import 'package:tweet/models/tweet_model.dart';

import '../../../constants/constants.dart';

class TweetList extends ConsumerWidget {
  const TweetList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getTweetsProvider).when(
        data: (tweets) {
          return ref.watch(getLatestTweetProvider).when(
              data: (data) {
                if (data.events.contains(
                    'databases.*.collections.${AppwriteConstants.tweetsCollection}.documents.*.create')) {
                  tweets.insert(0, Tweet.fromMap(data.payload));
                }
                return ListView.builder(
                    itemCount: tweets.length,
                    itemBuilder: (BuildContext context, int index) {
                      final tweet = tweets[index];
                      return TweetCard(tweet: tweet);
                    });
              },
              error: (error, st) => ErrorText(
                    error: error.toString(),
                  ),
              loading: () {
                return ListView.builder(
                    itemCount: tweets.length,
                    itemBuilder: (BuildContext context, int index) {
                      final tweet = tweets[index];
                      return TweetCard(tweet: tweet);
                    });
              });
        },
        error: (error, StackTrace) => ErrorText(error: error.toString()),
        loading: () => const Loader());
  }
}
