import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:per_pro/component/alert_dialog.dart';
import 'package:per_pro/component/report_anonymessage/report_post_screen.dart';
import 'package:per_pro/component/report_anonymessage/report_repl_screen.dart';
import '../../constant/color.dart';

Future ReportMessage(context, bool isPost, String postValue, String postID,
    String replID, String writerID, String currentUserId) async {
  final ts = TextStyle(color: PRIMARY_COLOR);
  return await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: BRIGHT_COLOR,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                //신고 탭으로 이동
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return isPost == true
                          ? ReportPost(postId: postID, postValue: postValue)
                          : ReportRepl(
                              postValue: postValue,
                              replID: replID,
                              postID: postID); //받은 변수값을 RepotPost() 에도 넘겨주자.
                    },
                  ),
                );
              },
              child: Text('신고', style: ts),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                //쪽지 보내기, 게시물 작성자에게 보내기
                //알람 보내기.
              },
              child: Text('쪽지', style: ts),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                currentUserId == writerID
                    ? deletePost(
                        context, isPost, postID, writerID, postValue, replID)
                    : {
                        Navigator.pop(context),
                        DialogShow(context, '게시글, 댓글 삭제는 작성자만 가능합니다.')
                      };
              }, //모든 데이터를 지워야 한다
              child: Text('게시글 삭제'),
            )
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('닫기', style: ts),
          ),
        ],
      );
    },
  );
}

deletePost(context, bool isPost, String postID, String writerID,
    String postValue, String replID) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  if (isPost == true) {
    //게시글 삭제
    final postData = await firestore.collection(postValue).doc(postID).get();
    final replIdList = List<String>.from(postData['repl id collector'] ?? []);
    print(replIdList.length);

    for (int i = 1; i < replIdList.length; i++) {
      await firestore
          .collection(postValue)
          .doc(postID)
          .collection('repl')
          .doc(replIdList[i])
          .delete();
    } //게시물 안의 모든 댓글 제거
    await firestore.collection(postValue).doc(postID).delete();
    for (int i = 0; i < 2; i++) {
      Navigator.pop(context);
    }
    DialogShow(context, '게시글 삭제를 완료했습니다.');
  } else if (isPost == false) {
    //댓글 삭제
    await firestore
        .collection(postValue)
        .doc(postID)
        .collection('repl')
        .doc(replID)
        .delete();
    Navigator.pop(context);
    DialogShow(context, '게시글 삭제를 완료했습니다.');
  }
}
