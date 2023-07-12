import 'package:flutter/material.dart';
import 'package:tweet/theme/theme.dart';

class AuthField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const AuthField(
      {super.key, required this.controller, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Pallete.blueColor, width: 2)),
          contentPadding: const EdgeInsets.all(22),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                color: Pallete.greyColor,
              )),
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 16)),
    );
  }
}
