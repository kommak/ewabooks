import 'dart:async';


import 'package:alphabet_animation/alphabet_animation.dart';
import 'package:ewabooks/app/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

import '../../app/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  bool isTimerCompleted = false;
  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    super.dispose();
  }


  startTimer() async {
    Timer(
      const Duration(seconds: 3),
      () {
        isTimerCompleted = true;

        if (mounted) setState(() {});
      },
    );
  }

  navigateCheck() {
    if (isTimerCompleted) {
      navigateToScreen();
    }
  }

  navigateToScreen() {
      Future.delayed(Duration.zero, () {
        Navigator.of(context).pushReplacementNamed(
          Routes.main,
        );
    });
  }

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;

    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    navigateCheck();

    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
         Container(
           width: width,
           height: height,
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.center,
             children: [
               SizedBox(
                 width: 170,
                 height: 170,
                 child:  Lottie.asset('assets/lottie/books.json',repeat: false),
               ),
               SizedBox(height: 25,),
               AnimationTypeOne(
                 text: "E             W             A             B            o             o           k           s",
                 animationType: AnimationType.scaleUp,
                 repeat: false,
                 textStyle: TextStyle(
                     color: primaryColor_,
                     fontSize: 6,
                     fontWeight: FontWeight.bold
                 ),)

             ],
           ),
         ),
            const Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Text('App Version:1.1.1',)
              ),),
          ],
        ),
      ),
    );
  }
}
