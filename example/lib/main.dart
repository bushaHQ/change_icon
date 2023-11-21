import 'dart:io';

import 'package:changeicon_example/src/android_config.dart';
import 'package:changeicon_example/src/ios_configuration.dart';
import 'package:changeicon_example/src/theme/theme_widget.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ThemeWidgetBuilder(
      builder: (theme) {
        return MaterialApp(
          themeMode: theme.themeMode,
          theme: ThemeData.light(
            useMaterial3: true,
          ),
          darkTheme: ThemeData.dark(useMaterial3: true),
          home: Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: const Text('Change App Icon'),
            ),
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 28),
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
          ),
        );
      },
    );
  }
}
