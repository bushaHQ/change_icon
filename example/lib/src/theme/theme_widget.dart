import 'package:flutter/material.dart';

import 'theme_config.dart';

typedef ThemeBuilder = Widget Function(
  ThemeNotifier context,
);

class ThemeWidgetBuilder extends StatefulWidget {
  const ThemeWidgetBuilder({
    Key? key,
    required this.builder,
  }) : super(key: key);

  final ThemeBuilder builder;

  @override
  State<ThemeWidgetBuilder> createState() => _ThemeWidgetBuilderState();
}

class _ThemeWidgetBuilderState extends State<ThemeWidgetBuilder> {
  @override
  void initState() {
    themeNotifier.addListener(() => mounted ? setState(() {}) : null);
    super.initState();
  }

  @override
  void dispose() {
    themeNotifier.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(themeNotifier);
  }
}
