import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SenderChat extends StatelessWidget {
  final String message;
  final Timestamp time;
  final String username;
  final String imageAsset;

  const SenderChat({
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
        top: 10,
        left: 60,
        bottom: 10,
      ),
      child: Row(
        children: [
          Container(
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                // bottomLeft: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 20, 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chatTime.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.60,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(username),
                        Text(
                          message,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
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
            width: 15,
          ),
          CircleAvatar(
            radius: 20,
            child: imageAsset.isEmpty
                ? Image.network(imageAsset)
                : Image.asset('assets/images/default.png'),
          ),
        ],
      ),
    );
  }
}
