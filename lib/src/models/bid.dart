import 'package:swingo/src/models/models.dart';

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
      {this.id,
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
      this.is_deleted});
}
