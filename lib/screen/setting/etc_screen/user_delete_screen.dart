import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:per_pro/component/appbar.dart';
import 'package:per_pro/component/custom_button.dart';
import 'package:per_pro/constant/color.dart';
import 'package:per_pro/firebase_database_model/user.dart';
import '../../../component/alert_dialog.dart';
import '../../../component/circular_progress_indicator_dialog.dart';

class UserDelete extends StatefulWidget {
  final loginUser user;
  const UserDelete({
    required this.user,
    Key? key,
  }) : super(key: key);

  @override
  State<UserDelete> createState() => _UserDeleteState();
}

class _UserDeleteState extends State<UserDelete> {
  @override
  Widget build(BuildContext context) {
    final ContainerDecoration = BoxDecoration(
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
    );
    final ts = TextStyle(
        color: PRIMARY_COLOR, fontSize: 20, fontWeight: FontWeight.w700);
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              CustomAppBar(titleText: '회원탈퇴'),
              const SizedBox(height: 32),
              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 1.1,
                    decoration: ContainerDecoration,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16, bottom: 24),
                      child: Column(
                        children: [
                          SizedBox(height: 32),
                          Text('회원을 탈퇴 하시겠습니까?',
                              style: ts.copyWith(fontSize: 30)),
                          const SizedBox(height: 24),
                          Text(
                            '회원을 탈퇴하면 지금 까지 작성한 \n회원님의 게시글, 댓글 및 프로필 정보 등이 \n삭제되어 복구가 불가능합니다.',
                            style: ts.copyWith(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 48,
                          ),
                          CustomButton(
                              text: '회원탈퇴', istext: true, onPressed: onDeleteAccount)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onDeleteAccount() async{
    try {
      CustomCircular(context, '회원 탈퇴 중...');
      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.user.ID)
          .delete();
      Navigator.pop(context);
      for (int i = 0; i < 2; i++) {
        Navigator.pop(context); //계정확인 화면에서
      }
      await DialogShow(context, '계정 삭제를 완료하였습니다. 그동안 고등어를 이용해주셔서 감사합니다!!');
      SystemChannels.platform.invokeListMethod('SystemNavigator.pop');
    } catch (e) {
      //Navigator.pop(context);
      Navigator.pop(context);
      DialogShow(context, '계정삭지를 실패하였습니다.');
    }

  }
}
