import 'package:get/get.dart';

import '../../domain/entities/asset_entity.dart';
import '../../domain/entities/location_entity.dart';
import '../../domain/usecases/interfaces/assets_list_usecase_interface.dart';
import '../../domain/usecases/interfaces/locations_list_usecase_interface.dart';

class AssetsController extends GetxController
    with StateMixin<List<LocationEntity>> {
  final AssetsListUsecaseInterface _assetsListUsecase;
  final LocationsListUsecaseInterface _locationsListUsecase;
  List<AssetEntity> assets = [];
  List<LocationEntity> locations = [];
  List<LocationEntity> locationsFormatted = [];
  List<LocationEntity> filteredLocations = [];
  List<AssetEntity> filteredAssets = [];

  var filterText = ''.obs;
  var filterEnergy = false.obs;
  var filterCritical = false.obs;

  AssetsController(
      {required AssetsListUsecaseInterface assetsListUsecase,
      required LocationsListUsecaseInterface locationsListUsecase})
      : _assetsListUsecase = assetsListUsecase,
        _locationsListUsecase = locationsListUsecase,
        filterEnergy = false.obs, 
        filterCritical = false.obs;

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
        if (location.parentId != null &&
            locationMap.containsKey(location.parentId)) {
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
      filteredLocations = List.from(locationsFormatted);

      filteredAssets = assetMap.values
          .where((asset) => asset.locationId == null && asset.parentId == null)
          .toList();

      change(filteredLocations, status: RxStatus.success());
    } catch (e) {
      change([], status: RxStatus.error('Failed to fetch data'));
    }
  }

  void applyFilters() {
    List<LocationEntity> tempLocations = List.from(locationsFormatted);
    List<AssetEntity> tempAssets = List.from(assets);

    if (filterText.isNotEmpty || filterEnergy.value || filterCritical.value) {
      List<LocationEntity> locationResult = [];
      List<AssetEntity> assetResult = [];
      for (var location in locationsFormatted) {
        var filteredLocation = _filterLocation(location);
        if (filteredLocation != null) {
          locationResult.add(filteredLocation);
        }
      }
      for (var asset in assets) {
        var filteredAsset = _filterAsset(asset);
        if (filteredAsset != null) {
          assetResult.add(filteredAsset);
        }
      }
      tempAssets = assetResult;
      tempLocations = locationResult;
    }

    filteredLocations = tempLocations;
    filteredAssets = tempAssets;
    change(filteredLocations, status: RxStatus.success());
  }

  LocationEntity? _filterLocation(LocationEntity location) {
    bool matchesFilter =
        location.name.toLowerCase().contains(filterText.value.toLowerCase());

    List<AssetEntity>? locationFilteredAssets = location.assets
        ?.where((asset) =>
            asset.name.toLowerCase().contains(filterText.value.toLowerCase()) ||
            (filterEnergy.value && asset.isEnergy) ||
            (filterCritical.value && asset.isCritical) ||
            _hasSubAssetMatchingFilter(asset))
        .toList();

    List<LocationEntity>? filteredSubLocations = location.subLocations
        ?.map((subLoc) => _filterLocation(subLoc))
        .where((subLoc) => subLoc != null)
        .toList()
        .cast<LocationEntity>();

    if (matchesFilter ||
        (locationFilteredAssets != null && locationFilteredAssets.isNotEmpty) ||
        (filteredSubLocations != null && filteredSubLocations.isNotEmpty)) {
      return LocationEntity(
        id: location.id,
        name: location.name,
        parentId: location.parentId,
        subLocations: filteredSubLocations,
        assets: locationFilteredAssets,
      );
    }

    return null;
  }

  AssetEntity? _filterAsset(AssetEntity asset) {
    bool matchesFilter =
        asset.name.toLowerCase().contains(filterText.value.toLowerCase());

    List<AssetEntity>? filteredSubAssets = asset.subAssets
        ?.where((asset) =>
            asset.name.toLowerCase().contains(filterText.value.toLowerCase()) ||
            (filterEnergy.value && asset.isEnergy) ||
            (filterCritical.value && asset.isCritical) ||
            _hasSubAssetMatchingFilter(asset))
        .toList();

    if (matchesFilter) {
      return AssetEntity(
        id: asset.id,
        name: asset.name,
        subAssets: filteredSubAssets,
        parentId: asset.parentId,
        status: asset.status,
        locationId: asset.locationId,
        sensorType: asset.sensorType,
      );
    }
    return null;
  }

  bool _hasSubAssetMatchingFilter(AssetEntity asset) {
    if (asset.name.toLowerCase().contains(filterText.value.toLowerCase()) ||
        (filterEnergy.value && asset.isEnergy) ||
        (filterCritical.value && asset.isCritical)) {
      return true;
    }

    if (asset.subAssets != null) {
      for (var subAsset in asset.subAssets!) {
        if (_hasSubAssetMatchingFilter(subAsset)) {
          return true;
        }
      }
    }

    return false;
  }
}
