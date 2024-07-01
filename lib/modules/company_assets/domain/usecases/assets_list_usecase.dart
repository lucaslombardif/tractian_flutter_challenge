import '../../infra/repositories/assets_list_repository.dart';
import '../entities/asset_entity.dart';
import 'interfaces/assets_list_usecase_interface.dart';

class AssetsListUsecase implements AssetsListUsecaseInterface {
  final AssetsListRepository _getAssetsRepository;

  AssetsListUsecase({required AssetsListRepository getAssetsRepository})
      : _getAssetsRepository = getAssetsRepository;

  @override
  Future<List<AssetEntity>> call(String companyId) async {
    return await _getAssetsRepository.getAssets(companyId);
  }
}
