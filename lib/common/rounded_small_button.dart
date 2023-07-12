import 'package:flutter/material.dart';
import 'package:tweet/theme/theme.dart';

class RoundedSmallButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final Color backgroundColor;
  final Color textColor;
  const RoundedSmallButton(
      {super.key,
      required this.onTap,
      required this.label,
      this.backgroundColor = Pallete.whiteColor,
      this.textColor = Pallete.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        label,
        style: TextStyle(color: textColor, fontSize: 14),
      ),
      backgroundColor: backgroundColor,
      labelPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
    );
  }
}
