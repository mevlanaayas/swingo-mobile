import 'package:swingo/src/models/models.dart';

class Match {
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

  Match(
      {this.id,
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
      this.updated_by});
}
