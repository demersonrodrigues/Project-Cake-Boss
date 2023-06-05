import 'package:flutter/material.dart';
import 'package:flutterapp/cakebossapp/generatedtelainicialwidget/GeneratedTelainicialWidget.dart';

void main() {
  runApp(CakeBossApp());
}

class CakeBossApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cake Boss',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/TelainicialWidget',
      routes: {
        '/TelainicialWidget': (context) =>
            TelainicialWidget(),
      },
    );
  }
}
