import 'package:flutter/material.dart';
import 'package:momnotebook/widgets/add_baby/add_baby.dart';
import 'package:momnotebook/widgets/add_baby/add_baby_form.dart';
import 'package:momnotebook/widgets/dashboard/dashboard_widgets/breast_feed/breast_feed_home.dart';
import 'package:momnotebook/widgets/dashboard/dashboard_widgets/breast_pumping/breast_pumping_page.dart';
import 'package:momnotebook/widgets/dashboard/dashboard_widgets/diaper/diaper_home.dart';
import 'package:momnotebook/widgets/dashboard/dashboard_widgets/feeder/feeder_home.dart';
import 'package:momnotebook/widgets/dashboard/dashboard_widgets/food/food_home.dart';
import 'package:momnotebook/widgets/dashboard/dashboard_widgets/sleeping/sleep_home.dart';
import 'package:momnotebook/widgets/dashboard/dashboard_widgets/walking/home_walking.dart';
import 'package:momnotebook/widgets/dashboard/home_dashboard.dart';
import 'package:momnotebook/widgets/pageNotFound/pageNotFound.dart';
import 'package:momnotebook/widgets/splashScreen/auth_content/sign_up/signUpPage.dart';
import 'package:momnotebook/widgets/splashScreen/splashScreen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    final arguments = routeSettings.arguments;
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/sign_up':
        return MaterialPageRoute(builder: (_) => SignUpPage());
      case '/add_baby':
        return MaterialPageRoute(builder: (_) => AddBaby());
      case '/add_baby_form':
        return MaterialPageRoute(builder: (_) => AddBabyForm());
      case '/home_dashboard':
        return MaterialPageRoute(builder: (_) => HomeDashboard());
      case '/feeder':
        return MaterialPageRoute(builder: (_) => HomeFeeder());
      case '/breast_pumping':
        return MaterialPageRoute(builder: (_) => HomeBreastPumping());
      case '/food':
        return MaterialPageRoute(builder: (_) => HomeFood());
      case '/breast_feed':
        return MaterialPageRoute(builder: (_) => HomeBreastFeed());
      case '/sleep':
        return MaterialPageRoute(builder: (_) => HomeSleep());
      case '/walk':
        return MaterialPageRoute(builder: (_) => HomeWalking());
      case '/diaper':
        return MaterialPageRoute(builder: (_) => HomeDiaper());
      default:
        return MaterialPageRoute(builder: (_) => PageNotFound());
    }
  }
}
