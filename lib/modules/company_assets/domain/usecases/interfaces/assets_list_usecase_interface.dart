import '../../entities/asset_entity.dart';

abstract class AssetsListUsecaseInterface {
  Future<List<AssetEntity>> call(String companyId);
}
