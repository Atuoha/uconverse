import 'package:flutter/material.dart';
import '/auth/auth_screen.dart';
import '../constants/color.dart';

class SplashContainer extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageAsset;
  final Color backgroundColor;
  final Color textColor;
  final bool isLast;
  const SplashContainer({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.imageAsset,
    required this.backgroundColor,
    required this.textColor,
    this.isLast = false,
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
          Image.asset(imageAsset, fit: BoxFit.cover),
          const SizedBox(height: 20),
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
                  onPressed: () => Navigator.of(context).pushNamed(
                    AuthScreen.routeName,
                  ),
                )
              : const Text('')
        ],
      ),
    );
  }
}
