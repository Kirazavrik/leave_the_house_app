import 'package:flutter/material.dart';

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
