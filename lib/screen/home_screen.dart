import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:per_pro/constant/color.dart';
import 'package:per_pro/firebase_database_model/user.dart';

import 'package:per_pro/model/school_information_model.dart';
import 'package:per_pro/screen/board_screen.dart';
import 'package:per_pro/screen/home_tab.dart';
import 'package:per_pro/screen/settings_screen.dart';
import 'package:per_pro/screen/boards/word_cloud_board.dart';
import 'package:per_pro/screen/schedule_screen.dart';
import '../constant/data.dart';
import '../model/school_information_model.dart';
import 'boards/alarm_screen.dart';

class HomeScreen extends StatefulWidget {
  final loginUser user;
  const HomeScreen({
    required this.user,
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// 이 스크린이 메인 우리가 구현해야할 화면들임. 스와이프하면 옆 화면으로 이동함.
// 하단 네브바에 메뉴 6개넣으니까 너무 좁아 보여서 설정창은 앱바의 우측으로 뺐음.
class _HomeScreenState extends State<HomeScreen> {
  Future<List<MealModel>> fetchData() async {
    final date = DateTime.now().year.toString() +
        DateTime.now().month.toString().padLeft(2, '0');
    print(date);
    final response= await Dio().get(
      'https://open.neis.go.kr/hub/mealServiceDietInfo',
      queryParameters: {
        'serviceKey': serviceKey,
        'Type': 'json',
        'pIndex': 1,
        'pSize': 30,
        'ATPT_OFCDC_SC_CODE': widget.user.eduOfficeCode,
        'SD_SCHUL_CODE': '7531106',
        'MLSV_YMD': date,
      },
    );
    //print(response);
    Map<String, dynamic> meal = jsonDecode(response.data);

    return meal['mealServiceDietInfo'][1]['row']
        .map<MealModel>(
          (item) => MealModel.fromJson(json: item),
    )
        .toList();
  }

  /*Future<List<MealModel>> fetchData2() async {
    final mealModels = await fetchData();

    return mealModels;
  }*/

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 5,
        child: Scaffold(
          backgroundColor: BRIGHT_COLOR,
          appBar: AppBar(
            title: Text('Navi'),
            centerTitle: true,
            backgroundColor: PRIMARY_COLOR,
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return SettingScreen(user: widget.user); //세팅 화면으로 이동.
                        },
                      ),
                    );
                  },
                  icon: Icon(Icons.settings))
            ],
          ),
          body: FutureBuilder<List<MealModel>>(
            future: fetchData(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('에러가 있습니다'),
                );
              }
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              List<MealModel> meals = snapshot.data!;
              MealModel recentMeal = meals[0];
              //print(recentMeal.DDISH_NM);

              return TabBarView(
                children: [
                  HomeTab(
                    meal: recentMeal,
                    user: widget.user,
                  ),
                  WordCloudBoard(),
                  BoardScreen(user : widget.user),
                  Schedule(),
                  alarmscreen(),
                ],
              );
            },
          ),
          extendBodyBehindAppBar: true, // add this line
          bottomNavigationBar: Container(
            color: BRIGHT_COLOR, //색상
            child: Container(
              height: 70,
              padding: EdgeInsets.only(bottom: 10, top: 5),
              child: const TabBar(
                //tab 하단 indicator size -> .label = label의 길이
                //tab 하단 indicator size -> .tab = tab의 길이
                indicatorSize: TabBarIndicatorSize.label,
                //tab 하단 indicator color
                indicatorColor: PRIMARY_COLOR,
                //tab 하단 indicator weight
                indicatorWeight: 2,
                //label color
                labelColor: PRIMARY_COLOR,
                //unselected label color
                unselectedLabelColor: Colors.black38,
                labelStyle: TextStyle(
                  fontSize: 13,
                ),
                tabs: [
                  Tab(
                    icon: Icon(Icons.home_outlined),
                  ),
                  Tab(
                    icon: Icon(Icons.pie_chart),
                  ),
                  Tab(
                    icon: Icon(Icons.format_list_bulleted),
                  ),
                  Tab(icon: Icon(Icons.table_chart)),
                  Tab(
                    icon: Icon(Icons.message),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
