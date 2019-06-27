import 'package:swingo/src/models/models.dart';

class SwMatch {
  final int id;
  final User carrier;
  final User purchaser;
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

  SwMatch(
    this.id,
    this.carrier,
    this.purchaser,
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
  );

  factory SwMatch.fromJson(Map<String, dynamic> json) {
    return SwMatch(
      json['id'],
      User(id: json['carrier']['id'], username: json['carrier']['username']),
      User(id: json['purchaser']['id'], username: json['purchaser']['username']),
      json['from_address'],
      json['to_address'],
      json['value'],
      json['payment_type'],
      json['fail_reason'],
      json['status'],
      DateTime.parse(json['created_at']),
      json['created_by'],
      DateTime.parse(json['updated_at']),
      json['updated_by'],
    );
  }
}
