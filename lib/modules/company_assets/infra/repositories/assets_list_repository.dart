import 'package:tractian_flutter_challenge/modules/company_assets/domain/entities/asset_entity.dart';
import 'package:tractian_flutter_challenge/modules/company_assets/infra/repositories/interfaces/assets_list_repository_interface.dart';

import '../../../../shared/infra/services/http_service.dart';

class AssetsListRepository implements AssetsListRepositoryInterface {
  final HttpService _httpService;

  AssetsListRepository({required HttpService httpService})
      : _httpService = httpService;

  @override
  Future<List<AssetEntity>> getAssets(String companyId) async {
    final response = await _httpService.get('/companies/$companyId/assets');
    return (response.data as List)
        .map((asset) => AssetEntity.fromJson(asset))
        .toList();
  }
}
