import 'package:flutter/material.dart';

import '../constant/color.dart';

class CircleButton extends StatelessWidget {
  final TextStyle ts;
  final String buttonText;
  final void Function()? onPressed;
  const CircleButton({
    required this.onPressed,
    required this.ts,
    required this.buttonText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: onPressed,
          child: Text(''),
          style: ElevatedButton.styleFrom(
              primary: GREY_COLOR,
              minimumSize: Size(30, 30),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32))),
        ),
        Text(buttonText,style: ts),
      ],
    );
  }
}
