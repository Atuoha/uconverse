import '../constants/color.dart';
import '../screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';

class HomeChats extends StatelessWidget {
  const HomeChats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var msgData = Provider.of<MessageData>(context);
    var userData = Provider.of<UserData>(context);

    return Expanded(
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
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 20),
              itemCount: msgData.chats.length,
              itemBuilder: (
                context,
                index,
              ) =>
                  GestureDetector(
                onTap: () => Navigator.of(context).pushNamed(
                  ChatScreen.routeName,
                ),
                child: Container(
                  margin: const EdgeInsets.only(top: 6, right: 20),
                  padding: const EdgeInsets.fromLTRB(20, 10, 5, 10),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(10),
                    ),
                    color: msgData.chats[index].unread
                        ? Theme.of(context).primaryColor.withOpacity(0.1)
                        : Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundImage: AssetImage(
                              userData
                                  .findById(
                                    msgData.chats[index].sender,
                                  )
                                  .imageUrl,
                            ),
                          ),
                          const SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userData
                                    .findById(
                                      msgData.chats[index].sender,
                                    )
                                    .name,
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 5),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.50,
                                child: Text(
                                  msgData.chats[index].text,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            msgData.chats[index].time,
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          msgData.chats[index].unread
                              ? Container(
                                  height: 20,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: buttonColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'NEW',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                              : const Text('')
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
