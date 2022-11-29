import 'package:flutter/material.dart';
import 'package:leave_the_house_app/reminders/view/reminders_page.dart';
import 'package:leave_the_house_app/utils/routes.dart';

class LeaveTheHouseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LeaveTheHouseAppView();
  }
}

class LeaveTheHouseAppView extends StatelessWidget {
  static String initialRoute = HomePage.routeName;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: initialRoute,
      routes: {
        HomePage.routeName : (context) => HomePage(),
        MySecondScreen.routeName : (context) => MySecondScreen()
      },
    );
  }
  
}