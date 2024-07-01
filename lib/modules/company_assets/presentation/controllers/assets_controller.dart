import 'package:get/get.dart';
import 'package:tractian_flutter_challenge/modules/company_assets/domain/entities/asset_entity.dart';
import 'package:tractian_flutter_challenge/modules/company_assets/domain/entities/location_entity.dart';
import 'package:tractian_flutter_challenge/modules/company_assets/domain/usecases/interfaces/assets_list_usecase_interface.dart';
import 'package:tractian_flutter_challenge/modules/company_assets/domain/usecases/interfaces/locations_list_usecase_interface.dart';

class AssetsController extends GetxController
    with StateMixin<List<LocationEntity>> {
  final AssetsListUsecaseInterface _assetsListUsecase;
  final LocationsListUsecaseInterface _locationsListUsecase;
  List<AssetEntity> assets = [];
  List<AssetEntity> assetsFormatted = [];
  List<LocationEntity> locations = [];
  List<LocationEntity> locationsFormatted = [];

  AssetsController(
      {required AssetsListUsecaseInterface assetsListUsecase,
      required LocationsListUsecaseInterface locationsListUsecase})
      : _assetsListUsecase = assetsListUsecase,
        _locationsListUsecase = locationsListUsecase;

  Future<void> getLocationsAndAssets(String companyId) async {
    change(locationsFormatted, status: RxStatus.loading());
    try {
      locations = await _locationsListUsecase(companyId);
      assets = await _assetsListUsecase(companyId);

      Map<String, LocationEntity> locationMap = {};
      Map<String, AssetEntity> assetMap = {};

      for (var location in locations) {
        locationMap[location.id] = location;
      }

      for (var asset in assets) {
        assetMap[asset.id] = asset;
        if (asset.locationId != null &&
            locationMap.containsKey(asset.locationId)) {
          locationMap[asset.locationId]!.addAsset(asset);
        }
      }

      for (var location in locations) {
        if (location.parentId != null && locationMap.containsKey(location.parentId)) {
          locationMap[location.parentId]!.addSubLocation(location);
        }
      }

      for (var asset in assets) {
        if (asset.parentId != null && assetMap.containsKey(asset.parentId)) {
          assetMap[asset.parentId]!.addSubAsset(asset);
        }
      }

      locationsFormatted =
          locationMap.values.where((loc) => loc.parentId == null).toList();

      change(locationsFormatted, status: RxStatus.success());
    } catch (e) {
      change([], status: RxStatus.error('Failed to fetch data'));
    }
  }
}
