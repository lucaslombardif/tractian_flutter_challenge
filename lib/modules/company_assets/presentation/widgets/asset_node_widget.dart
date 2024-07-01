import 'package:flutter/material.dart';

import '../../../../shared/presentation/theme/app_icons.dart';
import '../../domain/entities/asset_entity.dart';

class AssetNodeWidget extends StatelessWidget {
  final AssetEntity asset;
  final int level;

  const AssetNodeWidget({
    super.key,
    required this.asset,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    bool hasChildren = asset.subAssets != null && asset.subAssets!.isNotEmpty;
    return Padding(
      padding: EdgeInsets.only(left: 8.0 * level),
      child: hasChildren
          ? ExpansionTile(
              key: PageStorageKey<String>(asset.id),
              title: Row(
                children: [
                  _getAssetIcon(asset),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(asset.name),
                        ),
                        _getStatusTypeIcon(asset),
                      ],
                    ),
                  ),
                ],
              ),
              children: [
                if (asset.subAssets != null)
                  ...asset.subAssets!.map((subAsset) => AssetNodeWidget(
                        asset: subAsset,
                        level: level + 1,
                      )),
              ],
            )
          : ListTile(
              leading: _getAssetIcon(asset),
              title: Row(
                children: [
                  Expanded(
                    child: Text(asset.name),
                  ),
                  _getStatusTypeIcon(asset),
                ],
              ),
            ),
    );
  }

  Widget _getStatusTypeIcon(AssetEntity asset) {
    if (asset.isCritical) {
      return const Padding(
        padding: EdgeInsets.only(left: 8.0),
        child: Icon(Icons.circle, color: Colors.red, size: 12.0),
      );
    } else if (asset.isEnergy) {
      return const Padding(
        padding: EdgeInsets.only(left: 8.0),
        child: Icon(Icons.bolt, color: Colors.green, size: 22.0),
      );
    }
    return Container();
  }

  Image _getAssetIcon(AssetEntity asset) {
    if (asset.isComponent) {
      return Image.asset(
        AppIcons.component,
        width: 24,
        height: 24,
      );
    } else {
      return Image.asset(
        AppIcons.asset,
        width: 24,
        height: 24,
      );
    }
  }
}
