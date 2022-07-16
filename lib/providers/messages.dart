import 'package:flutter/cupertino.dart';

import '../models/message_model.dart';

class MessageData extends ChangeNotifier {
// EXAMPLE CHATS ON HOME SCREEN
  final List chats = [
    Message(
      sender: 2,
      time: '5:30 PM',
      text: 'Hey, how\'s it going? What did you do today?',
      isLiked: false,
      unread: true,
    ),
    Message(
      sender: 3,
      time: '3:30 PM',
      text: 'Can I bring it to your house today?',
      isLiked: false,
      unread: false,
    ),
    
  ];

// EXAMPLE MESSAGES IN CHAT SCREEN
  // final List messages = [
  //   Message(
  //     sender: 2,
  //     time: '5:30 PM',
  //     text: 'Hey, how\'s it going? What did you do today?',
  //     isLiked: true,
  //     unread: true,
  //   ),
  //   Message(
  //     sender: 0,
  //     time: '4:30 PM',
  //     text: 'Just finished the chat app prototype on dribble. It was fun and nice!',
  //     isLiked: false,
  //     unread: true,
  //   ),
  //   Message(
  //     sender: 2,
  //     time: '3:45 PM',
  //     text: 'How\'s the prototype?',
  //     isLiked: false,
  //     unread: true,
  //   ),
  //    Message(
  //     sender: 0,
  //     time: '2:30 PM',
  //     text: 'It was cool and had good layout concepts.',
  //     isLiked: false,
  //     unread: true,
  //   ),
  //   Message(
  //     sender: 2,
  //     time: '3:15 PM',
  //     text: 'Nice! What language did you use?',
  //     isLiked: true,
  //     unread: true,
  //   ),
   
  //   Message(
  //     sender: 0,
  //     time: '2:00 PM',
  //     text: 'Flutter and Dart. It\'s super cool and awesome',
  //     isLiked: false,
  //     unread: true,
  //   ),
  // ];
}
