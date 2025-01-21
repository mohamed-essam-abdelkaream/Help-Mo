import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wrshaonline/main.dart';
import '../../core/constant/routes.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.immersiveSticky); // إخفاء شريط الحالة
    super.initState();
    Timer(const Duration(seconds: 2), () {
      checkStatusAndNavigate();
    });
  }

  void checkStatusAndNavigate() {
    if (prefs?.getString("status") == "1") {
      Get.offNamed(AppRoute.homePage);
    } else {
      Get.offNamed(AppRoute.login);
    }
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values); // إعادة إظهار شريط الحالة
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splash.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
