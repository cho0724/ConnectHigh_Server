import 'package:flutter/material.dart';
import 'package:per_pro/component/appbar.dart';
import 'package:per_pro/firebase_database_model/user.dart';
import 'package:per_pro/screen/setting/personal_account_setting/ChangeNIckName.dart';
import 'package:per_pro/screen/setting/personal_account_setting/change_email.dart';

import '../../../component/account_textfield.dart';
import '../../../component/alert_dialog.dart';
import '../../../constant/color.dart';

class ChangeNickbeforLogin extends StatefulWidget {
  final loginUser user;
  const ChangeNickbeforLogin({
    required this.user,
    Key? key,
  }) : super(key: key);

  @override
  State<ChangeNickbeforLogin> createState() => _ChangeNickbeforLoginState();
}

class _ChangeNickbeforLoginState extends State<ChangeNickbeforLogin> {
  final TextEditingController _idTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final ts = TextStyle(color: PRIMARY_COLOR);
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
                    ChangeEmailBtn(text: '계정 확인', onChangeEmail: onChangeNickName),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void onChangeNickName() async {
    String id;
    String pw;
    try {
      id = _idTextController.text;
      pw = _idTextController.text;
      if (widget.user.ID == _idTextController.text && widget.user.PW == _passwordTextController.text) {
        Navigator.pop(context);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return ChangeNickName(user:  widget.user);
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


class ChangeEmailBtn extends StatelessWidget {
  final VoidCallback onChangeEmail;
  final String text;
  const ChangeEmailBtn({
    required this.text,
    required this.onChangeEmail,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: onChangeEmail,
        child: Text(text),
        style: ElevatedButton.styleFrom(
          primary: PRIMARY_COLOR,
          minimumSize: Size(150, 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
