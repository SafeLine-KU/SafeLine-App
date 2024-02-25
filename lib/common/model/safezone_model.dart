class SafeZone {
  final String name;
  final double latitude;
  final double longitude;
  final String address;
  final String area;
  final double distance;
  final int groundFloor;
  final int basementFloor;

  SafeZone({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.area,
    required this.distance,
    required this.groundFloor,
    required this.basementFloor,
  });

  factory SafeZone.fromJson(Map<String, dynamic> json) {
    return SafeZone(
      name: json['name'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      address: json['address'],
      area: json['area'],
      distance: json['distance'],
      groundFloor: json['ground_floor'],
      basementFloor: json['basement_floor'],
    );
  }
}
