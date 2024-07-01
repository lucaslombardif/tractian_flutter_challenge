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
    return (response.data as List)
        .map((asset) => AssetEntity.fromJson(asset))
        .toList();
  }
}
