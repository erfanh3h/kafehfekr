class MessageModel {
  final String username, content, userId;
  final DateTime time;

  MessageModel({
    required this.username,
    required this.content,
    required this.time,
    required this.userId,
  });
}
