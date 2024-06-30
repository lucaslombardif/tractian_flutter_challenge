import 'asset_entity.dart';

class LocationEntity {
  final String id;
  final String name;
  final String? parentId;
  final List<LocationEntity>? subLocations;
  final List<AssetEntity>? assets;

  const LocationEntity({
    required this.id,
    required this.name,
    this.parentId,
    this.subLocations,
    this.assets,
  });

  factory LocationEntity.fromJson(Map<String, dynamic> json) {
    return LocationEntity(
      id: json['id'],
      name: json['name'],
      parentId: json['parentId']!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'parentId': parentId!,
    };
  }
}
