import 'package:flutter/material.dart';

import '../constant/color.dart';

class CustomButton extends StatelessWidget {
  final bool istext; //버튼안에 들어갈 내용이 '중복확인' 텍스트인가 화살표아이콘인가를 결정해주는 변수임 164번줄에 이어서 주석달겠음.
  final String text;
  final VoidCallback onPressed;
  const CustomButton({required this.text,required this.istext, required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: PRIMARY_COLOR,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
      onPressed: onPressed,
      child: istext == false ? Icon(
        Icons.arrow_forward,
        color: Colors.white,
        size: 35.0,
      ) : Text(text),
    );
  }
}
