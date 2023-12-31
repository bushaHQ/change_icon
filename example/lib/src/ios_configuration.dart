// ignore_for_file: use_build_context_synchronously

import 'package:changeicon/Changeicon.dart';
import 'package:changeicon_example/src/theme/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IOSConfiguration extends StatefulWidget {
  const IOSConfiguration({super.key});

  @override
  State<IOSConfiguration> createState() => _IOSConfigurationState();
}

class _IOSConfigurationState extends State<IOSConfiguration> {
  int batchIconNumber = 0;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  String currentIconName = "?";

  bool loading = false;
  bool showAlert = true;

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    Changeicon.getApplicationIconBadgeNumber().then((v) {
      setState(() {
        batchIconNumber = v;
      });
    });

    Changeicon.getAlternateIconName().then((v) {
      setState(() {
        currentIconName = v ?? "`primary`";
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Current batch number: $batchIconNumber",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        TextField(
          controller: controller,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp("\\d+")),
          ],
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: "Set Batch Icon Number",
            suffixIcon: loading
                ? const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(
                        // strokeWidth: 2,
                        ),
                  )
                : IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });
                      try {
                        await Changeicon.setApplicationIconBadgeNumber(
                            int.parse(controller.text));
                        batchIconNumber =
                            await Changeicon.getApplicationIconBadgeNumber();
                        if (mounted) {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Successfully changed batch number"),
                          ));
                        }
                      } on PlatformException {
                        if (mounted) {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Failed to change batch number"),
                          ));
                        }
                      } catch (e) {
                        if (mounted) {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Failed to change batch number"),
                          ));
                        }
                      }

                      setState(() {
                        loading = false;
                      });
                    },
                  ),
          ),
        ),
        const SizedBox(
          height: 28,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Current Icon Name: $currentIconName",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        SwitchListTile(
            title: const Text("Show Alert"),
            subtitle: const Text(
                "Disable alert at your own risk as it uses a private/undocumented API"),
            value: showAlert,
            onChanged: (value) {
              setState(() {
                showAlert = value;
              });
            }),
        OutlinedButton.icon(
          icon: const Icon(Icons.ac_unit),
          label: const Text("Team Fortress"),
          onPressed: () async {
            try {
              if (await Changeicon.supportsAlternateIcons) {
                await Changeicon.setAlternateIconName("teamfortress",
                    showAlert: showAlert);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("App icon change successful"),
                ));
                Changeicon.getAlternateIconName().then((v) {
                  setState(() {
                    currentIconName = v ?? "`primary`";
                  });
                });
                return;
              }
            } catch (e) {
              debugPrint(e.toString());
            }
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Failed to change app icon"),
            ));
          },
        ),
        OutlinedButton.icon(
          icon: const Icon(Icons.ac_unit),
          label: const Text("Chills"),
          onPressed: () async {
            try {
              if (await Changeicon.supportsAlternateIcons) {
                await Changeicon.setAlternateIconName("chills",
                    showAlert: showAlert);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("App icon change successful"),
                ));
                Changeicon.getAlternateIconName().then((v) {
                  setState(() {
                    currentIconName = v ?? "`primary`";
                  });
                });
                return;
              }
            } catch (e) {
              debugPrint(e.toString());
            }
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Failed to change app icon"),
            ));
          },
        ),
        const SizedBox(
          height: 28,
        ),
        OutlinedButton.icon(
          icon: const Icon(Icons.restore_outlined),
          label: const Text("Restore Icon"),
          onPressed: () async {
            try {
              if (await Changeicon.supportsAlternateIcons) {
                await Changeicon.setAlternateIconName(null,
                    showAlert: showAlert);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("App icon restore successful"),
                ));
                Changeicon.getAlternateIconName().then((v) {
                  setState(() {
                    currentIconName = v ?? "`primary`";
                  });
                });
                return;
              }
            } catch (e) {
              debugPrint(e.toString());
            }
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Failed to change app icon"),
            ));
          },
        ),
        OutlinedButton.icon(
          icon: const Icon(Icons.theater_comedy),
          label: const Text("Change theme"),
          onPressed: () async {
            var value = themeNotifier.themeMode == ThemeMode.light;
            themeNotifier.toggleTheme(
              value ? ThemeMode.dark : ThemeMode.light,
            );
          },
        ),
      ],
    );
  }
}
