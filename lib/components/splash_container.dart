import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '/auth/auth_screen.dart';
import '../constants/color.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashContainer extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageAsset;
  final Color backgroundColor;
  final Color textColor;
  final bool isLast;
  final bool isFirst;
  const SplashContainer({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.imageAsset,
    required this.backgroundColor,
    required this.textColor,
    this.isLast = false,
    this.isFirst = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(imageAsset, fit: BoxFit.cover),
                // const SizedBox(height: 10),
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: textColor,
                    fontSize: 29,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: textColor,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 10),

                isLast
                    ? ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          primary: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        icon: const Icon(
                          Icons.emoji_emotions,
                          color: Colors.white,
                        ),
                        label: const Text(
                          'Start exploring',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          FirebaseAuth.instance
                              .authStateChanges()
                              .listen((User? user) {
                            if (user != null) {
                              // user is signed in
                              Navigator.of(
                                context,
                              ).pushNamed(
                                HomeScreen.routeName,
                              );
                            } else {
                              // user is not signed in
                              Navigator.of(
                                context,
                              ).pushNamed(
                                AuthScreen.routeName,
                              );
                            }
                          });
                        })
                    : const Text(''),
              ]),
          isFirst
              ? Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/swipeRight.gif',
                          width: 100,
                        ),
                        const Text(
                          '...swipe right to skip',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : isLast
                  ? const Text('')
                  : Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/swipeLeft.gif',
                              width: 100,
                            ),
                            const Text(
                              '...swipe left to continue',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
        ],
      ),
    );
  }
}
