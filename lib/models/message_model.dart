class Message {
  final int sender;
  final String time;
  final String text;
  bool isLiked;
  final bool unread;

  Message({
    required this.sender,
    required this.time,
    required this.text,
    required this.isLiked,
    required this.unread,
  });

  void toggleLike() {
    isLiked = !isLiked;
  }
}
