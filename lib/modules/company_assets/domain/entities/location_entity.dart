import 'asset_entity.dart';

class LocationEntity {
  final String id;
  final String name;
  final String? parentId;
  List<AssetEntity>? assets;
  List<LocationEntity>? subLocations;
  bool? isComponent;

  LocationEntity({
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
      parentId: json['parentId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'parentId': parentId,
      'subLocations':
          subLocations?.map((location) => location.toJson()).toList(),
      'assets': assets?.map((asset) => asset.toJson()).toList(),
    };
  }

  void addSubLocation(LocationEntity subLocation) {
    subLocations ??= [];
    subLocations!.add(subLocation);
  }

  void addAsset(AssetEntity asset) {
    assets ??= [];
    assets!.add(asset);
  }
}
