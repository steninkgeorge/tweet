import 'package:flutter/material.dart';
import 'package:tweet/theme/palette.dart';

class Hashtag extends StatelessWidget {
  final String text;
  const Hashtag({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    List<TextSpan> textspans = [];
    text.split(' ').forEach((element) {
      if (element.startsWith('#')) {
        textspans.add(TextSpan(
            text: '$element ',
            style: const TextStyle(
                color: Pallete.blueColor,
                fontSize: 14,
                fontWeight: FontWeight.bold)));
      } else if (element.startsWith('www.') || element.startsWith('https://')) {
        textspans.add(TextSpan(
            text: '$element ',
            style: const TextStyle(color: Pallete.blueColor, fontSize: 14)));
      } else {
        textspans.add(
            TextSpan(text: '$element ', style: const TextStyle(fontSize: 14)));
      }
    });
    return RichText(
      text: TextSpan(children: textspans),
    );
  }
}
