
import 'package:ewabooks/UI/Screens/addbookscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../UI/Screens/mainactivity.dart';
import '../UI/Screens/splash_screen.dart';
import '../UI/Widgets/blur_page_route.dart';


class Routes {
  //private constructor
  Routes._();
  static const pageToGoBackTo = "";
  static const splash = 'splash';
  static const main = 'main';
  static const add = 'add';

  static String currentRoute = splash;
  static String previousCustomerRoute = splash;

  static Route onGenerateRouted(RouteSettings routeSettings) {
    previousCustomerRoute = currentRoute;
    currentRoute = routeSettings.name ?? "";
    switch (routeSettings.name){
      case splash:
        return BlurredRouter(builder: ((context) => const SplashScreen()));
      case main:
        return MainAcivityScreen.route(routeSettings);
      case add:
        return AddBookScreen.route(routeSettings);


      default:
        return BlurredRouter(
          builder: ((context) => Scaffold(
                body: Text(
                 'pageNotFoundErrorMsg',
                ),
              )),
        );
    }
  }
}
