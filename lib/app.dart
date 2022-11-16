import 'package:flutter/material.dart';
import 'package:leave_the_house_app/reminders/view/reminders_page.dart';

class LeaveTheHouseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LeaveTheHouseAppView();
  }
}

class LeaveTheHouseAppView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RemindersPage(),
    );
  }
  
}