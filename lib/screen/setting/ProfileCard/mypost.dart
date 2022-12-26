import 'package:flutter/material.dart';
import 'package:per_pro/component/appbar.dart';

class myPost extends StatelessWidget {
  final BoxDecoration ContainerDecoration;
  const myPost({
    required this.ContainerDecoration,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        CustomAppBar(titleText: '내가 쓴 글'),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
          child: Container(
            width: MediaQuery.of(context).size.width / 1.1,
            decoration: BoxDecoration(
              color: Colors.white,
              //border: Border.all(width: 2, color: PRIMARY_COLOR),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 7,
                    offset: Offset(0, 10))
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 16, 0, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('asd'),
                  Text('asd'),
                  Text('asd'),
                  Text('asd'),
                  Text('asd'),
                ],
              ),
            ),
          ),
        )
      ],
    ));
  }
}
