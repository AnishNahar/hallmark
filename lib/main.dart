import 'package:flutter/material.dart';
import 'package:hallmarkcardgenerator/PdfGenerator.dart';
import 'package:hallmarkcardgenerator/Screen/EditFormScreen.dart';
import 'package:hallmarkcardgenerator/Screen/HomeScreen.dart';
import 'package:hallmarkcardgenerator/Screen/FormScreen.dart';
import 'package:hallmarkcardgenerator/Screen/DatabaseScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: {
        FormScreen.routeName: (context) => FormScreen(),
        DatabaseScreen.routeName: (context) => DatabaseScreen(),
        PdfGenerator.routeName: (context) => PdfGenerator(),
        EditFormScreen.routeName: (context) => EditFormScreen(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}
