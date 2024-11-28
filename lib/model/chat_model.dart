class ChatModel {
  String id;
  String message;
  bool isMe;
  ChatModel({required this.id, required this.message, required this.isMe});
  @override
  String toString() {
    return message;
  }
}
