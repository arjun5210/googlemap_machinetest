class Site {
  final int id;
  final int userId;
  final String siteName;
  final String description;
  final String price;
  final String latitude;
  final String longitude;

  Site({
    required this.id,
    required this.userId,
    required this.siteName,
    required this.description,
    required this.price,
    required this.latitude,
    required this.longitude,
  });

  factory Site.fromJson(Map<String, dynamic> json) {
    return Site(
      id: json['id'],
      userId: json['user_id'],
      siteName: json['site_name'],
      description: json['description'],
      price: json['price'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}
