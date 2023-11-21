import 'package:changeicon/Changeicon.dart';
import 'package:changeicon_example/src/theme/theme_config.dart';
import 'package:flutter/material.dart';

class AndroidConfiguration extends StatefulWidget {
  const AndroidConfiguration({super.key});

  @override
  State<AndroidConfiguration> createState() => _AndroidConfigurationState();
}

class _AndroidConfigurationState extends State<AndroidConfiguration> {
  final _changeiconPlugin = Changeicon();
  bool switchValue = false;

  @override
  void initState() {
    Changeicon.initialize(
      classNames: ['MainActivity', 'DarkTheme', 'LightTheme'],
    );
    super.initState();
  }

  void switchAppIcon(String type) async {
    await _changeiconPlugin.switchIconTo(classNames: [type, '']);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OutlinedButton.icon(
          icon: const Icon(Icons.restore_outlined),
          label: const Text("Restore Icon"),
          onPressed: () async {
            switchAppIcon('MainActivity');
          },
        ),
        Switch(
          value: switchValue,
          onChanged: (value) {
            setState(() {
              switchValue = value;
            });
            if (switchValue) {
              themeNotifier.toggleTheme(ThemeMode.dark);
              switchAppIcon('DarkTheme');
            } else {
              themeNotifier.toggleTheme(ThemeMode.light);
              switchAppIcon('LightTheme');
            }
          },
        ),
        OutlinedButton.icon(
          icon: const Icon(Icons.restore_outlined),
          label: const Text("Switch Icon"),
          onPressed: () async {
            switchAppIcon('DarkTheme');
          },
        ),
      ],
    );
  }
}
