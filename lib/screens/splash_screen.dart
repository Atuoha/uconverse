import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:flutter/services.dart';

import '../components/splash_container.dart';
import '../constants/color.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  int page = 0;
  LiquidController? liquidController;
  UpdateType? updatetype;
  @override
  void initState() {
    liquidController = LiquidController();
    super.initState();
  }

  final pages = [
    const SplashContainer(
      title: 'Uconverse',
      subtitle: '...conversing without limits',
      imageAsset: 'assets/images/uconverse.jpg',
      backgroundColor: Colors.white,
      textColor: primaryColor,
    ),
    const SplashContainer(
      title: 'Feel the vibes of others',
      subtitle: 'allowing the springs of others to find you',
      imageAsset: 'assets/images/slider4.png',
      backgroundColor: primaryColor,
      textColor: Colors.white,

    ),
    const SplashContainer(
      title: 'Grow outside your space',
      subtitle: 'reaching out to more stands outside your space',
      imageAsset: 'assets/images/slider2.png',
      backgroundColor: buttonColor,
      textColor: Colors.white,

    ),
    const SplashContainer(
      title: 'Find new people',
      subtitle: 'discovering awesome new people around you',
      imageAsset: 'assets/images/slider3.png',
      backgroundColor: accentColor,
      textColor: Colors.white,
    ),
      const SplashContainer(
      title: 'An Open World',
      subtitle: 'a place you\'ll feel more connected with people',
      imageAsset: 'assets/images/quick.png',
      backgroundColor: Colors.white,
      textColor: primaryColor,
      isLast: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    return Scaffold(
      body: LiquidSwipe(
        pages: pages,
        fullTransitionValue: 500,
      ),
    );
  }
}
