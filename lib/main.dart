// @dart=2.9

import 'package:flutter/material.dart';
import 'screens/main_page.dart';
import 'package:shopping_list/models/list_data.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ListData(),
      child: MaterialApp(
        home: MainPage(),
      ),
    );
  }
}
