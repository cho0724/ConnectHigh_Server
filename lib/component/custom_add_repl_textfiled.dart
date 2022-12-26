import 'package:flutter/material.dart';

class CustomAddReplTextField extends StatefulWidget {
  final String label;
  final TextEditingController Controller;

  const CustomAddReplTextField({
    required this.Controller,
    required this.label,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomAddReplTextField> createState() => _CustomAddReplTextFieldState();
}

class _CustomAddReplTextFieldState extends State<CustomAddReplTextField> {
  @override
  Widget build(BuildContext context) {
    final _decoration = InputDecoration(
      labelText: widget.label,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
    );

    return TextFormField(
      maxLines: null,
      controller: widget.Controller,
      validator: (String? val) {
        if (val == null || val.isEmpty) {
          return '해당 필드는 필수항복입니다.';
        }
        return null;
      },
      decoration: _decoration,
    );
  }
}
