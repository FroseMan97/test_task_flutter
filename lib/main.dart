import 'package:flutter/material.dart';

import 'presentation/page/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(),
      home: HomePage(title: ''),
    );
  }
}
