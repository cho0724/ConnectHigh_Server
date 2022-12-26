import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:per_pro/component/account_textfield.dart';
import 'package:per_pro/component/alert_dialog.dart';
import 'package:per_pro/component/appbar.dart';
import 'package:per_pro/constant/color.dart';
import 'package:per_pro/firebase_database_model/user.dart';

import '../../../component/circular_progress_indicator_dialog.dart';
import '../../../component/custom_button.dart';

class ChangeEmailScreen extends StatelessWidget {
  final loginUser user;
  const ChangeEmailScreen({
    required this.user,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ts = TextStyle(color: PRIMARY_COLOR, fontSize: 16);
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          CustomAppBar(titleText: '이메일 변경'),
          const SizedBox(height: 24),
          Container(
              width: MediaQuery.of(context).size.width / 1.1,
              height: MediaQuery.of(context).size.height / 5,
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
                child: Text('현재 이메일 : ${user.email}', style: ts),
              )),
          ChangeEmail(user: user),
        ],
      ),
    ));
  }
}

class ChangeEmail extends StatefulWidget {
  final loginUser user;
  const ChangeEmail({
    required this.user,
    Key? key,
  }) : super(key: key);

  @override
  State<ChangeEmail> createState() => _ChangeEmailState();
}

class _ChangeEmailState extends State<ChangeEmail> {
  final TextEditingController _newEmailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 40, 24, 40),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                CustomTextField(
                  textInputType: TextInputType.emailAddress,
                  Controller: _newEmailController,
                  label: '새 이메일',
                ),
                CustomButton(
                    text: '변경', istext: false, onPressed: onmailChangeBtn)
              ],
            ),
          ),
        ),
      ],
    );
  }

  void onmailChangeBtn() async {
    if (formKey.currentState == null) {
      return;
    }
    if (formKey.currentState!.validate()) {
      try {
        CustomCircular(context, '이메일 변경중...');
        await FirebaseFirestore.instance
            .collection('users')
            .doc(widget.user.ID)
            .update({'email': _newEmailController.text});
        Navigator.pop(context);
        for (int i = 0; i < 2; i++) {
          Navigator.pop(context); //계정확인 화면에서
        }
        widget.user.email = _newEmailController.text;
        DialogShow(context, '이메일 변경을 완료하였습니다.');
      } catch (e) {
        //Navigator.pop(context);
        Navigator.pop(context);
        DialogShow(context, '이메일 변경을 실패하였습니다.');
      }
    }
  }
}
