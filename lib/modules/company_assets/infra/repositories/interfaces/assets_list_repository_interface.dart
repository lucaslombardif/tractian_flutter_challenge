import '../../../domain/entities/asset_entity.dart';

abstract class AssetsListRepositoryInterface {
  Future<List<AssetEntity>> getAssets(String companyId);
}
