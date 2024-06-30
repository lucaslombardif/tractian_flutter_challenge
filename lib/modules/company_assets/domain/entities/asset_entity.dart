class AssetEntity {
  final String id;
  final String name;
  final String? locationId;
  final String? gatewayId;
  final String? parentId;
  final String? sensorId;
  final String? sensorType;
  final String? status;

  AssetEntity({
    required this.id,
    required this.name,
    this.locationId,
    this.gatewayId,
    this.parentId,
    this.sensorId,
    this.sensorType,
    this.status,
  });

  factory AssetEntity.fromJson(Map<String, dynamic> json) {
    return AssetEntity(
      id: json['id'],
      name: json['id'],
      locationId: json['locationId']!,
      gatewayId: json['gatewayId']!,
      parentId: json['parentId']!,
      sensorId: json['sensorId']!,
      sensorType: json['sensorType']!,
      status: json['status']!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'locationId': locationId!,
      'gatewayId': gatewayId!,
      'parentId': parentId!,
      'sensorId': sensorId!,
      'sensorType': sensorType!,
      'status': status!,
    };
  }
}
