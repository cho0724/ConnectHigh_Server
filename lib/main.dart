import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:per_pro/firebase_database_model/user.dart';
import 'package:per_pro/screen/intro_screen.dart';
import 'package:per_pro/screen/login/signup_screen.dart';
import 'package:provider/provider.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
              home: MyApp(), // 시작 부분.
            ),
  );
}
