import 'package:coconut_app/presentation/home_page/create_group_page.dart';
import 'package:coconut_app/presentation/home_page/home_page.dart';
import 'package:coconut_app/presentation/home_page/join_group_page.dart';
import 'package:coconut_app/presentation/login_page/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
      routes: {
        "/homepage": (context) => HomePage(),
        "/joingroup": (context) => JoinGroup(),
        "/creategroup": (context) => CreateGroupPage(),
      },
    );
  }
}
