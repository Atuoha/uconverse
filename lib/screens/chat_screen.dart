import '../widgets/sender_chat.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import '../widgets/receiver_chat.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);
  static const routeName = '/chat-screen';

  @override
  Widget build(BuildContext context) {
    var msgData = Provider.of<MessageData>(context);
    var userData = Provider.of<UserData>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(backgroundImage: AssetImage(userData.findById(2).imageUrl),),
            const SizedBox(width: 10),
             Text(
             userData.findById(2).name,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        leading: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 5,
          ),
          child: Container(
            height: 10,
            width: 10,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.white60,
                  blurStyle: BlurStyle.inner,
                  blurRadius: 20.0,
                  spreadRadius: 7,
                  // offset: Offset.fromDirection(direction)
                )
              ],
            ),
            alignment: Alignment.center,
            child: Text(
              '3',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        actions: const [
          IconButton(
            onPressed: null,
            icon: Icon(
              Icons.more_horiz,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: ConstrainedBox(
        constraints: const BoxConstraints.tightFor(
          width: double.infinity,
          height: double.infinity,
        ),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
            ),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
            ),
            child: Column(
              children: [
                Expanded(
                  flex: 7,
                  child: ListView.builder(
                      padding: const EdgeInsets.only(top: 10),
                      itemCount: msgData.messages.length,
                      itemBuilder: (context, index) =>
                          msgData.messages[index].sender != 0
                              ? ReceiverChat(message: msgData.messages[index])
                              : SenderChat(message: msgData.messages[index])),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(20)),
                        child: const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Type your message here...',
                              icon: Icon(
                                Icons.emoji_emotions_outlined,
                              ),
                              suffixIcon: Icon(Icons.attach_file),
                              enabledBorder: InputBorder.none,
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
