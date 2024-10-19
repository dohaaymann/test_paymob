class Address {
  double latitude;
  double longitude;
  String city;
  String country;
  String line1;
  String postalCode;
  String state;

  Address({
    required this.latitude,
    required this.longitude,
    required this.city,
    required this.country,
    required this.line1,
    required this.postalCode,
    required this.state,
  });

  // Factory method to create Address object from JSON
  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      latitude: json['latitude'],
      longitude: json['longitude'],
      city: json['city'],
      country: json['country'],
      line1: json['line1'],
      postalCode: json['postalCode'],
      state: json['state'],
    );
  }

  // Method to convert Address object to JSON
  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'city': city,
      'country': country,
      'line1': line1,
      'postalCode': postalCode,
      'state': state,
    };
  }
}
