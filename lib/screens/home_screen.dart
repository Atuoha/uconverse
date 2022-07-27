import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/constants/color.dart';
import '../widgets/favorite_contacts.dart';
import '../widgets/home_chats.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/category_container.dart';
import 'chat_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var user = FirebaseAuth.instance.currentUser;
  // ignore: prefer_typing_uninitialized_variables
  var userDetails;
  var _isLoading = true;
  var _isInit = true;
  void _loadUserDetails() async {
    userDetails = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _loadUserDetails();
    }
    setState(() {
      _isInit = false;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: accentColor,
        onPressed: () {
          Navigator.of(context).pushNamed(ChatScreen.routeName);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
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
            icon: Icon(
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
              child: _isLoading
                  ? const CircleAvatar(
                      backgroundColor: primaryColor,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: accentColor,
                      ),
                    )
                  : userDetails['image'] == ''
                      ? const CircleAvatar(
                          backgroundImage: AssetImage(
                            'assets/images/default.png',
                          ),
                        )
                      : CircleAvatar(
                          backgroundColor: primaryColor,
                          backgroundImage: NetworkImage(userDetails['image']),
                        ),
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
                children: [
                  const FavoriteContacts(),
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
