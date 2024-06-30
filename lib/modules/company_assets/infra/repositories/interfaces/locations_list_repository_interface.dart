import 'package:tractian_flutter_challenge/modules/company_assets/domain/entities/location_entity.dart';

abstract class LocationsListRepositoryInterface { 
  Future<List<LocationEntity>> getLocations(String companyId);
}