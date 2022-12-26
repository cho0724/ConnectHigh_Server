import 'package:flutter/material.dart';


class CustomAddPostTextField extends StatelessWidget {
  final bool isPostTtile;
  final TextEditingController controller;
  const CustomAddPostTextField({
    required this.controller,
    required this.isPostTtile,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _decoration = InputDecoration(
      hintText: isPostTtile == true ? '게시글 제목' : '게시글 내용',
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
    );

    return Container(
      height: isPostTtile == true ? 75 : 250,
      child: TextFormField(
        controller: controller,
        expands: true,

        keyboardType: isPostTtile == true ? TextInputType.text : TextInputType.multiline,
        maxLines: null,
        validator: (String? val) {
          if (val == null || val.isEmpty) {
            return '해당 필드는 필수항복입니다.';
          }

          return null;
        },
        decoration: _decoration,
      ),
    );
  }
}
