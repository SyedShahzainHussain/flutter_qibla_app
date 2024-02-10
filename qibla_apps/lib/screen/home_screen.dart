import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

Animation<double>? animation;
AnimationController? animationController;
double begin = 0.0;

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    animation = Tween(begin: 0.0, end: 0.0).animate(animationController!);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: StreamBuilder(
          stream: FlutterQiblah.qiblahStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator(
                  color: Colors.grey,
                ),
              );
            }

            final qiblaDirection = snapshot.data;
            animation = Tween(
                    begin: begin,
                    end: (qiblaDirection!.qiblah * (pi / 180) * -1))
                .animate(animationController!);
            begin = (qiblaDirection.qiblah * (pi / 180) * -1);
            animationController!.forward(from: 0);
            return Center(
              child: AnimatedBuilder(
                animation: animation!,
                builder: (context, child) => Transform.rotate(
                  angle: animation!.value,
                  child: Image.asset("assets/images/qibla_image.png"),
                ),
              ),
            );
          }),
    ));
  }
}
