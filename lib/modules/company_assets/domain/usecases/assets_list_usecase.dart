import 'package:tractian_flutter_challenge/modules/company_assets/domain/entities/asset_entity.dart';
import 'package:tractian_flutter_challenge/modules/company_assets/domain/usecases/interfaces/assets_list_usecase_interface.dart';
import 'package:tractian_flutter_challenge/modules/company_assets/infra/repositories/assets_list_repository.dart';

class AssetsListUsecase implements AssetsListUsecaseInterface {
  final AssetsListRepository _getAssetsRepository;

  AssetsListUsecase({required AssetsListRepository getAssetsRepository})
      : _getAssetsRepository = getAssetsRepository;

  @override
  Future<List<AssetEntity>> call(String companyId) async{
    return await _getAssetsRepository.getAssets(companyId);
  }
}
