import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:uconverse/screens/edit_profile.dart';
import 'auth/auth_screen.dart';
import 'providers/providers.dart';
import 'screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'constants/color.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/splash_screen.dart';
import 'firebase_options.dart';

// void main() => runApp(const Uconverse());

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Uconverse());
  if (kDebugMode) {
    print('Initialized default app $app');
  }
}

class Uconverse extends StatelessWidget {
  const Uconverse({Key? key}) : super(key: key);

  Future<void> initializeDefault() async {
    FirebaseApp app = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    if (kDebugMode) {
      print('Initialized default app $app');
    }
  }

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
        routes: {
          ChatScreen.routeName: (context) =>  const ChatScreen(),
          HomeScreen.routeName: (context) => const HomeScreen(),
          AuthScreen.routeName: (context) => const AuthScreen(),
          ProfileScreen.routeName: (context) => const ProfileScreen(),
          EditProfile.routeName: (context) => const EditProfile(),
        },
      ),
    );
  }
}
