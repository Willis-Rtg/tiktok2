import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:tiktok2/common/video_config/config.dart';
import 'package:tiktok2/constants/breakpoints.dart';
import 'package:tiktok2/constants/gaps.dart';
import 'package:tiktok2/features/video/vm/playback_config_vm.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder:
          (context) => Container(
            height: 200,
            color: Colors.red,
            child: Text("Bottom Sheet"),
          ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: Breakpoints.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 200,
                  child: Transform.rotate(
                    angle: 1.57,
                    child: ListWheelScrollView(
                      magnification: 1.4,
                      useMagnifier: true,
                      diameterRatio: 2,
                      itemExtent: MediaQuery.of(context).size.width * 0.4,
                      children: [
                        for (var x in [1, 2, 3, 4, 5, 1, 2, 3, 2, 1, 2, 1])
                          FractionallySizedBox(
                            widthFactor: 1,
                            child: Container(
                              alignment: Alignment.center,
                              color: Colors.red,
                              child: Text("Pick me"),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Gaps.v20,
                CupertinoActivityIndicator(),
                CircularProgressIndicator.adaptive(),
                Gaps.v52,

                ListTile(
                  title: Text("Auto Muted"),
                  subtitle: Text("Auto Muted"),
                  trailing: Switch.adaptive(
                    value: ref.watch(playbackConfigProvider).muted,
                    onChanged: (value) {
                      ref.read(playbackConfigProvider.notifier).setMuted(value);
                    },
                  ),
                ),
                ListTile(
                  title: Text("Auto Play"),
                  subtitle: Text("Auto Play"),
                  trailing: Switch.adaptive(
                    value: ref.watch(playbackConfigProvider).autoPlay,
                    onChanged: (value) {
                      ref
                          .read(playbackConfigProvider.notifier)
                          .setAutoPlay(value);
                    },
                  ),
                ),

                ListTile(
                  title: Text("Abouut..."),
                  subtitle: Text("About TikTok"),
                  onTap:
                      () => showAboutDialog(
                        context: context,
                        applicationVersion: "1.0.0",
                        applicationLegalese:
                            "All rights reserved. Please dont copy me.",
                        children: [Text("About TikTok")],
                      ),
                ),
                AboutListTile(
                  applicationName: "TikTok",
                  applicationVersion: "1.0.0",
                  applicationIcon: Icon(Icons.info),
                  applicationLegalese:
                      "All rights reserved. Please dont copy me.",
                ),
                ListTile(
                  title: Text("What is your birthday?"),
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      firstDate: DateTime(1980),
                      lastDate: DateTime(2030),
                    );
                    print(date);
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    print(time);
                    final dateRange = await showDateRangePicker(
                      context: context,
                      firstDate: DateTime(1980),
                      lastDate: DateTime(2030),
                      barrierColor: Colors.red,
                      builder: (context, child) {
                        return Theme(
                          data: ThemeData(
                            primaryColor: Colors.red,
                            colorScheme: ColorScheme.fromSeed(
                              seedColor: Colors.red,
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );
                    print(dateRange);
                  },
                ),
                CupertinoSwitch(value: false, onChanged: (value) {}),
                SwitchListTile(
                  title: Text("Notification"),
                  value: false,
                  onChanged: (value) {},
                ),
                CheckboxListTile(
                  title: Text("Notification"),
                  value: false,
                  onChanged: (value) {},
                ),
                ListTile(
                  title: Text(
                    "Logout / ios",
                    style: TextStyle(color: Colors.red),
                  ),
                  onTap: () {
                    showCupertinoDialog(
                      context: context,
                      builder:
                          (context) => CupertinoAlertDialog(
                            title: Text("Are you sure?"),
                            actions: [
                              CupertinoDialogAction(
                                child: Text("Cancel"),
                                onPressed: () => Navigator.pop(context),
                              ),
                              CupertinoDialogAction(
                                isDestructiveAction: true,
                                onPressed: () => Navigator.pop(context),
                                child: Text("Logout"),
                              ),
                            ],
                          ),
                    );
                  },
                ),
                ListTile(
                  title: Text(
                    "Logout / android",
                    style: TextStyle(color: Colors.red),
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder:
                          (context) => AlertDialog(
                            title: Text("Are you sure?"),
                            actions: [
                              TextButton(
                                child: Text("Cancel"),
                                onPressed: () => Navigator.pop(context),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(
                                  "Logout",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                    );
                  },
                ),
                ListTile(
                  title: Text(
                    "Logout / bottom sheet",
                    style: TextStyle(color: Colors.red),
                  ),
                  onTap: () => _showBottomSheet(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
