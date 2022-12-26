import 'package:flutter/material.dart';
import '../constant/color.dart';

class CustomAppBar extends StatelessWidget {
  final String titleText;
  const CustomAppBar({required this.titleText, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(titleText),
      backgroundColor: PRIMARY_COLOR,
      centerTitle: true,
    );
  }
}
