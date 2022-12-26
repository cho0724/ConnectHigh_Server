import 'package:flutter/material.dart';

class MealBoard extends StatelessWidget {
  const MealBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('급식 게시판'),),
    );
  }
}