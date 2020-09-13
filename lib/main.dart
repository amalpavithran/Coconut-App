import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'injection_container.dart' as di;
import 'presentation/home_page/home_page.dart';
import 'presentation/login_page/login_page.dart';
import 'presentation/repos/user_repo.dart';


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
      home: buildHome(),
      routes: {
        "/login": (context) => LoginPage(),
      },
    );
  }

  Widget buildHome() {
    final user = di.sl<UserRepository>().getCurrentUser();
    print(user);
    if (user != null) {
      return HomePage(user);
    } else {
      return LoginPage();
    }
  }
}
