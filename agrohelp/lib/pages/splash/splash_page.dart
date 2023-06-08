import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:agrohelp/routes/route_helper.dart';

import '../../utils/dimentions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{
  late Animation<double> animation;
  late AnimationController controller;
  late bool ok;



  @override
  void initState(){
    super.initState();
    controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 2)
    )..forward();
    animation = CurvedAnimation(
        parent: controller,
        curve: Curves.linear
    );

    Timer(
      const Duration(seconds: 3),
        ()=> Get.offNamed(RouteHelper.getInitial())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(scale: animation,
              child: Center(child: Image.asset("assets/images/logo.png", width: Dimensions.width20(context)*15,))
            ),
            Center(child: Image.asset("assets/images/bestfood2.jpeg", width: Dimensions.width20(context)*15,)),
          ],
        )
      ),
    );
  }

}
