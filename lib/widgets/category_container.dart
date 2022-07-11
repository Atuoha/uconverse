import 'package:flutter/material.dart';
import '../constants/color.dart';

// ignore: must_be_immutable
class CategoryContainer extends StatefulWidget {
  const CategoryContainer({Key? key}) : super(key: key);

  @override
  State<CategoryContainer> createState() => _CategoryContainerState();
}

class _CategoryContainerState extends State<CategoryContainer> {
  var selectedIndex = 0;

  List<String> categories = [
    'Messages',
    'Online👋',
    'Groups',
    'Requests',
  ];

  Widget textCategory(String title, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Text(
        title,
        style: TextStyle(
          color: index == selectedIndex ? Colors.white : greyAccent,
          fontSize: 24,
          letterSpacing: 1.5,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.0,
      color: Theme.of(context).primaryColor,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 30,
          ),
          child: textCategory(
            categories[index],
            index,
          ),
        ),
      ),
    );
  }
}
