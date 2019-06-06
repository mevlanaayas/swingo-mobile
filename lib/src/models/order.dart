class Order {
  final int id;
  final String from_city;
  final DateTime from_date;
  final String to_city;
  final DateTime to_date;
  final double price;
  final String size;
  final double weight;
  final String comments;
  final String status;
  final DateTime created_at;
  final String created_by;
  final DateTime updated_at;
  final String updated_by;
  final DateTime deleted_at;
  final String deleted_by;
  final bool is_deleted;

  Order(
      this.id,
      this.from_city,
      this.from_date,
      this.to_city,
      this.to_date,
      this.price,
      this.size,
      this.weight,
      this.comments,
      this.status,
      this.created_at,
      this.created_by,
      this.updated_at,
      this.updated_by,
      this.deleted_at,
      this.deleted_by,
      this.is_deleted);
}
