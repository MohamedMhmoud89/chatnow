class Message {
  static const String collectionName = 'message';
  String? id;
  String? content;
  String? senderName;
  String? senderId;
  int? dateTime;
  String? roomId;

  Message(
      {this.dateTime,
      this.content,
      this.id,
      this.roomId,
      this.senderId,
      this.senderName});

  Message.fromFireStore(Map<String, dynamic> data) {
    id = data['id'];
    content = data['content'];
    senderName = data['senderName'];
    senderId = data['senderId'];
    dateTime = data['dateTime'];
    roomId = data['roomId'];
  }

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'content': content,
      'senderName': senderName,
      'senderId': senderId,
      'dateTime': dateTime,
      'roomId': roomId
    };
  }
}
