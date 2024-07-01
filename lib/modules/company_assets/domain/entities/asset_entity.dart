class AssetEntity {
  final String id;
  final String name;
  final String? locationId;
  final String? gatewayId;
  final String? parentId;
  final String? sensorId;
  final String? sensorType;
  final String? status;
  List<AssetEntity>? subAssets;

  AssetEntity({
    required this.id,
    required this.name,
    this.locationId,
    this.gatewayId,
    this.parentId,
    this.sensorId,
    this.sensorType,
    this.status,
    this.subAssets,
  });

  bool get isComponent => sensorType != null && status != null;
  bool get isCritical => status != null && status == 'alert';
  bool get isEnergy => sensorType != null && status != null && status == 'operating';
  

  factory AssetEntity.fromJson(Map<String, dynamic> json) {
    return AssetEntity(
      id: json['id'],
      name: json['name'],
      locationId: json['locationId'],
      gatewayId: json['gatewayId'],
      parentId: json['parentId'],
      sensorId: json['sensorId'],
      sensorType: json['sensorType'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'locationId': locationId,
      'gatewayId': gatewayId,
      'parentId': parentId,
      'sensorId': sensorId,
      'sensorType': sensorType,
      'status': status,
      'subAssets': subAssets?.map((asset) => asset.toJson()).toList(),
    };
  }

  void addSubAsset(AssetEntity subAsset) {
    subAssets ??= [];
    subAssets!.add(subAsset);
  }
}
