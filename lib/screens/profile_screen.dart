import '../constants/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = 'profile';
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget customTile(String title, IconData icon) {
      return ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Icon(
          icon,
        ),
        title: Text(title),
        trailing: const Icon(
          Icons.chevron_right,
        ),
      );
    }

    return Stack(
      children: [
        const Positioned(
          top: 50,
          left: 20,
          child: Text(
            'Profile',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.white,
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
                          children: const [
                            Icon(
                              Icons.settings,
                              color: Colors.black,
                            ),
                            Icon(
                              CupertinoIcons.create,
                              color: Colors.black,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Peace Emeghara',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        'peace_emeghara@gmail.com',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      const Divider(),
                      customTile(
                        'My Products',
                        Icons.folder_open,
                      ),
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
          child: CircleAvatar(
            radius: 60,
            foregroundColor: Colors.white,
            backgroundColor: Colors.white,
            child: Image.asset(
              'assets/images/default.png',
            ),
          ),
        )
      ],
    );
  }
}
