import 'package:flutter/material.dart';

import '../../../../shared/presentation/theme/app_icons.dart';
import '../../domain/entities/location_entity.dart';
import 'asset_node_widget.dart';

class LocationNodeWidget extends StatelessWidget {
  final LocationEntity location;
  final int level;

  const LocationNodeWidget({
    super.key,
    required this.location,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    bool hasChildren =
        (location.subLocations != null && location.subLocations!.isNotEmpty) ||
            (location.assets != null && location.assets!.isNotEmpty);

    return Padding(
      padding: EdgeInsets.only(left: 12.0 * level),
      child: hasChildren
          ? ExpansionTile(
              key: PageStorageKey<String>(location.id),
              title: Row(
                children: [
                  Image.asset(
                    AppIcons.location,
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Text(location.name),
                  ),
                ],
              ),
              children: [
                if (location.subLocations != null)
                  ...location.subLocations!.map((subLoc) => LocationNodeWidget(
                        location: subLoc,
                        level: level + 1,
                      )),
                if (location.assets != null)
                  ...location.assets!.map((asset) => AssetNodeWidget(
                        asset: asset,
                        level: level + 1,
                      )),
              ],
            )
          : ListTile(
              leading: Image.asset(
                AppIcons.location,
                width: 24,
                height: 24,
              ),
              title: Text(location.name),
            ),
    );
  }
}
