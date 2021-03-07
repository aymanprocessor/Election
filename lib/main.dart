import 'package:flutter/material.dart';

import 'nameLists_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'القرعة',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: NameList());
  }
}
