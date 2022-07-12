import 'auth/auth_screen.dart';
import 'providers/providers.dart';
import 'screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'constants/color.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/splash_screen.dart';

void main() => runApp(const Uconverse());

class Uconverse extends StatelessWidget {
  const Uconverse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserData(),
        ),
        ChangeNotifierProvider(
          create: (context) => MessageData(),
        ),
      ],
      child: MaterialApp(
        title: 'Uconverse',
        theme: ThemeData(
          primaryColor: primaryColor,
          // primarySwatch: primaryColor,
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: primaryColor,
            secondary: accentColor,
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        routes:  {
          ChatScreen.routeName:(context) => const ChatScreen(),
          HomeScreen.routeName:(context) => const HomeScreen(),
          AuthScreen.routeName:(context) => const AuthScreen(),
          ProfileScreen.routeName:(context) => const ProfileScreen(),
        },
      ),
    );
  }
}
