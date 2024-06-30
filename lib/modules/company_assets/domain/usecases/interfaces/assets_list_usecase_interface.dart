import 'package:tractian_flutter_challenge/modules/company_assets/domain/entities/asset_entity.dart';

abstract class AssetsListUsecaseInterface { 
  Future<List<AssetEntity>> call(String companyId);
}