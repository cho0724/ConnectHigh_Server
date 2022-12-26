import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class alarmscreen extends StatelessWidget {
  const alarmscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        child: Row(
          children: [
            const SizedBox(width: 16),
            TextButton(
              onPressed: () {},
              child: Text('알림',
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 24,
                      color: CupertinoColors.inactiveGray)),
            ),
            SizedBox(
              height: 30,
            ),
            Text('    '),
            TextButton(
              onPressed: () {},
              child: Text(
                '쪽지함',
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 24,
                    color: CupertinoColors.inactiveGray),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    ));
  }
}
