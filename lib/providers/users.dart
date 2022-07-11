import '../models/user_model.dart';
import 'package:flutter/material.dart';

class UserData extends ChangeNotifier {
  User findById(int id) {
    return _users.firstWhere((user) => user.id == id);
  }

  List users() {
    return [..._users];
  }

  final List _users = [
    User(
      id: 0,
      name: 'Current User',
      imageUrl: 'assets/images/greg.jpg',
    ),
    User(
      id: 1,
      name: 'Greg',
      imageUrl: 'assets/images/greg.jpg',
    ),
    User(
      id: 2,
      name: 'James',
      imageUrl: 'assets/images/james.jpg',
    ),
    User(
      id: 3,
      name: 'John',
      imageUrl: 'assets/images/john.jpg',
    ),
    User(
      id: 4,
      name: 'Olivia',
      imageUrl: 'assets/images/olivia.jpg',
    ),
    User(
      id: 5,
      name: 'Sam',
      imageUrl: 'assets/images/sam.jpg',
    ),
    User(
      id: 6,
      name: 'Sophia',
      imageUrl: 'assets/images/sophia.jpg',
    ),
    User(
      id: 7,
      name: 'Steven',
      imageUrl: 'assets/images/steven.jpg',
    )
  ];

// FAVORITE CONTACTS
  List<int> favorites = [5, 7, 4, 3, 1];
}
