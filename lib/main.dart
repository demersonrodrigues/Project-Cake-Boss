// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/telasApp/TelaInicial.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  runApp(CakeBossApp());

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
            TelaInicialWidget(),
      },
    );
  }
}
