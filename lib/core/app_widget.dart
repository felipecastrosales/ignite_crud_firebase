import 'package:flutter/material.dart';

import 'package:crud_firebase/modules/splash/splash_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ignite Flutter | Firebase\'s CRUD Challenge',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        checkboxTheme: Theme.of(context).checkboxTheme.copyWith(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              side: const BorderSide(
                width: 1.5,
                color: Color(0xFFB2B2B2),
              ),
            ),
      ),
      home: const SplashPage(),
    );
  }
}
