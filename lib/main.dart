import 'package:flutter/material.dart';
import 'package:study_plan/screens/Login.dart';
import 'package:study_plan/screens/NewUser.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Study Plan',
      home: NewUserWidget(),
    );
  }
}
