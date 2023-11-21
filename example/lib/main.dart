import 'dart:io';

import 'package:changeicon_example/src/android_config.dart';
import 'package:changeicon_example/src/ios_configuration.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Dynamic App Icon'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 28),
        child: ListView(
          children: <Widget>[
            Visibility(
              visible: Platform.isIOS,
              child: const IOSConfiguration(),
            ),
            Visibility(
              visible: Platform.isAndroid,
              child: const AndroidConfiguration(),
            ),
          ],
        ),
      ),
    );
  }
}