import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  TestScreen({super.key, this.test});
  String? test;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title:Text(test!) ,),
      body: Center(
        child: Text(test!),
      ),
    );
  }
}
