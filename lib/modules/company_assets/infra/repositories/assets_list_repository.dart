import 'dart:isolate';

import '../../../../shared/infra/services/http_service.dart';
import '../../domain/entities/asset_entity.dart';
import 'interfaces/assets_list_repository_interface.dart';

class AssetsListRepository implements AssetsListRepositoryInterface {
  final HttpService _httpService;

  AssetsListRepository({required HttpService httpService})
      : _httpService = httpService;

  @override
  Future<List<AssetEntity>> getAssets(String companyId) async {
    final response = await _httpService.get('/companies/$companyId/assets');
    final allAssets = await Isolate.run<List<AssetEntity>>(() { 
      final List<AssetEntity> assets = (response.data as List)
        .map((asset) => AssetEntity.fromJson(asset))
        .toList();
        return assets;
    });
    return allAssets;
  }
}
