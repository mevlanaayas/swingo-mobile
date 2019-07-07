class City {
  final String cityId;
  final String countryId;
  final String iataCode;
  final String name;

  City(
    this.cityId,
    this.countryId,
    this.iataCode,
    this.name,
  );

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      json['city_id'],
      json['country_id'],
      json['iata_code'],
      json['name'],
    );
  }
}
