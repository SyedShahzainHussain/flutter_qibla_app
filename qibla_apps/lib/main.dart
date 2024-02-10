import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qibla_apps/provider/theme/app_theme.dart';
import 'package:qibla_apps/screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool hasPermission = false;

  Future getPermission() async {
    if (await Permission.location.serviceStatus.isEnabled) {
      var status = await Permission.location.status;
      if (status.isGranted) {
        hasPermission = true;
      } else {
        Permission.location.request().then((value) {
          setState(() {
            hasPermission = (value == PermissionStatus.granted);
          });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Qibla App',
      themeMode: ThemeMode.system,
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: getPermission(),
        builder: (context, snapshot) {
          if (hasPermission) {
            return const SplashScreen();
          } else {
            return Scaffold(
              backgroundColor: Colors.blueGrey.shade600,
              body: const Center(
                child: Text("No Permission Access"),
              ),
            );
          }
        },
      ),
    );
  }
}
