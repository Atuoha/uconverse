import 'package:cloud_firestore/cloud_firestore.dart';
import '../constants/color.dart';
import '../screens/chat_screen.dart';
import 'package:flutter/material.dart';

class HomeChats extends StatelessWidget {
  HomeChats({Key? key}) : super(key: key);

  final CollectionReference chats = FirebaseFirestore.instance
      .collection('chats/i9IFa7EAlYRZvzQkdUVQ/messages');

  @override
  Widget build(BuildContext context) {
    // var msgData = Provider.of<MessageData>(context);
    // var userData = Provider.of<UserData>(context);

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
          child: StreamBuilder(
            stream: chats.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  padding: const EdgeInsets.only(top: 20),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (
                    context,
                    index,
                  ) {
                    final DocumentSnapshot documentSnapshot =
                        snapshot.data!.docs[index];
                    return GestureDetector(
                      onTap: () => Navigator.of(context).pushNamed(
                        ChatScreen.routeName,
                      ),
                      child: Container(
                        margin: const EdgeInsets.only(top: 6, right: 20),
                        padding: const EdgeInsets.fromLTRB(20, 10, 5, 10),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(10),
                          ),
                          color: Colors.white,
                          // documentSnapshot['unread']
                          //     ? Theme.of(context)
                          //         .primaryColor
                          //         .withOpacity(0.1)
                          //     : Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const CircleAvatar(
                                  radius: 25,
                                  backgroundImage: AssetImage(
                                    'assets/images/sophia.jpg',
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'User',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: primaryColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.50,
                                      child: Text(
                                        documentSnapshot['text'],
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
                              children: const [
                                Text(
                                  '12:00',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.blueGrey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                // msgData.chats[index].unread
                                //     ? Container(
                                //         height: 20,
                                //         width: 40,
                                //         decoration: BoxDecoration(
                                //           color: buttonColor,
                                //           borderRadius:
                                //               BorderRadius.circular(10),
                                //         ),
                                //         child: const Center(
                                //           child: Text(
                                //             'NEW',
                                //             style: TextStyle(
                                //               fontSize: 10,
                                //               fontWeight: FontWeight.bold,
                                //               color: Colors.white,
                                //             ),
                                //           ),
                                //         ),
                                //       )
                                //     : const Text('')
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
