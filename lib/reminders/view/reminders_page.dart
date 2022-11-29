import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leave_the_house_app/app.dart';
import 'package:leave_the_house_app/notification/notification_cubit.dart';
import 'package:leave_the_house_app/notification/notification_view.dart';
import 'package:leave_the_house_app/utils/notification_service.dart';

import '../../utils/routes.dart';

class HomePage extends StatelessWidget {

  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationCubit(),
      child: Scaffold(
        appBar: AppBar(),
        body: HomeView(),
      ),
    );
  }
}

class HomeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeView();
}

class _HomeView extends State<HomeView> {


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NotificationView()
      ],
    );
  }
}

class MySecondScreen extends StatelessWidget {

  static const String routeName = '/second';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("JustWater"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text('some text'),
        ],
      ),
    );
  }
}
