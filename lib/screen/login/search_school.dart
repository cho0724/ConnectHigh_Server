import 'package:flutter/material.dart';

import '../../component/unFocus.dart';

class SearchSchoolScreen extends StatefulWidget {
  const SearchSchoolScreen({Key? key}) : super(key: key);

  @override
  State<SearchSchoolScreen> createState() => _SearchSchoolScreenState();
}

class _SearchSchoolScreenState extends State<SearchSchoolScreen> {
  final TextEditingController _filter = TextEditingController();
  FocusNode focusNode = FocusNode();
  String _searchText = "";

  _SearchSchoolScreenState(){
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: unFocused,
        child: SafeArea(
          child: Column(
            children: [
          Container(
          child: Row(
          children: [
            Expanded(
            flex: 6,
            child: TextFormField(
              focusNode: focusNode,
              autofocus: true,
              controller: _filter,
              decoration: InputDecoration(
                fillColor: Colors.grey[200],
                filled: true,
                //텍스트 필드를 통일화 하기위한 데코레이션,
                //text 필드 데코레이션 정의 변수.
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
                prefixIcon: Icon(Icons.search, color: Colors.black,),
                suffixIcon: focusNode.hasFocus ? IconButton(
                  icon: Icon(Icons.cancel,),
                  onPressed: () {
                    setState(() {
                      _filter.clear();
                      _searchText = '';
                    });
                  },
                ) : Container(),
                hintText: '학교를 검색해주세요.',
                labelStyle: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          )
          ],
    ),
    ),
            ]
          ),
        ),
      ),
    );
  }
}
