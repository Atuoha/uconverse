import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/sender_chat.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import '../widgets/receiver_chat.dart';
import '../constants/color.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);
  static const routeName = '/chat-screen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final CollectionReference _chats = FirebaseFirestore.instance
      .collection('chats/i9IFa7EAlYRZvzQkdUVQ/messages');

  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _textController.addListener(() {
      setState(() {});
    });
  }

  bool emojiShowing = false;

  _onEmojiSelected(Emoji emoji) {
    _textController
      ..text += emoji.emoji
      ..selection = TextSelection.fromPosition(
        TextPosition(
          offset: _textController.text.length,
        ),
      );
  }

  _onBackspacePressed() {
    _textController
      ..text = _textController.text.characters.skipLast(1).toString()
      ..selection = TextSelection.fromPosition(
        TextPosition(
          offset: _textController.text.length,
        ),
      );
  }

  void sendChat() async {
    FocusScope.of(context).unfocus(); // closing the keyboard
    var chat = _textController.text.trim();
    var user = FirebaseAuth.instance.currentUser;
    var userDetails = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    if (chat.isNotEmpty) {
      _chats.add({
        'msg': chat,
        'userId': user.uid,
        'createdAt': Timestamp.now(),
        'username': userDetails['username'],
        'image': userDetails['image']
      });
      _textController.clear();
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    // var msgData = Provider.of<MessageData>(context);
    // var userData = Provider.of<UserData>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            // CircleAvatar(
            //   backgroundImage: NetworkImage(
            //     'https://firebasestorage.googleapis.com/v0/b/uconverse-c940b.appspot.com/o/user_images%2FhiYFC5gCM6YWLnBparp7vgNiR643.jpg?alt=media&token=f513fb78-725e-4245-87e2-773c199172e3',
            //   ),
            // ),
            SizedBox(width: 10),
            Text(
              'Conversations',
              style: TextStyle(
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
          child: InkWell(
            onTap: () => Navigator.of(context).pop(),
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
                  )
                ],
              ),
              alignment: Alignment.center,
              child: const Icon(Icons.chevron_left, color: primaryColor),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SizedBox(
                    child: StreamBuilder(
                      stream: _chats.orderBy('createdAt').snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            // reverse:true,
                            padding: const EdgeInsets.only(top: 10),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              final DocumentSnapshot documentSnapshot =
                                  snapshot.data!.docs[index];

                              return documentSnapshot['userId'] ==
                                      FirebaseAuth.instance.currentUser!.uid
                                  ? SenderChat(
                                      message: documentSnapshot['msg'],
                                      time: documentSnapshot['createdAt'],
                                      username: documentSnapshot['username'],
                                      imageAsset: documentSnapshot['image'],
                                    )
                                  : ReceiverChat(
                                      message: documentSnapshot['msg'],
                                      time: documentSnapshot['createdAt'],
                                      username: documentSnapshot['username'],
                                      imageAsset: documentSnapshot['image'],
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
                SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.manual,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //
                          Expanded(
                            flex: 1,
                            child: CircleAvatar(
                              backgroundColor: accentColor,
                              child: Center(
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.emoji_emotions,
                                    size: 25,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      emojiShowing = !emojiShowing;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: TextField(
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                  controller: _textController,
                                  decoration: const InputDecoration(
                                    hintText: 'Type your message here...',
                                    hintStyle: TextStyle(color: Colors.white),
                                    // icon: Icon(
                                    //   Icons.emoji_emotions_outlined,
                                    //   color: Colors.white,
                                    // ),
                                    suffixIcon: Icon(
                                      Icons.attach_file,
                                      color: Colors.white,
                                    ),
                                    enabledBorder: InputBorder.none,
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: CircleAvatar(
                              backgroundColor: accentColor,
                              child: Center(
                                child: IconButton(
                                  icon: Icon(
                                    _textController.text.isNotEmpty
                                        ? Icons.send
                                        : Icons.keyboard_voice,
                                    size: 25,
                                    color: Colors.white,
                                  ),
                                  onPressed: () => sendChat(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: !emojiShowing,
                  child: SizedBox(
                    height: 250,
                    child: EmojiPicker(
                      onEmojiSelected: (Category category, Emoji emoji) {
                        _onEmojiSelected(emoji);
                      },
                      onBackspacePressed: _onBackspacePressed,
                      config: Config(
                        columns: 7,
                        emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                        verticalSpacing: 0,
                        horizontalSpacing: 0,
                        gridPadding: EdgeInsets.zero,
                        initCategory: Category.RECENT,
                        bgColor: const Color(0xFFF2F2F2),
                        indicatorColor: primaryColor,
                        iconColor: Colors.grey,
                        iconColorSelected: primaryColor,
                        progressIndicatorColor: primaryColor,
                        backspaceColor: primaryColor,
                        skinToneDialogBgColor: Colors.white,
                        skinToneIndicatorColor: Colors.grey,
                        enableSkinTones: true,
                        showRecentsTab: true,
                        recentsLimit: 28,
                        replaceEmojiOnLimitExceed: false,
                        noRecents: const Text(
                          'No Recents',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black26,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        tabIndicatorAnimDuration: kTabScrollDuration,
                        categoryIcons: const CategoryIcons(),
                        buttonMode: ButtonMode.MATERIAL,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
