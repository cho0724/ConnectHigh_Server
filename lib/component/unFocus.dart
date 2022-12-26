import 'package:flutter/material.dart';

void unFocused() {
  FocusManager.instance.primaryFocus?.unfocus(); // 키보드 닫기 이벤트
}