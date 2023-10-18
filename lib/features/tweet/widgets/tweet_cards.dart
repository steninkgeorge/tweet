import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:like_button/like_button.dart';
import 'package:tweet/constants/constants.dart';
import 'package:tweet/core/core.dart';
import 'package:tweet/features/auth/controller/auth_controller.dart';
import 'package:tweet/features/tweet/controller/tweet_controller.dart';
import 'package:tweet/features/tweet/widgets/carousel_image.dart';
import 'package:tweet/features/tweet/widgets/hashtag_text.dart';
import 'package:tweet/features/tweet/widgets/tweet_icon_button.dart';
import 'package:tweet/models/tweet_model.dart';
import 'package:tweet/models/user_model.dart';
import 'package:tweet/theme/palette.dart';

import '../../../common/common.dart';
import 'package:timeago/timeago.dart' as timeago;

class TweetCard extends ConsumerWidget {
  final Tweet tweet;
  const TweetCard({super.key, required this.tweet});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserDetailsProvider).value;
    return currentUser == null
        ? const SizedBox()
        : ref.watch(userDetailsProvider(tweet.uid)).when(
            data: (user) {
              return Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            user.profilePic,
                          ),
                          radius: 25,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //retweeted
                            if (tweet.retweetedBy.isNotEmpty)
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    AssetsConstants.retweetIcon,
                                    // ignore: deprecated_member_use
                                    color: Pallete.greyColor,
                                    height: 20,
                                  ),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  Text('${tweet.retweetedBy} retweeted',style: const TextStyle(color: Pallete.greyColor,fontSize: 16,fontWeight: FontWeight.w500),)
                                ],
                              ),

                            Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 5),
                                  child: Text(
                                    user.name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                ),
                                Text(
                                  '@${user.name} · ${timeago.format(tweet.tweetedAt, locale: 'en_short')}',
                                  style: const TextStyle(
                                      fontSize: 12, color: Pallete.greyColor),
                                ),
                              ],
                            ),
                            //replied to
                            Hashtag(text: tweet.text),
                            if (tweet.tweetType == TweetType.image)
                              CarouselImage(imageLinks: tweet.imageLinks),
                            if (tweet.link.isNotEmpty) ...[
                              const SizedBox(
                                height: 4,
                              ),
                              AnyLinkPreview(
                                  displayDirection:
                                      UIDirection.uiDirectionHorizontal,
                                  link: 'https://${tweet.link}')
                            ],
                            Container(
                              margin: EdgeInsets.only(top: 10, right: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TweetIconButton(
                                      pathname: AssetsConstants.viewsIcon,
                                      text: (tweet.commentIds.length +
                                              tweet.reshareCount +
                                              tweet.likes.length)
                                          .toString(),
                                      onTap: () {}),
                                  TweetIconButton(
                                      pathname: AssetsConstants.commentIcon,
                                      text:
                                          (tweet.commentIds.length).toString(),
                                      onTap: () {}),
                                  TweetIconButton(
                                      pathname: AssetsConstants.retweetIcon,
                                      text: (tweet.reshareCount).toString(),
                                      onTap: () {
                                        ref
                                            .read(tweetControllerProvider
                                                .notifier)
                                            .reshareTweet(
                                                tweet, currentUser, context);
                                      }),
                                  LikeButton(
                                    onTap: (isLiked) async {
                                      ref
                                          .read(
                                              tweetControllerProvider.notifier)
                                          .likeTweet(tweet, currentUser);
                                      return !isLiked;
                                    },
                                    likeCount: tweet.likes.length,
                                    countBuilder: (likeCount, isLiked, text) {
                                      return Text(
                                        text,
                                        style: TextStyle(
                                            color: isLiked
                                                ? Pallete.redColor
                                                : Pallete.whiteColor),
                                      );
                                    },
                                    isLiked:
                                        tweet.likes.contains(currentUser.uid),
                                    size: 20,
                                    likeBuilder: (isLiked) {
                                      return isLiked
                                          ? SvgPicture.asset(
                                              AssetsConstants.likeFilledIcon,
                                              color: Pallete.redColor,
                                            )
                                          : SvgPicture.asset(
                                              AssetsConstants.likeOutlinedIcon,
                                              color: Pallete.greyColor,
                                            );
                                    },
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.share_outlined,
                                        size: 23,
                                        color: Pallete.greyColor,
                                      ))
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 1,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Divider(
                    color: Pallete.greyColor,
                  )
                ],
              );
            },
            error: (error, st) => ErrorText(error: error.toString()),
            loading: () => const Loader());
  }
}
