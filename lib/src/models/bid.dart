import 'package:swingo/src/models/models.dart';
import 'package:swingo/src/classes/SwModel.dart';

class Bid {
  final int id;
  final Order transceiver;
  final Order transporter;
  final User bidder;
  final double price;
  final String status;
  final DateTime created_at;
  final String created_by;
  final DateTime updated_at;
  final String updated_by;
  final DateTime deleted_at;
  final String deleted_by;
  final bool is_deleted;

  Bid(
    this.id,
    this.transceiver,
    this.transporter,
    this.bidder,
    this.price,
    this.status,
    this.created_at,
    this.created_by,
    this.updated_at,
    this.updated_by,
    this.deleted_at,
    this.deleted_by,
    this.is_deleted,
  );

  factory Bid.fromJson(Map<String, dynamic> json) {
    return Bid(
      json['id'],
      json['transceiver'] != null ? Order.fromJson(json['transceiver']) : null,
      json['transporter'] != null ? Order.fromJson(json['transporter']) : null,
      //User.fromJson(json['bidder']), //TODO: backend username yolladığında düzeltilecek.
      User(id: json['bidder'], username: json['created_by']),
      json['price'],
      json['status'],
      SwModel.parseDate(json['created_at']),
      json['created_by'],
      SwModel.parseDate(json['updated_at']),
      json['updated_by'],
      SwModel.parseDate(json['deleted_at']),
      json['deleted_by'],
      json['is_deleted'],
    );
  }
}
