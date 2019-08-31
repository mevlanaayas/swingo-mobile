import 'package:swingo/src/models/models.dart';

class SwMatch {
  final int id;
  final User carrier;
  final User sender;
  final Order sendOrder;
  final Order carryOrder;
  final String fromAddress;
  final String toAddress;
  final double value;
  final String paymentType;
  final String failReason;
  final String status;
  final DateTime created_at;
  final String created_by;
  final DateTime updated_at;
  final String updated_by;
  final String chatRoomId;

  SwMatch(
    this.id,
    this.carrier,
    this.sender,
    this.sendOrder,
    this.carryOrder,
    this.fromAddress,
    this.toAddress,
    this.value,
    this.paymentType,
    this.failReason,
    this.status,
    this.created_at,
    this.created_by,
    this.updated_at,
    this.updated_by,
    this.chatRoomId,
  );

  get order {
    return this.sendOrder != null ? this.sendOrder : this.carryOrder;
  }

  factory SwMatch.fromJson(Map<String, dynamic> json) {
    final Order sendOrder =
        json['send_order'] != null ? Order.fromJson(json['send_order']) : null;
    final Order carryOrder = json['carry_order'] != null
        ? Order.fromJson(json['carry_order'])
        : null;
    final String paymentType =
        json['payment_type'] != null ? json['payment_type'] : '';

    return SwMatch(
      json['id'],
      User.fromJson(json['carrier']),
      User.fromJson(json['sender']),
      sendOrder,
      carryOrder,
      json['from_address'],
      json['to_address'],
      json['value'],
      paymentType,
      json['fail_reason'],
      json['status'],
      DateTime.parse(json['created_at']),
      json['created_by'],
      DateTime.parse(json['updated_at']),
      json['updated_by'],
      json['chat_room_id'],
    );
  }

  static toSenderJson(double price, int orderId) {
    return '{'
        '"value": "${price}",'
        '"carry_order": "${orderId}"}';
  }

  static toCarrierJson(int orderId) {
    return '{'
        '"value": "${11}",' //TODO: geçici süreliğine yapıldı.
        '"send_order": "${orderId}"}';
  }
}
