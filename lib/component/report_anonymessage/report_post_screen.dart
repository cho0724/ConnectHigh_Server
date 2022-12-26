import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:per_pro/component/alert_dialog.dart';
import 'package:per_pro/component/appbar.dart';
import 'package:per_pro/component/circular_progress_indicator_dialog.dart';
import 'package:per_pro/component/custom_button.dart';
import '../../constant/color.dart';
import '../custom_AddPost_TextFiled.dart';

class ReportPost extends StatefulWidget {
  final String postId;
  final String postValue;

  const ReportPost({required this.postValue, required this.postId, Key? key})
      : super(key: key);

  @override
  State<ReportPost> createState() => _ReportPostState();
}

class _ReportPostState extends State<ReportPost> {
  final TextEditingController contentTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final ts = TextStyle(color: PRIMARY_COLOR, fontSize: 20);
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              CustomAppBar(
                titleText: '신고',
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 16),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.1,
                      height: MediaQuery.of(context).size.height / 10,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 7,
                              offset: Offset(0, 10))
                        ],
                      ),
                      child: Center(
                        child: Text('해당 게시물의 신고 사유를 작성해주세요', style: ts),
                      ),
                    ),
                    const SizedBox(height: 16),
                    CustomAddPostTextField(
                        controller: contentTextController, isPostTtile: false),
                    const SizedBox(height: 16),
                    CustomButton(
                        text: '제출', istext: true, onPressed: SubmitReport),
                    const SizedBox(height: 16),
                    Text('● 해당 게시물, 댓글을 신고 처리하면 일시적으로 해당 게시물을 볼 수 없게됩니다.',
                        style: ts.copyWith(fontSize: 16)),
                    Text('\n● 추후 해당 게시물에 문제가 없다고 판단되면 해당 게시물은 정상적으로 복구됩니다.',
                        style: ts.copyWith(fontSize: 16)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void SubmitReport() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CustomCircular(context, '신고 진행 중...');
    await firestore.collection(widget.postValue).doc(widget.postId).update({
      'is reported' : true,
      'report content' : contentTextController.text,
    });
    Navigator.pop(context);
    Navigator.pop(context);
    DialogShow(context, '신고 재출을 완료했습니다.');
  }
}
