import 'package:flutter/material.dart';

import '../../domain/entities/asset_entity.dart';
import '../../domain/entities/location_entity.dart';
import 'asset_node_widget.dart';
import 'location_node_widget.dart';

class TreeNodeWidget extends StatelessWidget {
  final List<LocationEntity> locations;
  final List<AssetEntity> assets;

  const TreeNodeWidget({
    super.key,
    required this.locations,
    required this.assets,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      clipBehavior: Clip.none,
      children: _buildTreeNodes(locations, assets, 0),
    );
  }

  List<Widget> _buildTreeNodes(
      List<LocationEntity> locations, List<AssetEntity> assets, int level) {
        
    locations.sort((a, b) {
      int aCount = (a.subLocations?.length ?? 0) + (a.assets?.length ?? 0);
      int bCount = (b.subLocations?.length ?? 0) + (b.assets?.length ?? 0);
      return bCount.compareTo(aCount);
    });

    List<Widget> nodes = [];
    for (var location in locations) {
      nodes.add(LocationNodeWidget(location: location, level: level));
    }

    assets
        .where((asset) => asset.locationId == null && asset.parentId == null)
        .forEach((asset) {
      nodes.add(AssetNodeWidget(asset: asset, level: level));
    });

    return nodes;
  }
}
