import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qibla_apps/screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (route) => false);
    });
  }

  @override
  Widget build(context) {
    return Scaffold(
      body: Column(children: [
        Center(
          child: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.sizeOf(context).height / 5,
            ),
            child: Image.asset(
              "assets/images/qibla.png",
              color: Colors.blueGrey,
              width: MediaQuery.sizeOf(context).width * .8,
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.05,
        ),
        Text(
          "Welcome To Qibla Finder App",
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: Colors.black,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
        )
      ]),
    );
  }
}
