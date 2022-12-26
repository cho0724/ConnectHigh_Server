import 'package:flutter/material.dart';
import 'package:per_pro/component/account_textfield.dart';
import 'package:per_pro/component/appbar.dart';
import 'package:per_pro/constant/color.dart';

class findId extends StatefulWidget {
  const findId({Key? key}) : super(key: key);

  @override
  State<findId> createState() => _findIdState();
}

class _findIdState extends State<findId> {
  final TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final ts = TextStyle(
        fontSize: 18, fontWeight: FontWeight.w600, color: PRIMARY_COLOR);
    return Scaffold(
      backgroundColor: BRIGHT_COLOR,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(titleText: 'ID 찾기'),
            Padding(
              padding: const EdgeInsets.fromLTRB(40.0, 40, 40, 40),
              child: Column(
                children: [
                  CustomTextField(
                    textInputType: TextInputType.emailAddress,
                    Controller: _emailTextController,
                    label: 'E-mail',
                  ),
                  const SizedBox(height: 40),
                  Text(
                    '해당 이메일로 ID를 전송합니다.',
                    style: ts,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
