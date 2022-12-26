import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:per_pro/component/appbar.dart';
import 'package:per_pro/component/custom_button.dart';
import 'package:per_pro/constant/color.dart';
import 'package:per_pro/firebase_database_model/user.dart';
import 'package:per_pro/screen/setting/etc_screen/user_delete_screen.dart';

import '../../../component/account_textfield.dart';
import '../../../component/alert_dialog.dart';
import '../personal_account_setting/change_email_beforlogin.dart';

class DeleteAccount extends StatefulWidget {
  final loginUser user;
  const DeleteAccount({
    required this.user,
    Key? key,
  }) : super(key: key);

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  final TextEditingController _idTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BRIGHT_COLOR,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomAppBar(titleText: '계정 확인'),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    CustomTextField(
                      textInputType: TextInputType.text,
                      Controller: _idTextController,
                      label: '계정 아이디',
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      textInputType: TextInputType.visiblePassword,
                      Controller: _passwordTextController,
                      label: '계정 비밀번호',
                    ),
                    const SizedBox(height: 24),
                    ChangeEmailBtn(
                      text: '계정 확인',
                      onChangeEmail: DeleteAccountBtn,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void DeleteAccountBtn() {
    try {
      if (widget.user.ID == _idTextController.text &&
          widget.user.PW == _passwordTextController.text) {
        Navigator.pop(context);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return UserDelete(user: widget.user);
        }));
      } else {
        Navigator.pop(context);
        DialogShow(context, '회원정보가 잘못되었습니다.');
      }
    } catch (e) {
      Navigator.pop(context);
      DialogShow(context, '시스템 에러');
    }
  }
}
