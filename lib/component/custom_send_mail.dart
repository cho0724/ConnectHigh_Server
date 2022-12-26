import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:image_picker/image_picker.dart';
import 'package:per_pro/component/appbar.dart';
import 'package:per_pro/component/custom_button.dart';
import 'package:per_pro/firebase_database_model/user.dart';
import 'alert_dialog.dart';
import 'send_mail_custom_textfield.dart';
import '../constant/color.dart';

class SendMail extends StatefulWidget {
  final XFile? certifiedImage;
  final String appBarText;
  final loginUser user;
  final BoxDecoration ContainerDecoration;

  const SendMail({
    this.certifiedImage,
    required this.appBarText,
    required this.user,
    required this.ContainerDecoration,
    Key? key,
  }) : super(key: key);

  @override
  State<SendMail> createState() => _SendMailState();
}

class _SendMailState extends State<SendMail> {
  final TextEditingController _mailTitleTextController =
      TextEditingController();
  final TextEditingController _mailContentTextController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ts = TextStyle(color: PRIMARY_COLOR, fontSize: 16);
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppBar(titleText: widget.appBarText),
            const SizedBox(height: 24),
            Container(
              width: MediaQuery.of(context).size.width / 1.1,
              height: 100,
              decoration: widget.ContainerDecoration,
              child: Center(
                child: Text(
                  '받는 사람 : 고등어 개발팀 (High-Connect)',
                  style: ts,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              width: MediaQuery.of(context).size.width / 1.1,
              height: 100,
              decoration: widget.ContainerDecoration,
              child: Center(
                child: Text(
                  '보내는 사람 : ${widget.user.email}',
                  style: ts,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("제목", style: ts.copyWith(fontSize: 24)),
                  const SizedBox(height: 24),
                  CustomSendMailTextField(
                      controller: _mailTitleTextController, isMailTtile: true),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Text("내용", style: ts.copyWith(fontSize: 24)),
                      const SizedBox(width:  8,),
                    ],
                  ),
                  const SizedBox(height: 24),
                  CustomSendMailTextField(
                      controller: _mailContentTextController,
                      isMailTtile: false),
                ],
              ),
            ),
            CustomButton(text: '완료', istext: true, onPressed: onSendEmailBtn)
          ],
        ),
      )),
    );
  }

  void onSendEmailBtn() async {
    print(_mailContentTextController.text);
    final Email email = widget.certifiedImage != null ? Email(
      body: '${_mailContentTextController.text}',
      subject: '[${_mailTitleTextController.text}]',
      recipients: ['forstudyhw2@gmail.com'],
      cc: [],
      bcc: [],
      attachmentPaths: [widget.certifiedImage!.path],
      isHTML: false,
    ) : Email(
      body: '${_mailContentTextController.text}',
      subject: '[${_mailTitleTextController.text}]',
      recipients: ['forstudyhw2@gmail.com'],
      cc: [],
      bcc: [],
      attachmentPaths: [],
      isHTML: false,
    );
    try {
      await FlutterEmailSender.send(email);
    } catch (error) {
      DialogShow(context, '사용하시는 기기 내의 Gmail 앱에 구글 계정을 등록해주세요.');
    }
  }
}
