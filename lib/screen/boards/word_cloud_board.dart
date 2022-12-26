import 'package:flutter/material.dart';
// 임의로 만들어둔 워드클라우드 게시판. 호철이가 만들었을 수 있음
class WordCloudBoard extends StatelessWidget {
  const WordCloudBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Word Cloud", style: TextStyle(color: Colors.red),),
    );
  }
}
