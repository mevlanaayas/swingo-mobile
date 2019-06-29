class ChatRoom {
  final String id;
  final String firstUser;
  final String secondUser;
  final int bidId;
  final String lastMessage;

  ChatRoom(
      {this.id, this.firstUser, this.secondUser, this.bidId, this.lastMessage});

  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    return ChatRoom(
      id: json['_id'][r'$oid'],
      firstUser: json['firstUser'],
      secondUser: json['secondUser'],
      bidId: json['bidId'],
      lastMessage: json['lastMessage'],
    );
  }
}
