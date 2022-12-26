import 'package:flutter/material.dart';
import 'package:per_pro/component/appbar.dart';
import 'package:per_pro/component/custom_button.dart';

import '../../component/account_textfield.dart';
import '../../constant/color.dart';

class findPw extends StatefulWidget {
  const findPw({Key? key}) : super(key: key);

  @override
  State<findPw> createState() => _findPwState();
}

class _findPwState extends State<findPw> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _idTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BRIGHT_COLOR,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(titleText: 'PW 찾기'),
            Padding(
              padding: const EdgeInsets.fromLTRB(40.0, 40, 40, 40),
              child: Column(
                children: [
                  CustomTextField(
                    textInputType: TextInputType.emailAddress,
                    Controller: _idTextController,
                    label: 'ID',
                  ),
                  const SizedBox(height: 40),
                  CustomTextField(
                    textInputType: TextInputType.emailAddress,
                    Controller: _phoneNumberController,
                    label: '전화번호',
                  ),
                  const SizedBox(height : 40),
                  CustomButton(text: '확인', istext: true, onPressed: () {
                    print('확인');
                  })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}
