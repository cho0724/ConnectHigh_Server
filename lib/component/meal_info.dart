import 'package:flutter/material.dart';

class MealInfo extends StatelessWidget {
  //날짜
  final String mealdate;
  final String meal;
  final double width;

  const MealInfo({
    required this.width,
    required this.mealdate,
    required this.meal,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            mealdate,
          ),
          Text(
            meal,
          ),
        ],
      ),
    );
  }
}
