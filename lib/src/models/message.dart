class Message {
  final String id;
  final String createdBy;
  final String message;
  final String roomId;
  final DateTime createdAt;

  Message({this.id, this.createdBy, this.message, this.roomId, this.createdAt});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      createdBy: json['createdBy'],
      message: json['message'],
      roomId: json['roomId'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(
          json['createdAt'][r'$date'] * 1000),
    );
  }
}
