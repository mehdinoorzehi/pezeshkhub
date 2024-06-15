import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

import '../controllers/check_login_time.dart';
import '../controllers/constant.dart';
import 'home_page.dart';
import 'check_mobile_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.ease,
    );

    _controller.forward();

    Timer(const Duration(seconds: 3), () async {
      bool isLoggedIn = await checkLoginTime();
      if (isLoggedIn) {
        Get.off(() => HomePage());
      } else {
        Get.off(() => const CheckMobilePage());
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KLightGreyColore,
      body: Center(
        child: ScaleTransition(
            scale: _animation,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.hub_outlined,
                  color: Colors.white,
                  size: 50,
                ),
                Text(
                  'پزشک هاب',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                )
              ],
            )),
      ),
    );
  }
}
