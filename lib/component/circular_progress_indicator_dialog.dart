import 'package:flutter/material.dart';
import 'package:per_pro/constant/color.dart';

Future CustomCircular( context,String contentText) async {
  final ts = TextStyle(color: PRIMARY_COLOR);
  return await showDialog(
      context: context,
      barrierDismissible : false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: BRIGHT_COLOR,
          title: Text(contentText,style: ts),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              CircularProgressIndicator(color: PRIMARY_COLOR),
            ],
          ),
        );
      },
  );
}
