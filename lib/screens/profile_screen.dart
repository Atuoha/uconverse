import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:provider/provider.dart';
import 'package:uconverse/screens/edit_profile.dart';
import '../constants/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../providers/providers.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = 'profile';
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // ignore: prefer_typing_uninitialized_variables
  var userDetails;
  var user = FirebaseAuth.instance.currentUser;
  var _isLoading = true;

  void loadProfileData() async {
    userDetails = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    setState(
      () {
        _isLoading = false;
      },
    );
  }

  var isInit = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      loadProfileData();
    }
    setState(() {
      isInit = false;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Widget customTile(String title, IconData icon) {
      return ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Icon(icon, color: buttonColor),
        title: Text(title),
        trailing: const Icon(
          Icons.chevron_right,
        ),
      );
    }

    // var user = FirebaseAuth.instance.currentUser;
    var loginMode = Provider.of<UserData>(context, listen: false).loginMode;

    Future showLogoutModal() {
      String titleMode;
      if (loginMode == 0) {
        // email - password auth type
        titleMode = 'Email and Password';
      } else if (loginMode == 1) {
        // google auth type
        titleMode = 'Google';
      } else {
        // facebook auth type
        titleMode = 'Facebook';
      }
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Center(
            child: Text(
              'Logout Account?',
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          content: Text('You are currently logged in using $titleMode.',
              textAlign: TextAlign.center),
          actions: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: accentColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () async {
                if (loginMode == 0) {
                  // logout email - password auth type
                  await FirebaseAuth.instance.signOut();
                } else if (loginMode == 1) {
                  // logout google auth type
                  await FirebaseAuth.instance.signOut();
                } else {
                  // logout facebook auth type
                  await FacebookAuth.instance.logOut();
                  await FirebaseAuth.instance.signOut();
                }
              },
              label: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          if (_isLoading) ...[
            const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            )
          ] else ...[
            const Positioned(
              top: 50,
              right: 20,
              child: Text(
                'Profile',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: accentColor,
                ),
              ),
            ),
            Positioned(
              top: 35,
              left: 0,
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(
                  Icons.chevron_left,
                  size: 34,
                  color: accentColor,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  color: primaryColor,
                ),
                height: 500,
                width: double.infinity,
              ),
            ),
            Positioned(
              top: 120,
              left: 20,
              right: 20,
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                    height: 500,
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 15.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () => showLogoutModal(),
                                  child: const Icon(
                                    Icons.logout,
                                    color: buttonColor,
                                  ),
                                ),

                                // allowing profile edit if loginMode is email and password
                                loginMode == 0
                                    ? GestureDetector(
                                        onTap: () =>
                                            Navigator.of(context).pushNamed(
                                          EditProfile.routeName,
                                        ),
                                        child: const Icon(
                                          CupertinoIcons.create,
                                          color: buttonColor,
                                        ),
                                      )
                                    : const Text('')
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            userDetails!['username'],
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            userDetails!['email'],
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          const Divider(),
                          customTile(
                            'Acccount',
                            Icons.person,
                          ),
                          customTile(
                            'Review',
                            Icons.star,
                          ),
                          customTile(
                            'Share',
                            Icons.share,
                          ),
                          customTile(
                            'Info',
                            Icons.info,
                          ),
                        ],
                      ),
                    )),
              ),
            ),
            Positioned(
              top: 65,
              left: 30,
              right: 30,
              child: SizedBox(
                height: 120,
                width: 120,
                child: userDetails!['image'] != ''
                    ? CircleAvatar(
                        radius: 120,
                        backgroundColor: primaryColor,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.network(userDetails!['image'])),
                      )
                    : CircleAvatar(
                        child: Image.asset('assets/images/default.png'),
                      ),
              ),
            )
          ]
        ],
      ),
    );
  }
}
