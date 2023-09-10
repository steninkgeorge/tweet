import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tweet/theme/palette.dart';

class TweetIconButton extends StatelessWidget {
  final String pathname;
  final String text;
  final VoidCallback onTap;
  const TweetIconButton(
      {super.key, required this.pathname, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          // ignore: deprecated_member_use
          SvgPicture.asset(pathname,color: Pallete.greyColor,),
          Container(
              margin: EdgeInsets.all(6),
              child: Text(
                text,
                style: TextStyle(fontSize: 12),
              ))
        ],
      ),
    );
  }
}
