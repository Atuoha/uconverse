import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/users.dart';

class FavoriteContacts extends StatelessWidget {
  const FavoriteContacts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userData = Provider.of<UserData>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Favorite contacts',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              Icon(
                Icons.more_horiz,
                color: Colors.grey,
              )
            ],
          ),
        ),
        SizedBox(
          height: 110,
          child: ListView.builder(
            padding: const EdgeInsets.only(left: 8),
            scrollDirection: Axis.horizontal,
            itemCount: userData.favorites.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 5,
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage(
                      userData
                          .findById(
                            userData.favorites[index],
                          )
                          .imageUrl,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    userData
                        .findById(
                          userData.favorites[index],
                        )
                        .name,
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
