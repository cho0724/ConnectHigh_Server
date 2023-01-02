import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:per_pro/component/account_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:per_pro/component/alert_dialog.dart';
import 'package:per_pro/component/appbar.dart';
import 'package:per_pro/component/circular_progress_indicator_dialog.dart';
import 'package:per_pro/component/unFocus.dart';
import 'package:per_pro/constant/data.dart';
import 'package:per_pro/model/school_information_model.dart';
import 'package:per_pro/screen/login/search_school.dart';
import '../../component/custom_button.dart';
import '../../constant/color.dart';

class signUp extends StatefulWidget {
  const signUp({Key? key}) : super(key: key);

  @override
  State<signUp> createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  //각 텍스트 릴드의 값을 가지고 오기위한 텍스트컨트롤러 변수들
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final TextEditingController _idTextController = TextEditingController();
  final TextEditingController _schoolTextController = TextEditingController();
  final TextEditingController _pwTextController = TextEditingController();
  final TextEditingController _repwTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _nicknameTextController = TextEditingController();
  final TextEditingController _realNameTextController = TextEditingController();
  FocusNode focusNode = FocusNode();
  String _searchText = '';

  // _signUpState(){
  //   _schoolTextController.addListener(() {
  //     setState(() {
  //       _searchText = _schoolTextController.text;
  //     });
  //   });
  // }

  // Widget _buildBody(BuildContext context){
  //   return StreamBuilder<QuerySnapshot>(
  //     stream: fetchData(),
  //     builder: (context, snapshot){
  //       if(!snapshot.hasData) return LinearProgressIndicator();
  //       return _buildList(context, snapshot.data!.docs);
  //     },
  //   );
  // }
  //
  // Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot){
  //   List<DocumentSnapshot> _searchResult = [];
  //   for(DocumentSnapshot d in snapshot){
  //     if(d.data.toString().contains(_searchText)){
  //       _searchResult.add(d);
  //     }
  //   }
  //   return ListView.builder(
  //     itemCount: _searchResult.length,
  //     itemBuilder: (context, index){
  //       return _buildListItem(context, _searchResult[index]);
  //     }
  //   );
  // }
  //
  // Widget _buildListItem(BuildContext context, DocumentSnapshot data){
  //   final school = fetchData().fromSnapshot(data);
  //   return ListTile(
  //     title: Text(school.schoolName),
  //     onTap: (){
  //       setState(() {
  //         _schoolTextController.text = school.schoolName;
  //       });
  //     },
  //   );
  // }

  //텍스트폼필드를 컨트롤 하기위한 변수. 강의에 나오니 알아서 찾아보슈
  final GlobalKey<FormState> formKey = GlobalKey();
  String? dropdownValue;
  String? eduOfficeCode;

  List<String> items = [
    '강원도교육청',
    '경기도교육청',
    '경상남도교육청',
    '경상북도교육청',
    '광주광역시교육청',
    '대구광역시교육청',
    '대전광역시교육청',
    '부산광역시교육청',
    '서울특별시교육청',
    '세종특별자치시교육청',
    '울산광역시교육청',
    '인천광역시교육청',
    '전라남도교육청',
    '전라북도교육청',
    '제주특별자치도교육청',
    '충청남도교육청',
    '충청북도교육청',
  ];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  var response;
  dynamic schoolTotalInformation = [];

  fetchData() async {
    response = await Dio().get(
      'https://open.neis.go.kr/hub/schoolInfo',
      queryParameters: {
        'KEY': normalServiceKey,
        'Type': 'json',
        'pIndex': 1,
        'pSize': 1000,
        'SCHUL_KND_SC_NM': '고등학교'
      },
    ); //서울, 대구, 부산, 인천, 광주, 대전, 울산, 세종, 경기,

    final response1 = await Dio().get(
      'https://open.neis.go.kr/hub/schoolInfo',
      queryParameters: {
        'KEY': normalServiceKey,
        'Type': 'json',
        'pIndex': 2,
        'pSize': 1000,
        'SCHUL_KND_SC_NM': '고등학교'
      },
    ); //경기, 강원, 충북, 충남, 전북, 전남, 경북,

    final response2 = await Dio().get(
      'https://open.neis.go.kr/hub/schoolInfo',
      queryParameters: {
        'KEY': normalServiceKey,
        'Type': 'json',
        'pIndex': 3,
        'pSize': 1000,
        'SCHUL_KND_SC_NM': '고등학교'
      },
    ); // 경북, 경남, 제주

    Map<String, dynamic> schoolName = jsonDecode(response.data);
    Map<String, dynamic> schoolName1 = jsonDecode(response1.data);
    Map<String, dynamic> schoolName2 = jsonDecode(response2.data);
    List<dynamic> schoolInfo1 = schoolName['schoolInfo'][1]['row']
        .map(
          (item) => schoolInfo.fromJson(json: item),
        )
        .toList();
    List<dynamic> schoolInfo2 = schoolName1['schoolInfo'][1]['row']
        .map(
          (item) => schoolInfo.fromJson(json: item),
        )
        .toList();
    List<dynamic> schoolInfo3 = schoolName2['schoolInfo'][1]['row']
        .map(
          (item) => schoolInfo.fromJson(json: item),
        )
        .toList();

    for (int i = 0; i < schoolInfo1.length; i++) {
      //print(schoolInfo1[i].SCHUL_NM + " : " + (i + 1).toString() + ", " + schoolInfo1[i].SD_SCHUL_CODE + ", " +  schoolInfo1[i].ATPT_OFCDC_SC_CODE);
    }
    for (int i = 0; i < schoolInfo2.length; i++) {
      //print(schoolInfo1[i].SCHUL_NM + " : " + (i + 1).toString() + ", " + schoolInfo1[i].SD_SCHUL_CODE + ", " +  schoolInfo1[i].ATPT_OFCDC_SC_CODE);
    }
    for (int i = 0; i < schoolInfo3.length; i++) {
      //print(schoolInfo1[i].SCHUL_NM + " : " + (i + 1).toString() + ", " + schoolInfo1[i].SD_SCHUL_CODE + ", " +  schoolInfo1[i].ATPT_OFCDC_SC_CODE);
    }
    for (int i = 0; i < schoolTotalInformation.length; i++) {
      // print((i + 1).toString() +
      //     "  " +
      //     schoolTotalInformation[i].SCHUL_NM +
      //     ", 코드 : " +
      //     schoolTotalInformation[i].SD_SCHUL_CODE +
      //     ", 교육청 : " +
      //     schoolTotalInformation[i].ATPT_OFCDC_SC_CODE);
    }
    schoolTotalInformation.addAll(schoolInfo1);
    schoolTotalInformation.addAll(schoolInfo2);
    schoolTotalInformation.addAll(schoolInfo3);

    Map<String, String> schoolNameToCodeMap = {};

    for (int i = 0; i < schoolTotalInformation.length; i++) {
      schoolNameToCodeMap[schoolTotalInformation[i].SCHUL_NM] =
          schoolTotalInformation[i].SD_SCHUL_CODE;
    }

    //print(schoolNameToCodeMap);

    List<String> schoolNames = [
      for (int i = 0; i < schoolTotalInformation.length; i++)
        schoolTotalInformation[i].SCHUL_NM
    ];
    //print(schoolNames.length);
    // return schoolNames;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BRIGHT_COLOR,
      body: GestureDetector(
        onTap: unFocused,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomAppBar(titleText: 'Sign UP'),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 40, 24, 40),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        /* CustomTextField는 Component파일에 account_textfield.dart에 정의해둠.
                           텍스트 필드마다 입력시 조건들이 다르기때문에 account_textfield.dart파일에
                           주석으로 달아두겠음.
                           */
                        const SizedBox(height: 16),
                        CustomTextField(
                          label: 'ID입력',
                          Controller: _idTextController,
                          textInputType: TextInputType.text,
                        ),

                        CustomButton(
                          istext: true,
                          text: 'ID 중복체크', //text 가 false 면 버튼안에 내용이 화살표아이콘
                          onPressed: onCheckIdPressed, //계정생성 버튼.
                        ),

                        const SizedBox(height: 16),
                        CustomTextField(
                          label: 'password 입력',
                          Controller: _pwTextController,
                          textInputType: TextInputType.visiblePassword,
                          //passwordChecker: _pwTextController.text,
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          label: 'password 확인',
                          Controller: _repwTextController,
                          textInputType: TextInputType.visiblePassword,
                          passwordChecker: _pwTextController,
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          label: 'E-MAIL',
                          Controller: _emailTextController,
                          textInputType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          label: '닉네임',
                          Controller: _nicknameTextController,
                          textInputType: TextInputType.text,
                        ),

                        CustomButton(
                            text: '닉네임 중복체크',
                            istext: true,
                            onPressed: onCheckNickNamePressed),

                        const SizedBox(height: 16),
                        CustomTextField(
                          label: '실명', // 학교인증용
                          Controller: _realNameTextController,
                          textInputType: TextInputType.text,
                        ),
                        const SizedBox(height: 16),
                        SchoolSearchTextFormField(
                          label: '학교',
                          Controller: _schoolTextController,
                          textInputType: TextInputType.text,
                        ),
                        // _buildBody(context),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          validator: (String? val) {
                            //이곳에서 조건에 따른 에러메시지를 출력,
                            //null이 리턴된다면 에러가 없는 상태.
                            if (val == null || val.isEmpty) {
                              return '해당 필드는 필수항목입니다.';
                            }
                            return null;
                          },
                          hint: Text('교육청을 선택하세요'),
                          value: dropdownValue,
                          icon: const Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(color: Colors.black),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                              if (dropdownValue == '강원도교육청') {
                                eduOfficeCode = 'K10';
                              }
                              if (dropdownValue == '경기도교육청') {
                                eduOfficeCode = 'J10';
                              }
                              if (dropdownValue == '경상남도교육청') {
                                eduOfficeCode = 'S10';
                              }
                              if (dropdownValue == '경상북도교육청') {
                                eduOfficeCode = 'R10';
                              }
                              if (dropdownValue == '광주광역시교육청') {
                                eduOfficeCode = 'F10';
                              }
                              if (dropdownValue == '대구광역시교육청') {
                                eduOfficeCode = 'D10';
                              }
                              if (dropdownValue == '대전광역시교육청') {
                                eduOfficeCode = 'G10';
                              }
                              if (dropdownValue == '부산광역시교육청') {
                                eduOfficeCode = 'C10';
                              }
                              if (dropdownValue == '서울특별시교육청') {
                                eduOfficeCode = 'B10';
                              }
                              if (dropdownValue == '세종특별자치시교육청') {
                                eduOfficeCode = 'I10';
                              }
                              if (dropdownValue == '울산광역시교육청') {
                                eduOfficeCode = 'H10';
                              }
                              if (dropdownValue == '인천광역시교육청') {
                                eduOfficeCode = 'E10';
                              }
                              if (dropdownValue == '전라남도교육청') {
                                eduOfficeCode = 'Q10';
                              }
                              if (dropdownValue == '전라북도교육청') {
                                eduOfficeCode = 'P10';
                              }
                              if (dropdownValue == '제주특별자치도교육청') {
                                eduOfficeCode = 'T10';
                              }
                              if (dropdownValue == '충청남도교육청') {
                                eduOfficeCode = 'N10';
                              }
                              if (dropdownValue == '충청북도교육청') {
                                eduOfficeCode = 'M10';
                              }
                            });
                          },
                          items: items
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 16),
                        const SizedBox(
                          height: 50,
                        ),
                        const Text('● 이부분은 약관'),
                        CustomButton(
                            text: '',
                            istext: false, //text 가 false 면 버튼안에 내용이 화살표아이콘
                            onPressed: onSignUpPressed //계정생성 버튼.
                            ),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int _duplicationIdCheck = 0;
  int _duplbtnidchecker = 0;
  int _duplicationNickCheck = 0;
  int _duplbtnnickchecker = 0;
  String userEmail = '';

  void onCheckIdPressed() async {
    Response response;
    var dio = Dio();

    CustomCircular(context, '중복 확인 중...');
    try {
      response = await dio
          .post(AndroidBaseURL + '/api/create/checkIDdupl', data: {
        'id': _idTextController.text,
      });
     if(response.data == "can use"){
        Navigator.pop(context);
        DialogShow(context, '사용 가능한 ID입니다.');
        print(response.data);
        _duplicationIdCheck = 1;
      }
        else if(response.data == "cannot use"){
        Navigator.pop(context);
        DialogShow(context, '중복된 아이디가 존재합니다.');
        print(response.data);
      }
      if (response.data == "err 발생") {
        Navigator.pop(context);
        DialogShow(context, '에러 발생.');
      }
    } catch (e) {
      print("에러 발생");
    }

    /*DocumentSnapshot eehd도userData;
    try {
      CustomCircular(context, '중복 확인 중...');
      userData =
          await firestore.collection('users').doc(_idTextController.text).get();
      if (_idTextController.text == userData['id']) {
        Navigator.pop(context);
        DialogShow(context, '중복된 아이디가 존재합니다.');
      }
    } catch (e) {
      Navigator.pop(context);
      DialogShow(context, '사용 가능한 ID입니다.');
      _duplicationIdCheck = 1;
      _duplbtnidchecker = 1;
    }*/
  }

  int checker = 0;

  void onCheckNickNamePressed() async {
    Response response;
    var dio = Dio();

    CustomCircular(context, '중복 확인 중...');
    try {
      response = await dio
          .post(AndroidBaseURL + '/api/create/checkNickNamedupl', data: {
        'nickName': _nicknameTextController.text,
      });
      if(response.data == "can use"){
        Navigator.pop(context);
        DialogShow(context, '사용 가능한 닉네임입니다.');
        _duplicationNickCheck = 1;
        print(response.data);
      }
      else if(response.data == "cannot use"){
        Navigator.pop(context);
        DialogShow(context, '중복된 닉네임이 존재합니다.');
        print(response.data);
      }
      if (response.data == "err 발생") {
        Navigator.pop(context);
        DialogShow(context, '에러 발생.');
      }
    } catch (e) {
      print("에러 발생");
    }
  }

  void onSignUpPressed() async {
    /*
    if (_duplicationIdCheck == 1 &&
        _duplbtnidchecker == 1 &&
        _duplicationNickCheck == 1 &&
        _duplbtnnickchecker == 1) {
      createAccount();
    } else {
      DialogShow(context, '중복체크를 진행해주세요.');
    }
  }

  void createAccount() async {
    if (formKey.currentState == null) {
      return;
    }
    if (formKey.currentState!.validate()) {
      //계정 생성버튼을 눌렀을때 이상이 없으면 파이어베이스 클라우드스토어에 유저 정보를 추가한다.
      CustomCircular(context, '회원가입 진행중...');
      await firestore.collection('users').doc(_idTextController.text).set({
        'id': _idTextController.text,
        'pw': _pwTextController.text,
        'real name': _realNameTextController.text,
        'nick name': _nicknameTextController.text,
        'created Time': DateTime.now().toString(),
        'my school': _schoolTextController.text,
        'email': _emailTextController.text,
        'phone number': _phoneNumberTextController.text,
        'edu office code': eduOfficeCode,
        'anony message': [''],
        'bool Admin': 1,
        'bool certificated': 1,
        'repl count': 0,
        'post count': 0,
      });

      Navigator.pop(context);
      Navigator.pop(context);
      DialogShow(context, '회원가입이 완료되었습니다.');

      //이부분이 이메일 코드
      // if (formKey.currentState == null) {
      //       return;
      //     }
      //     if (formKey.currentState!.validate()) {
      //       //계정 생성버튼을 눌렀을때 이상이 없으면 파이어베이스 클라우드스토어에 유저 정보를 추가한다.
      //       CustomCircular(context, '회원가입 진행중...');
      //       await firestore.co인데 일단 주석처리 해줌.
      /*try {
        CustomCircular(context, '이메일 가입을 진행 중 입니다...'); // ---- 1번
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailTextController.text,
            password:
                _pwTextController.text); //이메일 회원가입(authentication 이메일 계정생성)
        Navigator.pop(context); // 1번 circularIndicator제거
        CustomCircular(context, '이메일 인증 문서를 전송중입니다...'); //---- 2번
        await FirebaseAuth.instance.currentUser!
            .sendEmailVerification(); // 가입한 메일로 메일인증 보냄
        Navigator.pop(context); // 2번 서큘러인디케이터 제거
        Navigator.pop(context);
        DialogShow(context, '이메일 인증 문서를 전송했습니다. 수신된 메일이 없다면 스펨메일함을 확인해보세요!');
        DialogShow(context, '회원가입이 완료되었습니다.');
      } catch (e) {
        Navigator.pop(context);
        DialogShow(context, '이미 가입한 이메일이거나 서버 에러가 발생하였습니다.');
      }*/
    }
  */
    if (formKey.currentState == null) {
      return;
    }
    if (formKey.currentState!.validate()) {
      Response response;
      var dio = Dio();
      if(_duplicationIdCheck == 1 && _duplicationNickCheck == 1) {
        CustomCircular(context, '회원가입 진행중...');
        try {
          response = await dio.post(AndroidBaseURL + '/api/create', data: {
            'id': _idTextController.text,
            'pw': _pwTextController.text,
            'nickName': _nicknameTextController.text,
            'name': _realNameTextController.text,
            'schoolName': _schoolTextController.text,
            'schoolCode': eduOfficeCode,
            'isAdmin': 0,
            'isCertificated': 0,
            'createTime': DateTime.now().toString(),
            'postCount': 0,
            'replCount': 0,
            'email': _emailTextController.text,
          }); //회원가입시에 필요한데이터 묵음 덩어리
          if (response.data == "err 발생") {
            Navigator.pop(context);
            DialogShow(context, '에러 발생.');
          } else {
            Navigator.pop(context);
            Navigator.pop(context);
            print(response.data);
            DialogShow(context, '회원가입이 완료되었습니다.');
          }
        } catch (e) {
          print("에러 발생");
        }
      }
      else {
        DialogShow(context, '중복체크를 진행해주세요.');
      }
    }
  }
}

class SchoolSearchTextFormField extends StatelessWidget {
  final String label;
  final TextEditingController Controller;
  final TextInputType textInputType;

  const SchoolSearchTextFormField({
    required this.Controller,
    required this.label,
    required this.textInputType,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SearchSchoolScreen(),
          ),
        );
      },
      controller: Controller,
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
        labelText: label,
        hintText: '학교를 검색해주세요.',
        suffixIcon: IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchSchoolScreen(),
              ),
            );
          },
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return '학교를 입력해주세요.';
        }
        return null;
      },
    );
  }
}
