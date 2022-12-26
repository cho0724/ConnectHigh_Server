import 'package:flutter/material.dart';

class Schedule extends StatelessWidget {
  const Schedule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ScheduleTimeTalble(),
    );
  }
}

class ScheduleTimeTalble extends StatelessWidget {
  final List<List<int>> tableData = [
    [1, 1, 1, 1, 1],
    [2, 2, 2, 2, 2],
    [3, 3, 3, 3, 3],
    [4, 4, 4, 4, 4],
    [5, 5, 5, 5, 5],
    [6, 6, 6, 6, 6],
    [7, 7, 7, 7, 7],
    [8, 8, 8, 8, 8],
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    Text('시간표'),
                    Container(
                        width: 375.0,
                        height: 500.0,
                        child: Column(
                            children: this
                                .tableData
                                .map<Widget>((List<int> l) => Expanded(
                                      child: Row(
                                          children: l
                                              .map<Widget>((int i) => Expanded(
                                                    child: Container(
                                                        decoration: BoxDecoration(
                                                            color:
                                                                Colors.blueGrey,
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black)),
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(i.toString(),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white))),
                                                  ))
                                              .toList()),
                                    ),
                            ).toList(),
                        ),
                    ),
                  ],
                ),
              ),
          ),
      ),
    );
  }
}
