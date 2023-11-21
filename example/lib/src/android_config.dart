import 'package:changeicon/Changeicon.dart';
import 'package:flutter/material.dart';

class AndroidConfiguration extends StatefulWidget {
  const AndroidConfiguration({super.key});

  @override
  State<AndroidConfiguration> createState() => _AndroidConfigurationState();
}

class _AndroidConfigurationState extends State<AndroidConfiguration> {
  final _changeiconPlugin = Changeicon();

  @override
  void initState() {
    Changeicon.initialize(
      classNames: ['MainActivity', 'DarkTheme', 'LightTheme'],
    );
    super.initState();
  }

  void switchAppIcon() async {
    await _changeiconPlugin.switchIconTo(classNames: ['DarkTheme', '']);
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      icon: const Icon(Icons.restore_outlined),
      label: const Text("Andriod Icon"),
      onPressed: () async {
        switchAppIcon();
      },
    );
  }
}
