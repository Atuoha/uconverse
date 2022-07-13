import '../widgets/favorite_contacts.dart';
import '../widgets/home_chats.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/category_container.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Uconverse',
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Image.asset(
          'assets/images/uconverse.png',
        ),
        actions: [
          const IconButton(
            onPressed: null,
            icon:  Icon(
              Icons.search,
              size: 30,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(
                ProfileScreen.routeName,
              ),
              child: Image.asset('assets/images/default.png', width: 40,),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          const CategoryContainer(),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
              ),
              child: Column(
                children: const [
                  FavoriteContacts(),
                  HomeChats(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
