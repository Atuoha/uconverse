import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uconverse/constants/color.dart';

class ReceiverChat extends StatelessWidget {
  final String message;
  final Timestamp time;
  final String username;
  final String imageAsset;

  const ReceiverChat({
    Key? key,
    required this.message,
    required this.time,
    required this.username,
    required this.imageAsset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime toDate(time) {
      return DateTime.fromMicrosecondsSinceEpoch(time.microsecondsSinceEpoch);
    }

    var date = toDate(time);
    var chatTime = DateFormat.jm().format(date);

    return Container(
      margin: const EdgeInsets.only(
        right: 20,
        top: 10,
        bottom: 10,
      ),
      child: Row(
        children: [
          Container(
            alignment: Alignment.topRight,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        chatTime.toString(),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        username,
                        style: const TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.60,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          message,
                          style: const TextStyle(
                            color: Colors.blueGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          CircleAvatar(
            backgroundColor: primaryColor,
            radius: 20,
            child: imageAsset.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(35),
                    child: Image.network(imageAsset),
                  )
                : Image.asset('assets/images/default.png'),
          ),
        ],
      ),
    );
  }
}
